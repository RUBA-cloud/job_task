import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/core/get_it/configure_dependency.dart';

import 'package:job_task/data/model/request/cart/add_product_to_cart.dart';
import 'package:job_task/data/model/request/cart/update_cart_request.dart';

import 'package:job_task/data/model/response/cart_entity.dart';
import 'package:job_task/data/model/response/category_entity.dart';
import 'package:job_task/data/model/response/favorite_entity.dart';

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

  final CheckProductInCartUseCase checkProductInCartUseCase =
  getIt();

  final GetFavUseCase getFavUseCase = getIt();

  final AddProductToFavUseCase addProductToFavUseCase =
  getIt();

  final RemoveProductFromFavUseCase removeProductFromFavUseCase =
  getIt();

  final CheckProductInFavUseCase checkProductInFavUseCase =
  getIt();

  final RemovePrefUseCase _removePrefUseCase = getIt();

  // ============================================================
  // HOME DATA
  // ============================================================

  CategoryEntity? _categories;

  List<CategoryDataDataProductsEntity> _allProducts = [];

  List<CartEntity> _cart = [];

  List<FavoriteEntity> _favorites = [];

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

  Set<int> get favoriteIds {
    return _favorites
        .map(
          (item) => item?.productId,
    )
        .toSet();
  }

  bool isProductInCart(int productId) {
    return _cart.any(
          (item) => item.productId == productId,
    );
  }

  bool isProductFavorite(int productId) {
    return favoriteIds.contains(productId);
  }

  int get cartCount {
    return _cart.length;
  }

  int get favoriteCount {
    return _favorites.length;
  }

  double get cartTotal {
    return _cart.fold(
      0.0,
          (sum, item) {
        return sum + (item.price * item.quantity);
      },
    );
  }

  // ============================================================
  // PRODUCT DETAILS GETTERS
  // ============================================================

  CategoryDataDataProductsEntity? get selectedProduct {
    return _selectedProduct;
  }

  int get selectedImage {
    return _selectedImage;
  }

  int get selectedColor {
    return _selectedColor;
  }

  int get selectedSize {
    return _selectedSize;
  }

  int get quantity {
    return _quantity;
  }

  Set<int> get selectedAdditions {
    return Set.unmodifiable(
      _selectedAdditions,
    );
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
    emit(
      GetHomeLoadingState(),
    );

    try {
      final result =
      await getProductUseCase.execute();

      switch (result) {
        case Success<CategoryEntity>(
            :final data,
        ):
          _categories = data;

          if (_categories != null) {
            final categories =
                _categories!.data.data;

            if (categories.isNotEmpty) {
              _allProducts =
                  categories.first.products;
            }
          }

          await _loadFavData();

          await _loadCartData();

          _emitLoaded();

          break;

        case Failure<CategoryEntity>(
            :final error,
        ):
          emit(
            GetHomeFailed(
              error?.message ??
                  'Unable to load products',
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

  void selectCategory(
      String category,
      ) {
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
      GoToProductDetails(
        product,
      ),
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
        Set.unmodifiable(
          _selectedAdditions,
        ),
      ),
    );
  }

  // ============================================================
  // SELECT IMAGE
  // ============================================================

  void selectProductImage(
      int index,
      ) {
    final product = _selectedProduct;

    if (product == null) {
      return;
    }

    final totalImages =
        product.images.length + 1;

    if (index < 0 ||
        index >= totalImages) {
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
        Set.unmodifiable(
          _selectedAdditions,
        ),
      ),
    );
  }

  // ============================================================
  // SELECT COLOR
  // ============================================================

  void selectProductColor(
      int index,
      ) {
    final product = _selectedProduct;

    if (product == null) {
      return;
    }

    if (index < 0 ||
        index >= product.colors.length) {
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
        Set.unmodifiable(
          _selectedAdditions,
        ),
      ),
    );
  }

  // ============================================================
  // SELECT SIZE
  // ============================================================

  void selectProductSize(
      int index,
      ) {
    final product = _selectedProduct;

    if (product == null) {
      return;
    }

    if (index < 0 ||
        index >= product.sizes.length) {
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
        Set.unmodifiable(
          _selectedAdditions,
        ),
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
        Set.unmodifiable(
          _selectedAdditions,
        ),
      ),
    );
  }

  // ============================================================
  // DECREASE QUANTITY
  // ============================================================

  void decreaseQuantity() {
    final product = _selectedProduct;

    if (product == null) {
      return;
    }

    if (_quantity <= 1) {
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
        Set.unmodifiable(
          _selectedAdditions,
        ),
      ),
    );
  }

  // ============================================================
  // TOGGLE ADDITION
  // ============================================================

  void toggleProductAddition(
      int index,
      ) {
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
        Set.unmodifiable(
          _selectedAdditions,
        ),
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
      final result =
      await getFavUseCase.execute();

      if (result
      case Success<List<FavoriteEntity>>(
          :final data,
      )) {
        _favorites =
        List<FavoriteEntity>.from(
          data,
        );
      }
    } catch (_) {
      // Keep local favorites.
    }
  }

  // ============================================================
  // LOAD CART DATA
  // ============================================================

  Future<void> _loadCartData() async {
    try {
      final result =
      await getCartUseCase.execute();

      if (result
      case Success<List<CartEntity>>(
          :final data,
      )) {
        _cart =
        List<CartEntity>.from(
          data,
        );
      }
    } catch (_) {
      // Keep local cart.
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

  Future<void> addToCart(
      CategoryDataDataProductsEntity product, {
        int? quantity,
      }) async {
    final selectedQuantity =
        quantity ?? _quantity;

    var alreadyInCart =
    isProductInCart(
      product.id,
    );

    try {
      final checkResult =
      await checkProductInCartUseCase
          .execute(
        product.id,
      );

      if (checkResult
      case Success<bool>(
          :final data,
      )) {
        alreadyInCart = data;
      }
    } catch (_) {
      // Use local cart state.
    }

    if (alreadyInCart) {
      emit(
        ProductAlreadyInCart(
          product.nameEn,
        ),
      );

      return;
    }

    emit(
      AddProductToCartLoading(),
    );

    final request =
    AddProductToCartRequest(
      productId: product.id,
      quantity: selectedQuantity,
      name: product.nameEn,
      image: product.mainImage,
      price: product.price,
      value: 0,
    );

    try {
      final result =
      await addCartItemUseCase
          .execute(
        request,
      );

      switch (result) {
        case Success<int>():
          await _loadCartData();

          emit(
            AddedProductSuccessToCart(
              List.unmodifiable(
                _cart,
              ),
            ),
          );

          break;

        case Failure<int>(
            :final error,
        ):
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
  // REMOVE CART PRODUCT
  // ============================================================

  Future<void> removeCartByProductId(
      int productId,
      ) async {
    try {
      final result =
      await removeCartItemUseCase
          .execute(
        productId,
      );

      switch (result) {
        case Success():
          await _loadCartData();

          _emitLoaded();

          break;

        case Failure():
          _emitLoaded();

          break;
      }
    } catch (_) {
      _emitLoaded();
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
      final result =
      await getCartUseCase.execute();

      switch (result) {
        case Success<List<CartEntity>>(
            :final data,
        ):
          _cart =
          List<CartEntity>.from(
            data,
          );

          emit(
            CartLoadedState(
              List.unmodifiable(
                _cart,
              ),
            ),
          );

          break;

        case Failure<List<CartEntity>>():
          emit(
            CartFailed(),
          );

          break;
      }
    } catch (_) {
      emit(
        CartFailed(),
      );
    }
  }

  // ============================================================
  // CHANGE CART QUANTITY
  // ============================================================

  Future<void> changeQuantity(
      CartEntity item,
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
      await updateCartItemUseCase
          .execute(
        UpdateCartRequest(
          id: item.id,
          quantity: newQuantity,
        ),
      );

      switch (result) {
        case Success():
          await _refreshCart();

          break;

        case Failure():
          emit(
            FailedToUpdateProductError(
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
      CartEntity item,
      ) async {
    try {
      final result =
      await removeCartItemUseCase
          .execute(
        item.productId,
      );

      switch (result) {
        case Success():
          await _refreshCart();

          break;

        case Failure():
          break;
      }
    } catch (_) {}
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
        case Success<List<FavoriteEntity>>(
            :final data,
        ):
          _favorites =
          List<FavoriteEntity>.from(
            data,
          );

          emit(
            FavoritesLoadedState(
              List.unmodifiable(
                _favorites,
              ),
            ),
          );

          break;

        case Failure<List<FavoriteEntity>>():
          emit(
            FavoritesFailed(),
          );

          break;
      }
    } catch (_) {
      emit(
        FavoritesFailed(),
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
          .execute(
        id,
      );

      switch (result) {
        case Success():
          await _refreshFavorites();

          _emitLoaded();

          break;

        case Failure():
          emit(
            FavoritesLoadedState(
              List.unmodifiable(
                _favorites,
              ),
            ),
          );

          break;
      }
    } catch (_) {
      emit(
        FavoritesLoadedState(
          List.unmodifiable(
            _favorites,
          ),
        ),
      );
    }
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
  // EMIT HOME LOADED
  // ============================================================

  void _emitLoaded() {
    if (_categories == null) {
      return;
    }

    emit(
      GetHomeLoaded(
        categories: _categories!,
        searchQuery: _searchQuery,
        selectedCategory:
        _selectedCategory,
        favoriteIds:
        Set.unmodifiable(
          favoriteIds,
        ),
        products:
        List.unmodifiable(
          _allProducts,
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