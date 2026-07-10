import 'package:job_task/data/model/response/cart_entity.dart';
import 'package:job_task/data/model/response/product_entity.dart';

abstract class HomeState {}

class GetHomeInitialState implements HomeState {}

class GetHomeLoadingState implements HomeState {}

class GetHomeLoaded implements HomeState {
 final List<ProductEntity> products; // already filtered — what the UI shows
 final List<String> categories;
 final String searchQuery;
 final String selectedCategory;
 final Set<int> favoriteIds;

 GetHomeLoaded({
  required this.products,
  required this.categories,
  this.searchQuery = '',
  this.selectedCategory = 'All',
  this.favoriteIds = const {},
 });

 GetHomeLoaded copyWith({
  List<ProductEntity>? products,
  List<String>? categories,
  String? searchQuery,
  String? selectedCategory,
  Set<int>? favoriteIds,
 }) {
  return GetHomeLoaded(
   products: products ?? this.products,
   categories: categories ?? this.categories,
   searchQuery: searchQuery ?? this.searchQuery,
   selectedCategory: selectedCategory ?? this.selectedCategory,
   favoriteIds: favoriteIds ?? this.favoriteIds,
  );
 }
}

class GetHomeFailed implements HomeState {
 final String? error;
 GetHomeFailed(this.error);
}

class GoToProductDetails implements HomeState {
 final ProductEntity product;
 GoToProductDetails({required this.product});
}

class GoToFavorites implements HomeState {}

class GoToCarts implements HomeState {}

class GoToHome implements HomeState {}

/// Carts States
class CartInitialState implements HomeState {}

class CartLoadedState implements HomeState {
 final List<CartEntity> cart;
 CartLoadedState(this.cart);
}

class CartLoadingState implements HomeState {}

class CartFailed implements HomeState {}

/// Add cart item States
class AddProductToCartLoading implements HomeState {}

class AddedProductSuccessToCart implements HomeState {
 final List<CartEntity> cart;
 AddedProductSuccessToCart(this.cart);
}

class FailedToAddedProductError implements HomeState {
 final String error;
 FailedToAddedProductError(this.error);
}

/// Emitted when the product is already in the cart.
class ProductAlreadyInCart implements HomeState {
 final String productName;
 ProductAlreadyInCart(this.productName);
}

/// Update Cart States
class UpdateProductToCartLoading implements HomeState {}

class UpdateProductSuccessToCart implements HomeState {
 final List<CartEntity> cart;
 UpdateProductSuccessToCart(this.cart);
}

class FailedToUpdateProductError implements HomeState {
 final String error;
 FailedToUpdateProductError(this.error);
}