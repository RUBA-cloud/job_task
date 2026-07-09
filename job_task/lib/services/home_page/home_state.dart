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