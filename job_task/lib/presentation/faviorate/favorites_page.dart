import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_task/core/theme/app_colors.dart';
import 'package:job_task/services/home_page/home_cubit.dart';
import 'package:job_task/services/home_page/home_state.dart';
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late HomeCubit homeCubit;

  @override
  void initState() {
    super.initState();

    homeCubit = HomeCubit.get(context);
    homeCubit.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.ink,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.ink,
          ),

          onPressed: () {
            homeCubit.restoreHomeState();

            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Favorites',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) {
          return current is FavoritesLoadingState ||
              current is FavoritesLoadedState ||
              current is FavoritesFailed;
        },
        builder: (context, state) {
          if (state is FavoritesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is FavoritesFailed) {
            return _buildError();
          }

          if (state is FavoritesLoadedState) {
            final favorites = state.favorites;

            if (favorites.data.isEmpty) {
              return _buildEmpty();
            }

            return RefreshIndicator(
              onRefresh: () async {
                await homeCubit.loadFavorites();
              },
              child: ListView.separated(
                padding: EdgeInsets.all(16.w),
                itemCount: favorites.data.length,
                separatorBuilder: (_, __) {
                  return SizedBox(height: 12.h);
                },
                itemBuilder: (context, index) {
                  final favorite = favorites.data[index];

                  return _buildFavoriteItem(favorite);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildFavoriteItem(dynamic favorite) {
    final product = favorite.product;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildProductImage(product.mainImage),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.nameEn,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  '\$${product.price}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          _buildRemoveButton(favorite),
        ],
      ),
    );
  }

  Widget _buildProductImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: SizedBox(
        width: 75.w,
        height: 75.w,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.textGrey.withOpacity(0.1),
              child: Icon(
                Icons.image_not_supported_outlined,
                color: AppColors.textGrey,
                size: 30.sp,
              ),
            );
          },
          loadingBuilder: (
              context,
              child,
              loadingProgress,
              ) {
            if (loadingProgress == null) {
              return child;
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRemoveButton(dynamic favorite) {
    return Material(
      color: AppColors.accent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          _removeFavorite(favorite);
        },
        child: Padding(
          padding: EdgeInsets.all(9.w),
          child: Icon(
            Icons.favorite,
            color: AppColors.card,
            size: 20.sp,
          ),
        ),
      ),
    );
  }

  Future<void> _removeFavorite(dynamic favorite) async {
    final productName = favorite.product.nameEn;

    final shouldRemove = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remove Favorite'),
          content: Text(
            'Remove "$productName" from favorites?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );

    if (shouldRemove != true) {
      return;
    }

    // Use the favorite row ID.
    //
    // API response:
    // favorite.id       -> 2
    // favorite.productId -> 1
    //
    // If remove-faviorate/{id} expects the favorite ID,
    // use favorite.id.
    await homeCubit.removeFavorite(favorite.id);
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 70.sp,
              color: AppColors.textGrey,
            ),
            SizedBox(height: 16.h),
            Text(
              'No favorites yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Products you add to your favorites will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 60.sp,
              color: AppColors.accent,
            ),
            SizedBox(height: 16.h),
            Text(
              'Could not load favorites',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
            ),
            SizedBox(height: 12.h),
            ElevatedButton(
              onPressed: () {
                homeCubit.loadFavorites();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ink,
                foregroundColor: AppColors.card,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}