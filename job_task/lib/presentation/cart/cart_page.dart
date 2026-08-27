import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:job_task/core/theme/app_colors.dart';
import 'package:job_task/core/utility/utility.dart';

import 'package:job_task/data/model/response/cart/cart_entity.dart';

import 'package:job_task/presentation/home_page/product_details.dart';
import 'package:job_task/presentation/order/address_page.dart';
import 'package:job_task/presentation/widget/app_image.dart';

import 'package:job_task/services/home_page/home_cubit.dart';
import 'package:job_task/services/home_page/home_state.dart';
import 'package:job_task/services/order/order_cubit.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with Utility {
  late HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();

    _homeCubit = HomeCubit.get(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeCubit.loadCart();
    });
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
        onBack: () {
          _homeCubit.restoreHomeState();

          Navigator.of(context).pop();
        },
      ),

      body: BlocListener<HomeCubit, HomeState>(
        listenWhen: (_, current) {
          return current
          is FailedToUpdateProductError ||
              current is GoToProductDetails;
        },

        listener: (context, state) {
          if (state
          is FailedToUpdateProductError) {
            showSnack(
              context,
              state.error,
              AppColors.accent,
            );
          }

          if (state is GoToProductDetails) {
            navigateTo(
              context,
              isReplacement: true,
              BlocProvider.value(
                value: _homeCubit,
                child: ProductDetailsPage(
                  product:state.productsEntity
                ),
              ),
            );
          }
        },

        child: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (_, current) {
            return current is CartInitialState ||
                current is CartLoadingState ||
                current is CartLoadedState ||
                current is CartFailed;
          },

          builder: (context, state) {
            // ==================================================
            // ERROR
            // ==================================================

            if (state is CartFailed) {
              return getErrorView(
                message:
                state.error,

                onRetry:
                _homeCubit.loadCart,
              );
            }

            // ==================================================
            // LOADED
            // ==================================================

            if (state is CartLoadedState) {
              if (state.cart.data.isEmpty) {
                return getEmptyView(
                  title: 'Your cart is empty',
                  subtitle:
                  'Add some products to get started',
                  icon:
                  Icons.shopping_cart_outlined,
                );
              }

              return _buildBody(
                state.cart.data,
              );
            }

            // ==================================================
            // LOADING
            // ==================================================

            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.ink,
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // BODY
  // ============================================================

  Widget _buildBody(
      List<CartDataEntity> items,
      ) {
    final total = items.fold<double>(
      0.0,
          (sum, item) {
        final price =
            double.tryParse(
              item.product.price,
            ) ??
                0.0;

        return sum +
            (price * item.quantity);
      },
    );

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(
              16.w,
              16.h,
              16.w,
              8.h,
            ),

            itemCount: items.length,

            separatorBuilder: (_, _) {
              return SizedBox(
                height: 12.h,
              );
            },

            itemBuilder: (_, index) {
              return _buildTile(
                items[index],
              );
            },
          ),
        ),

        _buildTotalBar(total),
      ],
    );
  }

  // ============================================================
  // CART TILE
  // ============================================================

  Widget _buildTile(
      CartDataEntity item,
      ) {
    final product = item.product;

    final price =
        double.tryParse(product.price) ?? 0.0;

    final itemTotal =
        price * item.quantity;

    return Dismissible(
      key: ValueKey(item.id),

      direction:
      DismissDirection.endToStart,

      confirmDismiss: (_) {
        return showRemoveDialog(
          context,
          title: 'Remove from cart',
          message:
          'Remove "${product.nameEn}" from your cart?',
        );
      },

      onDismissed: (_) {
        _homeCubit.removeCartItem(item);
      },

      background: Container(
        alignment:
        Alignment.centerRight,

        padding: EdgeInsets.only(
          right: 24.w,
        ),

        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius:
          BorderRadius.circular(18.r),
        ),

        child: Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 24.sp,
        ),
      ),

      child: InkWell(
        borderRadius:
        BorderRadius.circular(18.r),

        onTap: () {
          final loadedProduct =
          _homeCubit.findLoadedProduct(
            item.productId,
          );

          if (loadedProduct != null) {
            _homeCubit.goToProductDetails(
              loadedProduct,
            );
          }
        },

        child: Container(
          padding:
          EdgeInsets.all(12.r),

          decoration: BoxDecoration(
            color: AppColors.card,

            borderRadius:
            BorderRadius.circular(18.r),

            border: Border.all(
              color: AppColors.shadow,
            ),
          ),

          child: Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              // ==================================================
              // PRODUCT IMAGE
              // ==================================================

              SizedBox(
                width: 100.w,
                height: 100.h,

                child: AppCachedImage(
                  imageUrl:
                  product.mainImage,
                ),
              ),

              SizedBox(width: 12.w),

              // ==================================================
              // PRODUCT INFO
              // ==================================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [
                    Text(
                      product.nameEn,

                      maxLines: 2,

                      overflow:
                      TextOverflow.ellipsis,

                      style: TextStyle(
                        color:
                        AppColors.ink,
                        fontWeight:
                        FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),

                    SizedBox(
                      height: 6.h,
                    ),

                    Text(
                      '\$${itemTotal.toStringAsFixed(2)}',

                      style: TextStyle(
                        color:
                        AppColors.ink,
                        fontWeight:
                        FontWeight.w700,
                        fontSize: 15.sp,
                      ),
                    ),

                    SizedBox(
                      height: 10.h,
                    ),

                    _buildQuantityStepper(
                      item,
                    ),
                  ],
                ),
              ),

              // ==================================================
              // REMOVE BUTTON
              // ==================================================

              IconButton(
                onPressed: () {
                  _confirmAndRemove(
                    item,
                  );
                },

                icon: Icon(
                  Icons.close,
                  size: 18.sp,
                  color:
                  AppColors.textGrey,
                ),

                splashRadius: 18.r,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CONFIRM REMOVE
  // ============================================================

  Future<void> _confirmAndRemove(
      CartDataEntity item,
      ) async {
    final confirmed =
    await showRemoveDialog(
      context,
      title: 'Remove from cart',
      message:
      'Remove "${item.product.nameEn}" from your cart?',
    );

    if (!mounted) {
      return;
    }

    if (confirmed) {
      await _homeCubit.removeCartItem(
        item,
      );
    }
  }

  // ============================================================
  // QUANTITY STEPPER
  // ============================================================

  Widget _buildQuantityStepper(
      CartDataEntity item,
      ) {
    final canDecrement =
        item.quantity > 1;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius:
        BorderRadius.circular(30.r),
      ),

      padding:
      EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 2.h,
      ),

      child: Row(
        mainAxisSize:
        MainAxisSize.min,

        children: [
          // ==================================================
          // MINUS
          // ==================================================

          _buildStepButton(
            icon: Icons.remove,

            enabled:
            canDecrement,

            onTap: () {
              _homeCubit.changeQuantity(
                item,
                item.quantity - 1,
              );
            },
          ),

          // ==================================================
          // QUANTITY
          // ==================================================

          Padding(
            padding:
            EdgeInsets.symmetric(
              horizontal: 14.w,
            ),

            child: Text(
              '${item.quantity}',

              style: TextStyle(
                color:
                AppColors.ink,
                fontWeight:
                FontWeight.w700,
                fontSize: 15.sp,
              ),
            ),
          ),

          // ==================================================
          // PLUS
          // ==================================================

          _buildStepButton(
            icon: Icons.add,

            enabled: true,

            onTap: () {
              _homeCubit.changeQuantity(
                item,
                item.quantity + 1,
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STEP BUTTON
  // ============================================================

  Widget _buildStepButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap:
      enabled ? onTap : null,

      borderRadius:
      BorderRadius.circular(20.r),

      child: Container(
        width: 30.w,
        height: 30.w,

        decoration:
        BoxDecoration(
          color: enabled
              ? AppColors.ink
              : Colors.grey.shade300,

          shape: BoxShape.circle,
        ),

        child: Icon(
          icon,
          size: 16.sp,

          color: enabled
              ? AppColors.card
              : AppColors.textGrey,
        ),
      ),
    );
  }

  // ============================================================
  // TOTAL BAR
  // ============================================================

  Widget _buildTotalBar(
      double total,
      ) {
    final bottomInset =
        MediaQuery.of(context)
            .padding
            .bottom;

    return Container(
      padding:
      EdgeInsets.fromLTRB(
        20.w,
        16.h,
        20.w,
        20.h + bottomInset,
      ),

      decoration: BoxDecoration(
        color: AppColors.card,

        borderRadius:
        BorderRadius.vertical(
          top:
          Radius.circular(24.r),
        ),

        boxShadow: [
          BoxShadow(
            color:
            AppColors.shadow,
            blurRadius: 16.r,
            offset:
            Offset(0, -4.h),
          ),
        ],
      ),

      child: Column(
        mainAxisSize:
        MainAxisSize.min,

        children: [
          // ==================================================
          // TOTAL
          // ==================================================

          Row(
            mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

            children: [
              Text(
                'Total',

                style: TextStyle(
                  color:
                  AppColors.textGrey,
                  fontSize: 15.sp,
                ),
              ),

              Text(
                '\$${total.toStringAsFixed(2)}',

                style: TextStyle(
                  color:
                  AppColors.ink,
                  fontWeight:
                  FontWeight.w800,
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),

          SizedBox(
            height: 14.h,
          ),

          // ==================================================
          // CHECKOUT
          // ==================================================

          SizedBox(
            width:
            double.infinity,

            height: 52.h,

            child:
            ElevatedButton(
              onPressed: () {
                navigateTo(context, BlocProvider(
                  create: (_) => OrderCubit(),
                  child: AddressPage(cartEntity: _homeCubit.cart!,)));
                   // cartEntity: _homeCubit.cart!,

              },

              style:
              ElevatedButton.styleFrom(
                backgroundColor:
                AppColors.ink,

                foregroundColor:
                AppColors.card,

                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    16.r,
                  ),
                ),
              ),

              child: Text(
                'Checkout',

                style: TextStyle(
                  fontWeight:
                  FontWeight.w700,
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