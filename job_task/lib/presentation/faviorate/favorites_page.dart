import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_task/core/extenstion/convert_from_fav_to_product_entity.dart';
import 'package:job_task/core/theme/app_colors.dart';
import 'package:job_task/core/utility/utility.dart';
import 'package:job_task/data/model/response/favorite_entity.dart';
import 'package:job_task/presentation/home_page/product_details.dart';
import 'package:job_task/presentation/widget/app_image.dart';
import 'package:job_task/services/home_page/home_cubit.dart';
import 'package:job_task/services/home_page/home_state.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> with Utility {
  late HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    // Assumes HomeCubit is provided above this page (same as the cart page).
    _homeCubit = HomeCubit.get(context);
    _homeCubit.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.card,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.ink),
      ),
      body: BlocListener<HomeCubit, HomeState>(
        listenWhen: (_, current) =>
        current is FailedToUpdateFavoriteError ||
            current is FailedToAddedProductError ||
            current is ProductAlreadyInCart ||
            current is AddedProductSuccessToCart ||
            current is GoToProductDetails,
        listener: (context, state) {
          switch (state) {
            case FailedToUpdateFavoriteError(:final error):
              showSnack(context, error, AppColors.accent);
            case FailedToAddedProductError(:final error):
              showSnack(context, error, AppColors.accent);
            case ProductAlreadyInCart(:final productName):
              showSnack(
                  context, '$productName is already in the cart', Colors.red);
            case AddedProductSuccessToCart():
              showSnack(context, 'Added to cart', AppColors.card);
          // Navigate to product details when a favorite is tapped.
            case GoToProductDetails(:final product):
              navigateTo(
                context,
                isReplacement: true,
                BlocProvider.value(
                  value: _homeCubit,
                  child: ProductDetailsPage(product: product),
                ),
              );
          }
        },
        child: BlocBuilder<HomeCubit, HomeState>(
          // Only rebuild for favorites states so transient cart states
          // don't blank the list.
          buildWhen: (_, current) =>
          current is FavoritesLoadingState ||
              current is FavoritesLoadedState ||
              current is FavoritesFailed,
          builder: (context, state) {
            switch (state) {
              case FavoritesLoadingState():
                return const Center(child: CircularProgressIndicator());

              case FavoritesFailed():
                return _buildError();

              case FavoritesLoadedState(:final favorites):
                if (favorites.isEmpty) {
                  return _buildEmpty();
                }
                return ListView.separated(
                  padding: EdgeInsets.all(16.w),
                  itemCount: favorites.length,
                  separatorBuilder: (_, _) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) =>
                      _buildFavoriteTile(favorites[index]),
                );

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  // ---------------- Navigation ----------------

  void _openDetails(FavoriteEntity item) {
    // Prefer the full product (with description/rating) if it's already
    // loaded; otherwise build one from the favorite row.
    final full = _homeCubit.findLoadedProduct(item.productId);
    _homeCubit.goToProductDetails(
      full ?? ConvertFromFavoriteEntityToProductItem.call(item),
    );
  }

  // ---------------- confirm + remove ----------------

  /// Asks for confirmation; removes the favorite only if the user confirms.
  Future<void> _confirmAndRemove(FavoriteEntity item) async {
    final confirmed = await showRemoveDialog(
      context,
      title: 'Remove from favorites',
      message: 'Remove "${item.name}" from your favorites?',
    );
    if (confirmed) {
      _homeCubit.removeFavorite(item.productId);
    }
  }

  // ---------------- Tile ----------------

  Widget _buildFavoriteTile(FavoriteEntity item) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.r),
      // Tapping a row opens the product details for that item.
      onTap: () => _openDetails(item),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          children: [
            // ---------------- Image ----------------
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: SizedBox(
                width: 64.w,
                height: 64.w,
                child: AppCachedImage(imageUrl: item.image),
              ),
            ),
            SizedBox(width: 12.w),

            // ---------------- Name + Price ----------------
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      color: AppColors.ink,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),

            // ---------------- Add to cart ----------------
            Material(
              color: AppColors.ink,
              borderRadius: BorderRadius.circular(10.r),
              child: InkWell(
                onTap: () => _homeCubit.addFavoriteToCart(item),
                borderRadius: BorderRadius.circular(10.r),
                child: Padding(
                  padding: EdgeInsets.all(6.w),
                  child: Icon(
                    Icons.add_shopping_cart_rounded,
                    size: 16.sp,
                    color: AppColors.card,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),

            // ---------------- Remove from favorites ----------------
            // Shows a confirmation dialog first; on confirm the cubit
            // removes the row, refreshes the list, and decrements the badge.
            Material(
              color: AppColors.accent,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => _confirmAndRemove(item),
                child: Padding(
                  padding: EdgeInsets.all(6.w),
                  child: Icon(
                    Icons.remove_circle_outline_rounded,
                    size: 16.sp,
                    color: AppColors.card,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- Empty ----------------

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite_border,
            size: 48.sp,
            color: AppColors.textGrey,
          ),
          SizedBox(height: 12.h),
          Text(
            'No favorites yet',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Tap the heart on a product to save it here',
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Error ----------------

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Could not load favorites',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
          SizedBox(height: 8.h),
          ElevatedButton(
            onPressed: _homeCubit.loadFavorites,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.ink,
              foregroundColor: AppColors.card,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            ),
            child: Text('Retry', style: TextStyle(fontSize: 13.sp)),
          ),
        ],
      ),
    );
  }
}