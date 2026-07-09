import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart' show Success, Failure;
import 'package:job_task/core/get_it/configure_dependency.dart';
import 'package:job_task/data/model/response/product_entity.dart';
import 'package:job_task/domain/usecases/get_product_use_case.dart';
import 'package:job_task/services/home_page/home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(GetHomeInitialState());

  final GetProductUseCase getProductUseCase = getIt<GetProductUseCase>();

  static HomeCubit get(BuildContext context) =>
      BlocProvider.of<HomeCubit>(context);

  // Master list — the unfiltered source of truth, kept inside the cubit.
  List<ProductEntity> _allProducts = [];

  // Current filter values, owned by the cubit (not the widget).
  String _searchQuery = '';
  String _selectedCategory = 'All';
  final Set<int> _favoriteIds = {};

  Future<void> loadProducts() async {
    emit(GetHomeLoadingState());
    final result = await getProductUseCase.execute();
    switch (result) {
      case Success<List<ProductEntity>>(:final data):
        _allProducts = data;
        _emitLoaded();
      case Failure<List<ProductEntity>>(:final message):
        emit(GetHomeFailed(message));
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

  // ---------------- helpers ----------------

  void _emitLoaded() {
    emit(GetHomeLoaded(
      products: _filteredProducts,
      categories: _categories,
      searchQuery: _searchQuery,
      selectedCategory: _selectedCategory,
      favoriteIds: Set.unmodifiable(_favoriteIds),
    ));
  }

  List<String> get _categories {
    final categories =
    _allProducts.map((p) => p.category).toSet().toList()..sort();
    return ['All', ...categories]; // "All" first, not last
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

  void goToProductDeatils(ProductEntity product){
    emit(GoToProductDetails(product:product));
  }
}