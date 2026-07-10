import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
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
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: AppColors.accent,
                ),
              );
          } else if (state is GoToProductDetails) {
            navigateTo(
              context,
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

  // ---------------- body: list + total bar ----------------

  Widget _buildBody(List<CartEntity> items) {
    final total = items.fold<double>(
      0.0,
          (sum, c) => sum + (c.priceAsDouble ?? 0) * c.quantity,
    );
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
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
      onDismissed: (_) => _homeCubit.removeCartItem(item),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        // Tapping a row opens the product details for that item.
        onTap: () {
          final full = _homeCubit.findLoadedProduct(item.productId);
          _homeCubit.goToProductDetails(
            full ?? ConvertFromCartEntityToProductItem.call(item),
          );
        },

        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.shadow),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100.w,
                height: 100.h,
                child: AppCachedImage(imageUrl: item.image ?? ''),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name ?? 'Unnamed product',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '\$${item.price}', // this row's total
                      style: const TextStyle(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildQuantityStepper(item),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _homeCubit.removeCartItem(item),
                icon: const Icon(Icons.close,
                    size: 18, color: AppColors.textGrey),
                splashRadius: 18,
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
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStepButton(
            icon: Icons.remove,
            enabled: canDecrement,
            onTap: () => _homeCubit.changeQuantity(item, item.quantity - 1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              '${item.quantity}',
              style: const TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.w700,
                fontSize: 15,
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
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: enabled ? AppColors.ink : Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 16,
          color: enabled ? AppColors.card : AppColors.textGrey,
        ),
      ),
    );
  }

  // ---------------- total bar ----------------

  Widget _buildTotalBar(double total) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 20 + bottomInset),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total',
                  style: TextStyle(color: AppColors.textGrey, fontSize: 15)),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: AppColors.ink,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ink,
                foregroundColor: AppColors.card,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}