import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/request/cart/add_product_to_cart.dart';
import 'package:job_task/data/model/request/cart/update_cart_request.dart';
import 'package:job_task/data/model/response/cart_entity.dart';
import 'package:job_task/data/model/response/faviorate_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:job_task/data/model/request/faviorate/add_to_fav_request.dart';
@singleton
class SqlLiteConnection {
  Database? _database;

  /// Runs [action] and wraps the outcome: Success(data) on success,
  /// Failure(error) on any exception (DB error, not-open, etc.).
  Future<ApiResult<T>> _run<T>(
      String operation,
      Future<T> Function() action,
      ) async {
    try {
      final data = await action();
      return Success<T>(data: data);
    } on DatabaseException catch (e) {
      return Failure<T>(error: 'Database error during $operation: $e');
    } catch (e) {
      return Failure<T>(error: 'Unexpected error during $operation: $e');
    }
  }

  /// Opens (recreating) the database. Left as a plain Future because it's a
  /// lifecycle call (awaited in main); wrap the call site if you want to
  /// handle its failure there.
  Future<void> open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'ecommerce_app.db');

    // Delete the database so we start fresh (drop this line to persist data).

    _database = await openDatabase(
      path,
      version: 1,

      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Favorites ('
              'id INTEGER PRIMARY KEY, '
              'product_id INTEGER UNIQUE, '
              'is_fav INTEGER NOT NULL DEFAULT 1, '
              'name TEXT, '
              'image TEXT, '
              'price TEXT, '
              'value INTEGER, '
              'created_date TEXT DEFAULT CURRENT_TIMESTAMP, '
              'updated_date TEXT DEFAULT CURRENT_TIMESTAMP)',
        );

        await db.execute(
          'CREATE TABLE Carts ('
              'id INTEGER PRIMARY KEY, '
              'product_id INTEGER UNIQUE, '
              'quantity INTEGER NOT NULL DEFAULT 1, '
              'name TEXT, '
              'value INTEGER, '
              'image TEXT, '
              'price TEXT, '
              'created_date TEXT DEFAULT CURRENT_TIMESTAMP, '
              'updated_date TEXT DEFAULT CURRENT_TIMESTAMP)',
        );
      },
    );
  }

  /// Returns the open database or throws if open() hasn't been called.
  /// (The throw is caught by _run and converted to a Failure.)
  Database _requireDb() {
    final db = _database;
    if (db == null) {
      throw StateError('Call open() before using the database.');
    }
    return db;
  }

  // ---------------- Favorites ----------------

  Future<ApiResult<int>> addFavoriteRequest(AddToFavRequest request) =>
      _run('addFavoriteRequest', () async {
        final db = _requireDb();
        return db.insert(
          'Favorites',
          request.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });

  Future<ApiResult<int>> removeFavorite(int productId) =>
      _run('removeFavorite', () async {
        final db = _requireDb();
        return db.delete(
          'Favorites',
          where: 'product_id = ?',
          whereArgs: [productId],
        );
      });

  Future<ApiResult<List<FavoriteEntity>>> getFavorites() =>
      _run('getFavorites', () async {
        final db = _requireDb();

        final rows = await db.query('Favorites', orderBy: 'created_date DESC');
        return rows.map((row) => FavoriteEntity.fromMap(row)).toList();

      });

  // ---------------- Cart ----------------

  Future<ApiResult<int>> addToCartRequest(AddProductToCartRequest request) =>
      _run('addToCartRequest', () async {
        final db = _requireDb();
        return db.insert(
          'Carts',
          request.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });

  Future<ApiResult<int>> updateCartItem(UpdateCartRequest request) =>
      _run('updateCartItem', () async {
        final db = _requireDb();
        return db.update(
          'Carts',
          request.toMap(),
          where: 'id = ?',
          whereArgs: [request.id],
        );
      });

  Future<ApiResult<int>> removeFromCart(int productId) =>
      _run('removeFromCart', () async {
        final db = _requireDb();
        return db.delete(
          'Carts',
          where: 'product_id = ?',
          whereArgs: [productId],
        );
      });

  Future<ApiResult<List<CartEntity>>> getCartItems() =>
      _run('getCartItems', () async {
        final db = _requireDb();
        final rows = await db.query('Carts', orderBy: 'created_date DESC');
        return rows.map((row) => CartEntity.fromMap(row)).toList();
      });
  Future<ApiResult<bool>> isInCart(int productId) =>
      _run('isInCart', () async {
        final db = _requireDb();
        final rows = await db.query(
          'Carts',
          columns: ['id'],           // only need to know it exists
          where: 'product_id = ?',
          whereArgs: [productId],
          limit: 1,                  // stop at the first match
        );
        return rows.isNotEmpty;
      });
  Future<ApiResult<bool>> isInFaviorate(int productId) =>
      _run('isInCart', () async {
        final db = _requireDb();
        final rows = await db.query(
          'Favorites',
          columns: ['id'],           // only need to know it exists
          where: 'product_id = ?',
          whereArgs: [productId],
          limit: 1,                  // stop at the first match
        );
        return rows.isNotEmpty;
      });
  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}