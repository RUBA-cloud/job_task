import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_task/core/theme/app_colors.dart';
import 'package:job_task/core/utility/utility.dart';
import 'package:job_task/data/model/response/product_entity.dart';
import 'package:job_task/presentation/widget/app_image.dart';
import 'package:job_task/services/home_page/home_cubit.dart';
import 'package:job_task/services/home_page/home_state.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> with Utility {
  late HomeCubit cubit;

  @override
  void initState() {
    cubit = HomeCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: buildAppBar(
        context: context,
        showBackButton: true,
        title: 'Details',
        onBack: () => Navigator.pop(context),
        subtitle: widget.product.category,

        // -------- Favorite heart: red when favorite, clear when not --------
        actionWidget: BlocBuilder<HomeCubit, HomeState>(
          // Rebuild on any state that can change the favorites snapshot.
          buildWhen: (_, current) =>
          current is GetHomeLoaded ||
              current is FavoritesLoadedState ||
              current is FailedToUpdateFavoriteError,
          builder: (context, state) {
            // Read the live snapshot instead of `state is GetHomeLoaded` —
            // this also works when arriving from the favorites/cart pages,
            // where the last state isn't GetHomeLoaded.
            final isFavorite = cubit.isProductFavorite(widget.product.id);
            return InkWell(
              onTap: () => cubit.toggleFavorite(widget.product.id),
              borderRadius: BorderRadius.circular(14.r),
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 8.r,
                      offset: Offset(0, 2.h),
                    ),
                  ],
                ),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 24.sp,
                  color: isFavorite ? AppColors.accent : AppColors.ink,
                ),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------- Image --------
            Hero(
              tag: 'product-${widget.product.id}',
              child: Container(
                height: 300.h,
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 12.r,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
                child: AppCachedImage(imageUrl: widget.product.image),
              ),
            ),
            SizedBox(height: 20.h),

            // -------- Category chip --------
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.ink,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                widget.product.category.isEmpty
                    ? 'General'
                    : widget.product.category[0].toUpperCase() +
                    widget.product.category.substring(1),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.card,
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // -------- Title --------
            Text(
              widget.product.title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
                height: 1.3, // line-height multiplier — never scale this
              ),
            ),
            SizedBox(height: 12.h),

            // -------- Rating + review count --------
            Row(
              children: [
                Icon(Icons.star_rounded, size: 20.sp, color: AppColors.star),
                SizedBox(width: 4.w),
                Text(
                  widget.product.rating.rate.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  '(${widget.product.rating.count} reviews)',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.textGreyLight,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // -------- Description --------
            Text(
              'Description',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              widget.product.description,
              style: TextStyle(
                fontSize: 13.5.sp,
                height: 1.6, // line-height multiplier — never scale this
                color: AppColors.textGreyDark,
              ),
            ),
            SizedBox(height: 100.h), // space above bottom bar
          ],
        ),
      ),

      // -------- Bottom bar: price + add to cart --------
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
            20.w, 12.h, 20.w, 12.h + MediaQuery.of(context).padding.bottom),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 16.r,
              offset: Offset(0, -4.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Price',
                  style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey),
                ),
                Text(
                  '\$${widget.product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
              ],
            ),
            SizedBox(width: 20.w),

            // -------- Cart button: accent (red) when already in cart --------
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (_, current) =>
                current is GetHomeLoaded ||
                    current is AddedProductSuccessToCart ||
                    current is CartLoadedState ||
                    current is ProductAlreadyInCart,
                builder: (context, state) {
                  final inCart = cubit.isProductInCart(widget.product.id);
                  return ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      inCart ? AppColors.accent : AppColors.ink,
                      foregroundColor: AppColors.card,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    onPressed: () => cubit.addToCart(widget.product),
                    icon: Icon(
                      inCart
                          ? Icons.shopping_cart_rounded
                          : Icons.shopping_bag_outlined,
                      size: 20.sp,
                    ),
                    label: Text(
                      inCart ? 'In Cart' : 'Add to Cart',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}