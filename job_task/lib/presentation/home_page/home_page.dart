import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_task/core/theme/app_colors.dart';
import 'package:job_task/core/utility/utility.dart';
import 'package:job_task/presentation/cart/cart_page.dart';
import 'package:job_task/presentation/faviorate/fav_page.dart';
import 'package:job_task/presentation/home_page/product_details.dart';
import 'package:job_task/presentation/widget/product_card.dart';
import 'package:job_task/services/home_page/home_cubit.dart';
import 'package:job_task/services/home_page/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Utility {
  final TextEditingController _searchController = TextEditingController();
late HomeCubit homeCubit ;
  @override
  void initState() {
    super.initState();
    homeCubit =HomeCubit.get(context);
    homeCubit.loadProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: buildAppBar(
        context: context,
        actionWidget: BlocBuilder<HomeCubit, HomeState>(
          // Rebuild the badges when the counts can change.
          buildWhen: (prev, curr) =>
          curr is GetHomeLoaded ||
              curr is AddedProductSuccessToCart ||
              curr is CartLoadedState,
          builder: (context, state) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                getButtonBadge(
                  itemCount: homeCubit.favoriteCount,
                  onTap: () => homeCubit.gotToFavorites(),
                  icon: Icons.favorite,
                ),
                SizedBox(width: 5.w),
                getButtonBadge(
                  itemCount: homeCubit.cartCount, // real cart count (0 by default)
                  onTap: () => homeCubit.gotToCarts(),
                ),
              ],
            );
          },
        ),
      ),
      body: BlocListener<HomeCubit, HomeState>(
        // Side effects: navigation + add-to-cart snackbars.
        listener: (context, state) {
          if (state is GoToProductDetails) {
            navigateTo(
              context,
              BlocProvider.value(
                value: HomeCubit.get(context),
                child: ProductDetailsPage(product: state.product),
              ),
            );
          } else if (state is GoToCarts) {
            navigateTo(
              context,
              BlocProvider.value(
                value: homeCubit,
                child: const CartPage(),
              ),
            ).then((_) {
              // Refresh the badge after returning from the cart.
              if (mounted) {
                homeCubit.syncCart();
              }
            });
          } else if (state is GoToFavorites) {
            navigateTo(
                context,
                BlocProvider.value(
                  value: homeCubit,
                  child: const FavoritesPage()
                ));}
          else if (state is AddedProductSuccessToCart) {
            showSnack(context, 'Added to cart', AppColors.ink);
          } else if (state is ProductAlreadyInCart) {
            showSnack(
                context, '${state.productName} is already in your cart',
                AppColors.accent);
          } else if (state is FailedToAddedProductError) {
            showSnack(context, state.error, AppColors.accent);
          }},


        child: BlocBuilder<HomeCubit, HomeState>(
          // Only rebuild the page for HOME states, so cart/add states don't
          // blank the grid.
          buildWhen: (prev, curr) =>
          curr is GetHomeInitialState ||
              curr is GetHomeLoadingState ||
              curr is GetHomeLoaded ||
              curr is GetHomeFailed,
          builder: (context, state) {
            return switch (state) {
              GetHomeLoadingState() || GetHomeInitialState() =>
              const Center(child: CircularProgressIndicator.adaptive()),
              GetHomeFailed(:final error) => getErrorView(
                message: error ?? 'Something went wrong',
                onRetry: homeCubit.loadProducts,
              ),
              GetHomeLoaded() => _buildContent(homeCubit, state),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }

  // ---------------- Body ----------------
  Widget _buildContent(HomeCubit homeCubit, GetHomeLoaded state) {
    return RefreshIndicator(
      onRefresh: homeCubit.loadProducts,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // -------- Search bar --------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: TextField(
                controller: _searchController,
                onChanged: homeCubit.search,
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon:
                  const Icon(Icons.search, color: AppColors.textGrey),
                  suffixIcon: state.searchQuery.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () {
                      _searchController.clear();
                      homeCubit.search('');
                    },
                  )
                      : null,
                  filled: true,
                  fillColor: AppColors.card,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),

          // -------- Categories --------
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: state.categories.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  final isSelected = category == state.selectedCategory;
                  return GestureDetector(
                    onTap: () => homeCubit.selectCategory(category),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.ink : AppColors.card,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category[0].toUpperCase() + category.substring(1),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? AppColors.card
                              : AppColors.textGreyDark,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // -------- Product grid --------
          if (state.products.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: getEmptyView(
                title: 'No products found',
                subtitle: state.searchQuery.isNotEmpty
                    ? 'No results for "${state.searchQuery}"'
                    : 'Try a different category',
                icon: Icons.search_off_rounded,
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.72,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final product = state.products[index];
                    return ProductCard(
                      onCartTap: () => homeCubit.addToCart(product),
                      onTapped: () => homeCubit.goToProductDetails(product),
                      product: product,
                      isFavorite: state.favoriteIds.contains(product.id),
                      onFavoriteTap: () => homeCubit.toggleFavorite(product.id),
                    );
                  },
                  childCount: state.products.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}