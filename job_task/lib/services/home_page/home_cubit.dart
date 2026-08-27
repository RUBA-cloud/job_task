import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/core/get_it/configure_dependency.dart';

import 'package:job_task/data/model/request/cart/add_product_to_cart.dart';
import 'package:job_task/data/model/request/cart/remove_product_in_cart.dart';
import 'package:job_task/data/model/request/cart/update_cart_request.dart';
import 'package:job_task/data/model/request/faviorate/add_to_fav_request.dart';
import 'package:job_task/data/model/response/cart/add_product_to_cart_entity.dart';

import 'package:job_task/data/model/response/cart/cart_entity.dart';
import 'package:job_task/data/model/response/category_entity.dart';
import 'package:job_task/data/model/response/faviorate_entity.dart';

import 'package:job_task/domain/use_cases/cart/add_cart_to_product_use_case.dart';
import 'package:job_task/domain/use_cases/cart/get_cart_use_case.dart';
import 'package:job_task/domain/use_cases/cart/remove_product_from_cart_use_case.dart';
import 'package:job_task/domain/use_cases/cart/update_cart_item_use_case.dart';

import 'package:job_task/domain/use_cases/faviorate/add_product_fav_use_case.dart';
import 'package:job_task/domain/use_cases/faviorate/get_fav_use_case.dart';
import 'package:job_task/domain/use_cases/faviorate/remove_product_from_fav_use_case.dart';

import 'package:job_task/domain/use_cases/get_product_use_case.dart';
import 'package:job_task/domain/use_cases/shared_pref/remove_shared_pef_use_case.dart';

