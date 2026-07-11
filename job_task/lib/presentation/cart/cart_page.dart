import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_task/core/extenstion/convert_from_cart_entity_to_product_item.dart';
import 'package:job_task/core/theme/app_colors.dart';
import 'package:job_task/core/utility/utility.dart';

import 'package:job_task/data/model/response/cart_entity.dart';
import 'package:job_task/presentation/home_page/product_details.dart';
import 'package:job_task/presentation/widget/app_image.dart';
import 'package:job_task/services/home_page/home_cubit.dart';
import 'package:job_task/services/home_page/home_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with Utility {
  late HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = HomeCubit.get(context);
    _homeCubit.loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: buildAppBar(
        context: context,
        title: 'My Cart',
        subtitle: 'Review your items',
        showBackButton: true,
      ),
      // BlocListener -> side effects (snackbar + navigation to details).
      body: BlocListener<HomeCubit, HomeState>(
        listenWhen: (_, curr) =>
        curr is FailedToUpdateProductError || curr is GoToProductDetails,
        listener: (context, state) {
          if (state is FailedToUpdateProductError) {
            showSnack(context, state.error, AppColors.accent);
          } else if (state is GoToProductDetails) {
            navigateTo(
              context,
              isReplacement: true,
              BlocProvider.value(
                value: _homeCubit,
                child: ProductDetailsPage(product: state.product),
              ),
            );
          }
        },
        // BlocBuilder -> the UI.
        child: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (_, curr) =>
          curr is CartInitialState ||
              curr is CartLoadingState ||
              curr is CartLoadedState ||
              curr is CartFailed,
          builder: (context, state) {
            if (state is CartFailed) {
              return getErrorView(
                message: 'Could not load your cart',
                onRetry: _homeCubit.loadCart,
              );
            }
            if (state is CartLoadedState) {
              if (state.cart.isEmpty) {
                return getEmptyView(
                  title: 'Your cart is empty',
                  subtitle: 'Add some products to get started',
                  icon: Icons.shopping_cart_outlined,
                );
              }
              return _buildBody(state.cart);
            }
            // Initial / loading
            return const Center(
              child: CircularProgressIndicator(color: AppColors.ink),
            );
          },
        ),
      ),
    );
  }

  // ---------------- confirm + remove ----------------

  /// Asks for confirmation; removes the item only if the user confirms.
  Future<void> _confirmAndRemove(CartEntity item) async {
    final confirmed = await showRemoveDialog(
      context,
      title: 'Remove from cart',
      message: 'Remove "${item.name}" from your cart?',
    );
    if (confirmed) {
      _homeCubit.removeCartItem(item);
    }
  }

  // ---------------- body: list + total bar ----------------

  Widget _buildBody(List<CartEntity> items) {
    final total = items.fold<double>(
      0.0,
          (sum, c) => sum + (c.price) * c.quantity,
    );
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
            itemCount: items.length,
            separatorBuilder: (_, _) => SizedBox(height: 12.h),
            itemBuilder: (_, i) => _buildTile(items[i]),
          ),
        ),
        _buildTotalBar(total),
      ],
    );
  }

  // ---------------- one cart row ----------------

  Widget _buildTile(CartEntity item) {
    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      // Ask before dismissing — returning false snaps the row back.
      confirmDismiss: (_) => showRemoveDialog(
        context,
        title: 'Remove from cart',
        message: 'Remove "${item.name}" from your cart?',
      ),
      onDismissed: (_) => _homeCubit.removeCartItem(item),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 24.w),
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Icon(Icons.delete_outline, color: Colors.white, size: 24.sp),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18.r),
        // Tapping a row opens the product details for that item.
        onTap: () {
          final full = _homeCubit.findLoadedProduct(item.productId);
          _homeCubit.goToProductDetails(
            full ?? ConvertFromCartEntityToProductItem.call(item),
          );
        },
        child: Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: AppColors.shadow),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100.w,
                height: 100.h,
                child: AppCachedImage(imageUrl: item.image),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '\$${((item.price) * item.quantity).toStringAsFixed(2)}', // this row's total
                      style: TextStyle(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    _buildQuantityStepper(item),
                  ],
                ),
              ),
              IconButton(
                // X button asks for confirmation first, too.
                onPressed: () => _confirmAndRemove(item),
                icon: Icon(Icons.close, size: 18.sp, color: AppColors.textGrey),
                splashRadius: 18.r,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- quantity: - qty + ----------------

  Widget _buildQuantityStepper(CartEntity item) {
    final canDecrement = item.quantity > 1;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStepButton(
            icon: Icons.remove,
            enabled: canDecrement,
            onTap: () => _homeCubit.changeQuantity(item, item.quantity - 1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Text(
              '${item.quantity}',
              style: TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.w700,
                fontSize: 15.sp,
              ),
            ),
          ),
          _buildStepButton(
            icon: Icons.add,
            enabled: true,
            onTap: () => _homeCubit.changeQuantity(item, item.quantity + 1),
          ),
        ],
      ),
    );
  }

  Widget _buildStepButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: 30.w,
        height: 30.w, // keep it a circle: same value for both sides
        decoration: BoxDecoration(
          color: enabled ? AppColors.ink : Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 16.sp,
          color: enabled ? AppColors.card : AppColors.textGrey,
        ),
      ),
    );
  }

  // ---------------- total bar ----------------

  Widget _buildTotalBar(double total) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h + bottomInset),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(color: AppColors.textGrey, fontSize: 15.sp),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: TextStyle(
                  color: AppColors.ink,
                  fontWeight: FontWeight.w800,
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ink,
                foregroundColor: AppColors.card,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                'Checkout',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}