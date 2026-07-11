import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_task/core/theme/app_colors.dart';
import 'package:job_task/data/model/response/product_entity.dart';
import 'package:job_task/presentation/widget/app_image.dart';
import 'package:job_task/services/home_page/home_cubit.dart';
import 'package:job_task/services/home_page/home_state.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final bool isFavorite;
  final bool isInCart;
  final VoidCallback onFavoriteTap;
  final VoidCallback onTapped;
  final VoidCallback onCartTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onTapped,
    required this.onCartTap,
    this.isInCart = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- Image + Favorite ----------------
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.r)),
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Hero(
                          tag: 'product-${product.id}',
                          child: AppCachedImage(
                            imageUrl: product.image,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: BlocBuilder<HomeCubit, HomeState>(
                      // Rebuild whenever the favorites snapshot changes:
                      // heart taps on the grid emit GetHomeLoaded, and
                      // removals on the favorites page emit FavoritesLoadedState.
                      buildWhen: (previous, current) =>
                      current is GetHomeLoaded ||
                          current is FavoritesLoadedState,
                      builder: (context, state) {
                        // Read from the cubit snapshot (kept in sync with the
                        // DB) instead of only GetHomeLoaded.favoriteIds — this
                        // is what turns the heart GRAY right after a favorite
                        // is removed anywhere in the app.
                        final favorite =
                        HomeCubit.get(context).isProductFavorite(product.id);

                        return Material(
                          color: AppColors.card,
                          shape: const CircleBorder(),
                          elevation: 1,
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: onFavoriteTap,
                            child: Padding(
                              padding: EdgeInsets.all(6.w),
                              child: Icon(
                                favorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 18.sp,
                                color: favorite
                                    ? AppColors.accent
                                    : AppColors.textGrey, // gray when removed
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ---------------- Product Info ----------------
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                        ),
                      ),

                      /// ---------------- Cart ----------------
                      BlocBuilder<HomeCubit, HomeState>(
                        buildWhen: (previous, current) =>
                        current is GetHomeLoaded ||
                            current is AddedProductSuccessToCart ||
                            current is CartLoadedState,
                        builder: (context, state) {
                          final inCart = isInCart ||
                              HomeCubit.get(context)
                                  .isProductInCart(product.id);

                          return Material(
                            color: inCart ? AppColors.accent : AppColors.ink,
                            borderRadius: BorderRadius.circular(10.r),
                            child: InkWell(
                              onTap: onCartTap,
                              borderRadius: BorderRadius.circular(10.r),
                              child: Padding(
                                padding: EdgeInsets.all(6.w),
                                child: Icon(
                                  inCart
                                      ? Icons.shopping_cart_rounded
                                      : Icons.add_shopping_cart_rounded,
                                  size: 16.sp,
                                  color: AppColors.card,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}