import 'package:job_task/services/home_page/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(GetHomeInitialState());

  static HomeCubit get(BuildContext context) {
    return BlocProvider.of<HomeCubit>(context);
  }

  // ============================================================
  // USE CASES
  // ============================================================

  final GetProductUseCase getProductUseCase = getIt();

  final GetCartUseCase getCartUseCase = getIt();

  final AddCartToProductUseCase addCartItemUseCase = getIt();

  final UpdateCartItemUseCase updateCartItemUseCase = getIt();

  final RemoveCartItemUseCase removeCartItemUseCase = getIt();

  final GetFavUseCase getFavUseCase = getIt();

  final AddProductToFavUseCase addProductToFavUseCase = getIt();

  final RemoveProductFromFavUseCase removeProductFromFavUseCase = getIt();

  final RemovePrefUseCase _removePrefUseCase = getIt();

  // ============================================================
  // HOME DATA
  // ============================================================

  CategoryEntity? _categories;

  List<CategoryDataDataProductsEntity> _allProducts = [];

  CartEntity? _cart;

  FaviorateEntity? _favorites;

  // ============================================================
  // FILTER DATA
  // ============================================================

  String _searchQuery = '';

  String _selectedCategory = 'All';

  // ============================================================
  // PRODUCT DETAILS DATA
  // ============================================================

  CategoryDataDataProductsEntity? _selectedProduct;

  int _selectedImage = 0;

  int _selectedColor = 0;

  int _selectedSize = 0;

  int _quantity = 1;

  Set<int> _selectedAdditions = {};

  // ============================================================
  // HOME GETTERS
  // ============================================================

  bool isProductInCart(int productId) {
    return _cart?.data.any(
          (item) => item.productId == productId,
    ) ??
        false;
  }

  int get cartCount {
    return _cart?.data.length ?? 0;
  }

  int get favoriteCount {
    return _favorites?.data.length ?? 0;
  }

  double get cartTotal {
    return _cart?.data.fold<double>(
      0.0,
          (sum, item) {
        final price =
            double.tryParse(item.product.price) ?? 0.0;

        return sum + (price * item.quantity);
      },
    ) ??
        0.0;
  }

  List<CartDataEntity> get cartItems {
    return List.unmodifiable(
      _cart?.data ?? [],
    );
  }

  // ============================================================
  // PRODUCT DETAILS GETTERS
  // ============================================================

  CategoryDataDataProductsEntity? get selectedProduct {
    return _selectedProduct;
  }

  int get selectedImage => _selectedImage;

  int get selectedColor => _selectedColor;

  int get selectedSize => _selectedSize;

  int get quantity => _quantity;

  Set<int> get selectedAdditions {
    return Set.unmodifiable(_selectedAdditions);
  }

  ProductDetailsState? get productDetailsState {
    final currentState = state;

    if (currentState is ProductDetailsState) {
      return currentState;
    }

    return null;
  }

  // ============================================================
  // LOAD PRODUCTS
  // ============================================================

  Future<void> loadProducts() async {
    emit(GetHomeLoadingState());

    try {
      final result = await getProductUseCase.execute();

      switch (result) {
        case Success<CategoryEntity>(:final data):
          _categories = data;

          final categories = _categories!.data.data;

          if (categories.isNotEmpty) {
            _allProducts = categories
                .expand<CategoryDataDataProductsEntity>(
                  (category) => category.products,
            )
                .toList();
          } else {
            _allProducts = [];
          }

          await _loadFavData();

          await _loadCartData();

          _emitLoaded();

          break;

        case Failure<CategoryEntity>(:final error):
          emit(
            GetHomeFailed(
              error?.message ?? 'Unable to load products',
            ),
          );

          break;
      }
    } catch (e) {
      emit(
        GetHomeFailed(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // SEARCH
  // ============================================================

  void search(String query) {
    _searchQuery = query;

    _emitLoaded();
  }

  // ============================================================
  // CATEGORY
  // ============================================================

  void selectCategory(String category) {
    _selectedCategory = category;

    _emitLoaded();
  }

  // ============================================================
  // OPEN PRODUCT DETAILS
  // ============================================================

  void goToProductDetails(
      CategoryDataDataProductsEntity product,
      ) {
    _selectedProduct = product;

    _selectedImage = 0;
    _selectedColor = 0;
    _selectedSize = 0;
    _quantity = 1;
    _selectedAdditions = {};

    emit(
      GoToProductDetails(product),
    );
  }

  // ============================================================
  // INITIALIZE PRODUCT DETAILS
  // ============================================================

  void initializeProductDetails(
      CategoryDataDataProductsEntity product,
      ) {
    _selectedProduct = product;

    _selectedImage = 0;
    _selectedColor = 0;
    _selectedSize = 0;
    _quantity = 1;
    _selectedAdditions = {};

    emit(
      ProductDetailsInitialState(
        product: product,
        selectedImage: _selectedImage,
        selectedColor: _selectedColor,
        selectedSize: _selectedSize,
        quantity: _quantity,
        selectedAdditions:
        Set.unmodifiable(_selectedAdditions),
      ),
    );
  }

  // ============================================================
  // SELECT IMAGE
  // ============================================================

  void selectProductImage(int index) {
    final product = _selectedProduct;

    if (product == null) {
      return;
    }

    final totalImages = product.images.length + 1;

    if (index < 0 || index >= totalImages) {
      return;
    }

    _selectedImage = index;

    emit(
      ProductDetailsImageChanged(
        product: product,
        selectedImage: _selectedImage,
        selectedColor: _selectedColor,
        selectedSize: _selectedSize,
        quantity: _quantity,
        selectedAdditions:
        Set.unmodifiable(_selectedAdditions),
      ),
    );
  }

  // ============================================================
  // SELECT COLOR
  // ============================================================

  void selectProductColor(int index) {
    final product = _selectedProduct;

    if (product == null) {
      return;
    }

    if (index < 0 || index >= product.colors.length) {
      return;
    }

    _selectedColor = index;

    emit(
      ProductDetailsColorChanged(
        product: product,
        selectedImage: _selectedImage,
        selectedColor: _selectedColor,
        selectedSize: _selectedSize,
        quantity: _quantity,
        selectedAdditions:
        Set.unmodifiable(_selectedAdditions),
      ),
    );
  }

  // ============================================================
  // SELECT SIZE
  // ============================================================

  void selectProductSize(int index) {
    final product = _selectedProduct;

    if (product == null) {
      return;
    }

    if (index < 0 || index >= product.sizes.length) {
      return;
    }

    _selectedSize = index;

    emit(
      ProductDetailsSizeChanged(
        product: product,
        selectedImage: _selectedImage,
        selectedColor: _selectedColor,
        selectedSize: _selectedSize,
        quantity: _quantity,
        selectedAdditions:
        Set.unmodifiable(_selectedAdditions),
      ),
    );
  }

  // ============================================================
  // INCREASE QUANTITY
  // ============================================================

  void increaseQuantity() {
    final product = _selectedProduct;

    if (product == null) {
      return;
    }

    _quantity++;

    emit(
      ProductDetailsQuantityChanged(
        product: product,
        selectedImage: _selectedImage,
        selectedColor: _selectedColor,
        selectedSize: _selectedSize,
        quantity: _quantity,
        selectedAdditions:
        Set.unmodifiable(_selectedAdditions),
      ),
    );
  }

  // ============================================================
  // DECREASE QUANTITY
  // ============================================================

  void decreaseQuantity() {
    final product = _selectedProduct;

    if (product == null || _quantity <= 1) {
      return;
    }

    _quantity--;

    emit(
      ProductDetailsQuantityChanged(
        product: product,
        selectedImage: _selectedImage,
        selectedColor: _selectedColor,
        selectedSize: _selectedSize,
        quantity: _quantity,
        selectedAdditions:
        Set.unmodifiable(_selectedAdditions),
      ),
    );
  }

  // ============================================================
  // TOGGLE ADDITION
  // ============================================================

  void toggleProductAddition(int index) {
    final product = _selectedProduct;

    if (product == null) {
      return;
    }

    if (index < 0 ||
        index >= product.additionals.length) {
      return;
    }

    if (_selectedAdditions.contains(index)) {
      _selectedAdditions.remove(index);
    } else {
      _selectedAdditions.add(index);
    }

    emit(
      ProductDetailsAdditionChanged(
        product: product,
        selectedImage: _selectedImage,
        selectedColor: _selectedColor,
        selectedSize: _selectedSize,
        quantity: _quantity,
        selectedAdditions:
        Set.unmodifiable(_selectedAdditions),
      ),
    );
  }

  // ============================================================
  // RESET PRODUCT DETAILS
  // ============================================================

  void resetProductDetails() {
    final product = _selectedProduct;

    if (product == null) {
      return;
    }

    _selectedImage = 0;
    _selectedColor = 0;
    _selectedSize = 0;
    _quantity = 1;
    _selectedAdditions = {};

    emit(
      ProductDetailsInitialState(
        product: product,
        selectedImage: 0,
        selectedColor: 0,
        selectedSize: 0,
        quantity: 1,
        selectedAdditions: const {},
      ),
    );
  }

  // ============================================================
  // LOAD FAVORITES DATA
  // ============================================================

  Future<void> _loadFavData() async {
    try {
      final result = await getFavUseCase.execute();

      switch (result) {
        case Success<FaviorateEntity>(:final data):
          _favorites = data;
          break;

        case Failure<FaviorateEntity>():
          _favorites = null;
          break;
      }
    } catch (_) {
      _favorites = null;
    }
  }

  // ============================================================
  // LOAD CART DATA
  // ============================================================

  Future<void> _loadCartData() async {
    try {
      final result = await getCartUseCase.execute();

      switch (result) {
        case Success<CartEntity>(:final data):
          _cart = data;
          break;

        case Failure<CartEntity>():
          break;
      }
    } catch (_) {
      // Keep current cart.
    }
  }

  // ============================================================
  // SYNC CART
  // ============================================================

  Future<void> syncCart() async {
    await _loadCartData();

    _emitLoaded();
  }

  // ============================================================
  // ADD TO CART
  // ============================================================
  void restoreHomeState() {
    if (_categories == null) {
      return;
    }

    _emitLoaded();
  }
  Future<void> addToCart(
      CategoryDataDataProductsEntity product, {
        int? quantity,
      }) async {
    final selectedQuantity = quantity ?? _quantity;

    if (isProductInCart(product.id)) {
      emit(
        ProductAlreadyInCart(product.nameEn),
      );

      return;
    }

    emit(
      AddProductToCartLoading(),
    );

    final request = AddProductToCartRequest(
      productId: product.id,
      quantity: selectedQuantity,
    );

    try {
      final result =
      await addCartItemUseCase.execute(request);

      switch (result) {
        case Success<AddProductToCartEntity>():
          await _loadCartData();

          emit(
            AddedProductSuccessToCart(
             _cart!
            ),
          );

          break;

        case Failure<AddProductToCartEntity>(:final error):
          emit(
            FailedToAddedProductError(
              error?.message ??
                  'Failed to add product to cart',
            ),
          );

          break;
      }
    } catch (e) {
      emit(
        FailedToAddedProductError(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // REMOVE CART BY PRODUCT ID
  // ============================================================

  Future<void> removeCartByProductId(
      int productId,
      ) async {
    try {
      final result =
      await removeCartItemUseCase.execute(
        RemoveProductFromCartRequest(id: productId)
      );

      switch (result) {
        case Success():
          await _loadCartData();

          _emitLoaded();

          break;

        case Failure(:final error):
          emit(
            FailedToUpdateProductError(
              error?.message ??
                  'Failed to remove product',
            ),
          );

          break;
      }
    } catch (e) {
      emit(
        FailedToUpdateProductError(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // LOAD CART
  // ============================================================

  Future<void> loadCart() async {
    emit(
      CartLoadingState(),
    );

    await _refreshCart();
  }

  // ============================================================
  // REFRESH CART
  // ============================================================

  Future<void> _refreshCart() async {
    try {
      final result = await getCartUseCase.execute();

      switch (result) {
        case Success<CartEntity>(:final data):
          _cart = data;

          emit(
            CartLoadedState(
           data
            ),
          );

          break;

        case Failure<CartEntity>(:final error):
          emit(
            CartFailed(
              error?.message ??
                  'Could not load your cart',
            ),
          );

          break;
      }
    } catch (e) {
      emit(
        CartFailed(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // CHANGE CART QUANTITY
  // ============================================================

  Future<void> changeQuantity(
      CartDataEntity item,
      int newQuantity,
      ) async {
    if (newQuantity < 1) {
      return;
    }

    emit(
      UpdateProductToCartLoading(),
    );

    try {
      final result =
      await updateCartItemUseCase.execute(
        UpdateCartRequest(
          id: item.id,
          quantity: newQuantity,
        ),
      );

      switch (result) {
        case Success():
          await _refreshCart();
          break;

        case Failure(:final error):
          emit(
            FailedToUpdateProductError(
              error?.message ??
                  'Failed to update cart',
            ),
          );

          break;
      }
    } catch (e) {
      emit(
        FailedToUpdateProductError(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // REMOVE CART ITEM
  // ============================================================

  Future<void> removeCartItem(
      CartDataEntity item,
      ) async {
    try {
      final result =
      await removeCartItemUseCase.execute(
      RemoveProductFromCartRequest(id: item.id)
      );

      switch (result) {
        case Success():
          await _refreshCart();
          break;

        case Failure(:final error):
          emit(
            FailedToUpdateProductError(
              error?.message ??
                  'Failed to remove item',
            ),
          );

          break;
      }
    } catch (e) {
      emit(
        FailedToUpdateProductError(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // LOAD FAVORITES
  // ============================================================

  Future<void> loadFavorites() async {
    emit(
      FavoritesLoadingState(),
    );

    await _refreshFavorites();
  }

  // ============================================================
  // REFRESH FAVORITES
  // ============================================================

  Future<void> _refreshFavorites() async {
    try {
      final result =
      await getFavUseCase.execute();

      switch (result) {
        case Success<FaviorateEntity>(
            :final data,
        ):
          _favorites = data;

          emit(
            FavoritesLoadedState(
              data,
            ),
          );

          break;

        case Failure<FaviorateEntity>(
            :final error,
        ):
          emit(
            FavoritesFailed(
            
            ),
          );

          break;
      }
    } catch (e) {
      emit(
        FavoritesFailed(
        ),
      );
    }
  }

  // ============================================================
  // REMOVE FAVORITE
  // ============================================================

  Future<void> removeFavorite(
      int id,
      ) async {
    try {
      final result =
      await removeProductFromFavUseCase
          .execute(id);

      switch (result) {
        case Success():
          await _refreshFavorites();

          _emitLoaded();

          break;

        case Failure(:final error):
          emit(
            FailedToUpdateFavoriteError(
              error?.message ??
                  'Failed to remove favorite',
            ),
          );

          break;
      }
    } catch (e) {
      emit(
        FailedToUpdateFavoriteError(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // IS FAVORITE
  // ============================================================

  bool isProductFavorite(
      int productId,
      ) {
    return _favorites?.data.any(
          (favorite) =>
      favorite.productId == productId,
    ) ??
        false;
  }

  // ============================================================
  // TOGGLE FAVORITE
  // ============================================================

  Future<void> toggleFavorite(
      int productId,
      ) async {
    try {
      final isFavorite =
      isProductFavorite(productId);

      if (isFavorite) {
        final result =
        await removeProductFromFavUseCase
            .execute(productId);

        switch (result) {
          case Success():
            await _refreshFavorites();

            _emitLoaded();

            break;

          case Failure(:final error):
            emit(
              FailedToUpdateFavoriteError(
                error?.message ??
                    'Failed to remove favorite',
              ),
            );

            break;
        }
      } else {
        final result =
        await addProductToFavUseCase.execute(
          AddToFavRequest(
            productId: productId,
          ),
        );

        switch (result) {
          case Success():
            await _refreshFavorites();

            _emitLoaded();

            break;

          case Failure(:final error):
            emit(
              FailedToUpdateFavoriteError(
                error?.message ??
                    'Failed to add favorite',
              ),
            );

            break;
        }
      }
    } catch (e) {
      emit(
        FailedToUpdateFavoriteError(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // FAVORITE IDS
  // ============================================================

  Set<int> get favoriteIds {
    return {
      ...?_favorites?.data.map(
            (favorite) => favorite.productId,
      ),
    };
  }

  // ============================================================
  // NAVIGATION
  // ============================================================

  void gotToFavorites() {
    emit(
      GoToFavorites(),
    );
  }

  void gotToCarts() {
    emit(
      GoToCarts(),
    );
  }

  void goToHome() {
    emit(
      GoToHome(),
    );
  }

  // ============================================================
  // FIND PRODUCT
  // ============================================================

  CategoryDataDataProductsEntity? findLoadedProduct(
      int productId,
      ) {
    try {
      return _allProducts.firstWhere(
            (product) => product.id == productId,
      );
    } catch (_) {
      return null;
    }
  }

  // ============================================================
  // FILTER PRODUCTS
  // ============================================================

  List<CategoryDataDataProductsEntity>
  get filteredProducts {
    var products =
    List<CategoryDataDataProductsEntity>.from(
      _allProducts,
    );

    if (_selectedCategory != 'All') {
      products = products.where((product) {
        return product.category!.nameEn ==
            _selectedCategory;
      }).toList();
    }

    if (_searchQuery.trim().isNotEmpty) {
      final query =
      _searchQuery.trim().toLowerCase();

      products = products.where((product) {
        return product.nameEn
            .toLowerCase()
            .contains(query);
      }).toList();
    }

    return products;
  }

  // ============================================================
  // EMIT HOME LOADED
  // ============================================================

  void _emitLoaded() {
    if (_categories == null) {
      return;
    }

    emit(
      GetHomeLoaded(
        categories: _categories!,

        products: List.unmodifiable(
          filteredProducts,
        ),

        searchQuery: _searchQuery,

        selectedCategory:
        _selectedCategory,

        favoriteIds:
        Set.unmodifiable(
          favoriteIds,
        ),
      ),
    );
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  Future<void> logout() async {
    await _removePrefUseCase.call();

    emit(
      ProfileLogout(),
    );
  }
}