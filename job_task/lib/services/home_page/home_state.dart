import 'package:job_task/data/model/response/cart_entity.dart';
import 'package:job_task/data/model/response/category_entity.dart';
import 'package:job_task/data/model/response/favorite_entity.dart';

abstract class HomeState {}

// ============================================================
// HOME
// ============================================================

class GetHomeInitialState implements HomeState {}

class GoToProductDetails implements HomeState {
 final CategoryDataDataProductsEntity productsEntity;

 GoToProductDetails(this.productsEntity);
}

class GetHomeLoadingState implements HomeState {}

class GetHomeLoaded implements HomeState {
 final CategoryEntity categories;
 final List<CategoryDataDataProductsEntity> products;
 final String searchQuery;
 final String selectedCategory;
 final Set<int> favoriteIds;

 GetHomeLoaded({
  required this.categories,
  required this.products,
  this.searchQuery = '',
  this.selectedCategory = 'All',
  this.favoriteIds = const {},
 });
}

class GetHomeFailed implements HomeState {
 final String? error;

 GetHomeFailed(this.error);
}

// ============================================================
// PRODUCT DETAILS
// ============================================================

abstract class ProductDetailsState implements HomeState {
 final CategoryDataDataProductsEntity product;

 final int selectedImage;
 final int selectedColor;
 final int selectedSize;
 final int quantity;

 final Set<int> selectedAdditions;

 ProductDetailsState({
  required this.product,
  this.selectedImage = 0,
  this.selectedColor = 0,
  this.selectedSize = 0,
  this.quantity = 1,
  this.selectedAdditions = const {},
 });
}

// ============================================================
// PRODUCT DETAILS INITIAL
// ============================================================

class ProductDetailsInitialState extends ProductDetailsState {
 ProductDetailsInitialState({
  required super.product,
  super.selectedImage,
  super.selectedColor,
  super.selectedSize,
  super.quantity,
  super.selectedAdditions,
 });
}

// ============================================================
// IMAGE CHANGED
// ============================================================

class ProductDetailsImageChanged extends ProductDetailsState {
 ProductDetailsImageChanged({
  required super.product,
  required super.selectedImage,
  required super.selectedColor,
  required super.selectedSize,
  required super.quantity,
  required super.selectedAdditions,
 });
}

// ============================================================
// COLOR CHANGED
// ============================================================

class ProductDetailsColorChanged extends ProductDetailsState {
 ProductDetailsColorChanged({
  required super.product,
  required super.selectedImage,
  required super.selectedColor,
  required super.selectedSize,
  required super.quantity,
  required super.selectedAdditions,
 });
}

// ============================================================
// SIZE CHANGED
// ============================================================

class ProductDetailsSizeChanged extends ProductDetailsState {
 ProductDetailsSizeChanged({
  required super.product,
  required super.selectedImage,
  required super.selectedColor,
  required super.selectedSize,
  required super.quantity,
  required super.selectedAdditions,
 });
}

// ============================================================
// QUANTITY CHANGED
// ============================================================

class ProductDetailsQuantityChanged extends ProductDetailsState {
 ProductDetailsQuantityChanged({
  required super.product,
  required super.selectedImage,
  required super.selectedColor,
  required super.selectedSize,
  required super.quantity,
  required super.selectedAdditions,
 });
}

// ============================================================
// ADDITION CHANGED
// ============================================================

class ProductDetailsAdditionChanged extends ProductDetailsState {
 ProductDetailsAdditionChanged({
  required super.product,
  required super.selectedImage,
  required super.selectedColor,
  required super.selectedSize,
  required super.quantity,
  required super.selectedAdditions,
 });
}

// ============================================================
// CART STATES
// ============================================================

class CartInitialState implements HomeState {}

class CartLoadedState implements HomeState {
 final List<CartEntity> cart;

 CartLoadedState(this.cart);
}

class CartLoadingState implements HomeState {}

class CartFailed implements HomeState {}

// ============================================================
// ADD CART
// ============================================================

class AddProductToCartLoading implements HomeState {}

class AddedProductSuccessToCart implements HomeState {
 final List<CartEntity> cart;

 AddedProductSuccessToCart(this.cart);
}

class FailedToAddedProductError implements HomeState {
 final String error;

 FailedToAddedProductError(this.error);
}

class ProductAlreadyInCart implements HomeState {
 final String productName;

 ProductAlreadyInCart(this.productName);
}

// ============================================================
// UPDATE CART
// ============================================================

class UpdateProductToCartLoading implements HomeState {}

class UpdateProductSuccessToCart implements HomeState {
 final List<CartEntity> cart;

 UpdateProductSuccessToCart(this.cart);
}

class FailedToUpdateProductError implements HomeState {
 final String error;

 FailedToUpdateProductError(this.error);
}

// ============================================================
// FAVORITES
// ============================================================

class FavoritesLoadingState implements HomeState {}

class FavoritesLoadedState implements HomeState {
 final List<FavoriteEntity> favorites;

 FavoritesLoadedState(this.favorites);
}

class FavoritesFailed implements HomeState {}

class ProductAlreadyInFavorites implements HomeState {
 final String productName;

 ProductAlreadyInFavorites(this.productName);
}

class FailedToUpdateFavoriteError implements HomeState {
 final String error;

 FailedToUpdateFavoriteError(this.error);
}

// ============================================================
// NAVIGATION
// ============================================================

class GoToFavorites implements HomeState {}

class GoToCarts implements HomeState {}

class GoToHome implements HomeState {}

// ============================================================
// LOGOUT
// ============================================================

class ProfileLogout implements HomeState {}