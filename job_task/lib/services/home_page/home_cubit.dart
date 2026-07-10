import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart' show Success, Failure;
import 'package:job_task/core/get_it/configure_dependency.dart';
import 'package:job_task/data/model/request/cart/add_product_to_cart.dart';
import 'package:job_task/data/model/request/cart/update_cart_request.dart';

import 'package:job_task/data/model/response/cart_entity.dart';
import 'package:job_task/data/model/response/product_entity.dart';
import 'package:job_task/domain/usecases/cart/add_cart_to_product_use_case.dart';
import 'package:job_task/domain/usecases/cart/get_cart_use_case.dart';
import 'package:job_task/domain/usecases/cart/remove_product_from_cart.dart';
import 'package:job_task/domain/usecases/cart/update_cart_item_use_case.dart';
import 'package:job_task/domain/usecases/get_product_use_case.dart';
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

  static HomeCubit get(BuildContext context) =>
      BlocProvider.of<HomeCubit>(context);

  List<ProductEntity> _allProducts = [];
  List<CartEntity> _cart = [];

  String _searchQuery = '';
  String _selectedCategory = 'All';
  final Set<int> _favoriteIds = {};

  /// True if this product already has a row in the cart.
  bool isProductInCart(int productId) =>
      _cart.any((c) => c.productId == productId);

  /// Badge count = number of DISTINCT products in the cart.
  /// Using _cart.length (not summed quantity) means changing an item's
  /// quantity does NOT change the badge — only add/remove does.
  int get cartCount => _cart.length;

  int get favoriteCount => _favoriteIds.length;

  double get cartTotal => _cart.fold(
    0.0,
    (sum, c) => sum + (double.tryParse(c.price ?? '') ?? 0) * c.quantity,
  );

  // ---------------- Products ----------------

  Future<void> loadProducts() async {
    emit(GetHomeLoadingState());

    // Start products (network) and cart (local DB) at the same time.
    final productFuture = getProductUseCase.execute();
    final cartFuture = getCartUseCase.execute();

    // Cart is best-effort — populate it if it succeeds, ignore if it doesn't.
    final cartResult = await cartFuture;
    if (cartResult case Success<List<CartEntity>>(:final data)) {
      _cart = List.of(data);
    }

    final productResult = await productFuture;
    switch (productResult) {
      case Success<List<ProductEntity>>(:final data):
        _allProducts = data;
        _emitLoaded(); // badge + in-cart flags reflect the loaded cart
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

  void toggleFavorite(int productId) {
    _favoriteIds.contains(productId)
        ? _favoriteIds.remove(productId)
        : _favoriteIds.add(productId);
    _emitLoaded();
  }

  /// Reloads cart data into _cart WITHOUT emitting cart states.
  Future<void> _loadCartData() async {
    final result = await getCartUseCase.execute();
    if (result case Success<List<CartEntity>>(:final data)) {
      _cart = List.of(data);
    }
  }

  /// Re-reads cart data, then re-emits the home state so the badge updates.
  Future<void> syncCart() async {
    await _loadCartData();
    _emitLoaded();
  }

  // ---------------- Add to cart ----------------

  Future<void> addToCart(ProductEntity product) async {
    // Refresh our view, then check whether it's already in the cart.
    await _loadCartData();
    if (isProductInCart(product.id)) {
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
        emit(FailedToAddedProductError(error ?? 'Could not add to cart'));
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

  /// Changing quantity does NOT change the badge (distinct-product count is
  /// unchanged) — it only updates the cart list and totals.
  Future<void> changeQuantity(CartEntity item, int newQuantity) async {
    if (newQuantity < 1) return;
    final result = await updateCartItemUseCase.execute(
      UpdateCartRequest(id: item.id, quantity: newQuantity),
    );
    switch (result) {
      case Success<int>():
        await _refreshCart();
      case Failure<int>(:final error):
        emit(FailedToUpdateProductError(error ?? 'Could not update quantity'));
    }
  }

  Future<void> removeCartItem(CartEntity item) async {
    final result = await removeCartItemUseCase.execute(item.productId);
    switch (result) {
      case Success<int>():
        await _refreshCart(); // badge drops by one product
      case Failure<int>(:final error):
        emit(FailedToUpdateProductError(error ?? 'Could not remove item'));
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
      final matchesSearch =
          _searchQuery.isEmpty ||
          p.title.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }
}
