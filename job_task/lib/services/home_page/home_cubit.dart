import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart' show Success, Failure;
import 'package:job_task/core/get_it/configure_dependency.dart';
import 'package:job_task/data/model/request/cart/add_product_to_cart.dart';
import 'package:job_task/data/model/request/cart/update_cart_request.dart';
import 'package:job_task/data/model/request/faviorate/add_to_fav_request.dart';

import 'package:job_task/data/model/response/cart_entity.dart';
import 'package:job_task/data/model/response/favorite_entity.dart';
import 'package:job_task/data/model/response/product_entity.dart';
import 'package:job_task/domain/use_cases/cart/add_cart_to_product_use_case.dart';
import 'package:job_task/domain/use_cases/cart/check_product_in_cart_use_case.dart';
import 'package:job_task/domain/use_cases/cart/get_cart_use_case.dart';
import 'package:job_task/domain/use_cases/cart/remove_product_from_cart_use_case.dart';
import 'package:job_task/domain/use_cases/cart/update_cart_item_use_case.dart';
import 'package:job_task/domain/use_cases/faviorate/add_product_fav_use_case.dart';
import 'package:job_task/domain/use_cases/faviorate/check_product_in_fav_use_case.dart';
import 'package:job_task/domain/use_cases/faviorate/get_fav_use_case.dart';
import 'package:job_task/domain/use_cases/faviorate/remove_product_from_fav_use_case.dart';
import 'package:job_task/domain/use_cases/get_product_use_case.dart';
import 'package:job_task/services/home_page/home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(GetHomeInitialState());

  final GetProductUseCase getProductUseCase = getIt<GetProductUseCase>();
  final GetCartUseCase getCartUseCase = getIt<GetCartUseCase>();
  final AddCartToProductUseCase addCartItemUseCase =
  getIt<AddCartToProductUseCase>();
  final UpdateCartItemUseCase updateCartItemUseCase =
  getIt<UpdateCartItemUseCase>();
  final RemoveCartItemUseCase removeCartItemUseCase =
  getIt<RemoveCartItemUseCase>();
  final CheckProductInCartUseCase checkProductInCartUseCase =
  getIt<CheckProductInCartUseCase>();

  final GetFavUseCase getFavUseCase = getIt<GetFavUseCase>();
  final AddProductToFavUseCase addProductToFavUseCase =
  getIt<AddProductToFavUseCase>();
  final RemoveProductFromFavUseCase removeProductFromFavUseCase =
  getIt<RemoveProductFromFavUseCase>();
  final CheckProductInFavUseCase checkProductInFavUseCase =
  getIt<CheckProductInFavUseCase>();

  static HomeCubit get(BuildContext context) =>
      BlocProvider.of<HomeCubit>(context);

  List<ProductEntity> _allProducts = [];
  List<CartEntity> _cart = [];
  List<FavoriteEntity> _favorites = [];

  String _searchQuery = '';
  String _selectedCategory = 'All';

  /// Derived from the DB-backed favorites list — used by the home grid hearts.
  Set<int> get _favoriteIds => _favorites.map((f) => f.productId).toSet();

  /// True if this product already has a row in the cart (local snapshot).
  bool isProductInCart(int productId) =>
      _cart.any((c) => c.productId == productId);

  bool isProductFavorite(int productId) => _favoriteIds.contains(productId);

  /// Badge count = number of DISTINCT products in the cart.
  int get cartCount => _cart.length;

  /// Favorites badge — decrements automatically because it reads _favorites,
  /// which removeFavorite refreshes from the DB before re-emitting states.
  int get favoriteCount => _favorites.length;

  double get cartTotal =>
      _cart.fold(0.0, (sum, c) => sum + c.price * c.quantity);

  // ---------------- Products ----------------

  Future<void> loadProducts() async {
    emit(GetHomeLoadingState());

    // Start products (network), cart, and favorites (local DB) together.
    final productFuture = getProductUseCase.execute();
    final cartFuture = getCartUseCase.execute();
    final favFuture = getFavUseCase.execute();

    // Cart & favorites are best-effort — populate on success, ignore failure.
    final cartResult = await cartFuture;
    if (cartResult case Success<List<CartEntity>>(:final data)) {
      _cart = List.of(data);
    }
    final favResult = await favFuture;
    if (favResult case Success<List<FavoriteEntity>>(:final data)) {
      _favorites = List.of(data);
    }

    final productResult = await productFuture;
    switch (productResult) {
      case Success<List<ProductEntity>>(:final data):
        _allProducts = data;
        _emitLoaded(); // badge + in-cart + favorite flags reflect the DB
      case Failure<List<ProductEntity>>(:final error):
        emit(GetHomeFailed(error));
    }
  }

  void search(String query) {
    _searchQuery = query;
    _emitLoaded();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    _emitLoaded();
  }

  // ---------------- Favorites ----------------

  /// Reloads favorites into _favorites WITHOUT emitting favorites states.
  Future<void> _loadFavData() async {
    final result = await getFavUseCase.execute();
    if (result case Success<List<FavoriteEntity>>(:final data)) {
      _favorites = List.of(data);
    }
  }

  /// Heart tap on the home grid / details page. Uses CheckProductInFavUseCase
  /// to decide whether to add or remove, so the DB is the source of truth.
  Future<void> toggleFavorite(int productId) async {
    final product = findLoadedProduct(productId);
    if (product == null) return;

    // Ask the DB whether it's already a favorite; fall back to the local
    // snapshot if the check itself fails.
    var isFav = _favoriteIds.contains(productId);
    final checkResult = await checkProductInFavUseCase.execute(productId);
    if (checkResult case Success<bool>(:final data)) {
      isFav = data;
    }

    // NOTE: call the use case directly here (not removeFavorite) so `result`
    // is a Success/Failure the switch below can match on.
    final result = isFav
        ? await removeProductFromFavUseCase.execute(productId)
        : await addProductToFavUseCase.execute(
      AddToFavRequest(
        productId: product.id,
        name: product.title,
        image: product.image,
        price: product.price.toString(),
        value: 0,
      ),
    );

    switch (result) {
      case Success<int>():
        await _loadFavData(); // hearts + favorite badge reflect the DB
        _emitLoaded();
      case Failure<int>(:final error):
        emit(FailedToUpdateFavoriteError(error));
        _emitLoaded();
    }
  }

  /// Favorites page: load + emit favorites states.
  Future<void> loadFavorites() async {
    emit(FavoritesLoadingState());
    await _refreshFavorites();
  }

  Future<void> _refreshFavorites() async {
    final result = await getFavUseCase.execute();
    switch (result) {
      case Success<List<FavoriteEntity>>(:final data):
        _favorites = List.of(data);
        emit(FavoritesLoadedState(List.unmodifiable(_favorites)));
      case Failure<List<FavoriteEntity>>():
        emit(FavoritesFailed());
    }
  }

  Future<void> removeFavorite(int id) async {
    final result = await removeProductFromFavUseCase.execute(id);
    switch (result) {
      case Success<int>():
        await _refreshFavorites(); // list rebuild + _favorites.length - 1
        _emitLoaded(); // badge decrement + gray heart on the grid
      case Failure<int>(:final error):
        emit(FailedToUpdateFavoriteError(error));
        emit(FavoritesLoadedState(List.unmodifiable(_favorites)));
    }
  }

  Future<void> addFavoriteToCart(FavoriteEntity item) async {
    final checkResult = await checkProductInCartUseCase.execute(item.productId);
    if (checkResult case Success<bool>(data: true)) {
      emit(ProductAlreadyInCart(item.name));
      emit(FavoritesLoadedState(List.unmodifiable(_favorites)));
      return;
    }

    final result = await addCartItemUseCase.execute(
      AddProductToCartRequest(
        productId: item.productId,
        quantity: 1,
        name: item.name,
        image: item.image,
        price: item.price.toString(),
        value: item.value,
      ),
    );

    switch (result) {
      case Success<int>():
        await _loadCartData(); // badge +1
        emit(AddedProductSuccessToCart(List.unmodifiable(_cart)));
        emit(FavoritesLoadedState(List.unmodifiable(_favorites)));
      case Failure<int>(:final error):
        emit(FailedToAddedProductError(error));
        emit(FavoritesLoadedState(List.unmodifiable(_favorites)));
    }
  }

  Future<void> _loadCartData() async {
    final result = await getCartUseCase.execute();
    if (result case Success<List<CartEntity>>(:final data)) {
      _cart = List.of(data);
    }
  }

  Future<void> syncCart() async {
    await _loadCartData();
    _emitLoaded();
  }
  Future<void> addToCart(ProductEntity product) async {
    var alreadyInCart = isProductInCart(product.id); // fallback
    final checkResult = await checkProductInCartUseCase.execute(product.id);
    if (checkResult case Success<bool>(:final data)) {
      alreadyInCart = data;
    }

    if (alreadyInCart) {
      emit(ProductAlreadyInCart(product.title));
      _emitLoaded(); // keep the grid on screen after the transient state
      return;
    }

    emit(AddProductToCartLoading());
    final request = AddProductToCartRequest(
      productId: product.id,
      quantity: 1,
      name: product.title,
      image: product.image,
      price: product.price.toString(),
      value: 0,
    );

    final result = await addCartItemUseCase.execute(request);
    switch (result) {
      case Success<int>():
        await _loadCartData(); // refresh so the badge count updates (+1 product)
        emit(AddedProductSuccessToCart(List.unmodifiable(_cart)));
        _emitLoaded();
      case Failure<int>(:final error):
        emit(FailedToAddedProductError(error));
        _emitLoaded();
    }
  }

  // ---------------- Cart page ----------------

  Future<void> loadCart() async {
    emit(CartLoadingState());
    await _refreshCart();
  }

  Future<void> _refreshCart() async {
    final result = await getCartUseCase.execute();
    switch (result) {
      case Success<List<CartEntity>>(:final data):
        _cart = List.of(data);
        emit(CartLoadedState(List.unmodifiable(_cart)));
      case Failure<List<CartEntity>>():
        emit(CartFailed());
    }
  }

  Future<void> changeQuantity(CartEntity item, int newQuantity) async {
    if (newQuantity < 1) return;
    final result = await updateCartItemUseCase.execute(
      UpdateCartRequest(id: item.id, quantity: newQuantity),
    );
    switch (result) {
      case Success<int>():
        await _refreshCart();
      case Failure<int>(:final error):
        emit(FailedToUpdateProductError(error));
    }
  }
  /// Remove from cart by PRODUCT id (used by the details page).
  Future<void> removeCartByProductId(int productId) async {
    final result = await removeCartItemUseCase.execute(productId);
    switch (result) {
      case Success<int>():
        await _loadCartData();  // snapshot: item gone, badge -1
        _emitLoaded();          // button flips back to "Add to Cart"
      case Failure<int>(:final error):
        emit(FailedToUpdateProductError(error));
    }
  }

  Future<void> removeCartItem(CartEntity item) async {
    final result = await removeCartItemUseCase.execute(item.productId);
    switch (result) {
      case Success<int>():
        await _refreshCart(); // badge drops by one product
      case Failure<int>(:final error):
        emit(FailedToUpdateProductError(error));
    }
  }

  // ---------------- Navigation ----------------

  void goToProductDetails(ProductEntity product) =>
      emit(GoToProductDetails(product: product));

  void gotToFavorites() => emit(GoToFavorites());

  void gotToCarts() => emit(GoToCarts());

  void goToHome() => emit(GoToHome());

  // ---------------- helpers ----------------
  ProductEntity? findLoadedProduct(int productId) {
    for (final p in _allProducts) {
      if (p.id == productId) return p;
    }
    return null;
  }

  void _emitLoaded() {
    emit(
      GetHomeLoaded(
        products: _filteredProducts,
        categories: _categories,
        searchQuery: _searchQuery,
        selectedCategory: _selectedCategory,
        favoriteIds: Set.unmodifiable(_favoriteIds),
      ),
    );
  }

  List<String> get _categories {
    final categories = _allProducts.map((p) => p.category).toSet().toList()
      ..sort();
    return ['All', ...categories];
  }

  List<ProductEntity> get _filteredProducts {
    return _allProducts.where((p) {
      final matchesCategory =
          _selectedCategory == 'All' || p.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          p.title.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }
}