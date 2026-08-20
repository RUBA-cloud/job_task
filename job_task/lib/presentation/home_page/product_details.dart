import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:job_task/core/theme/app_colors.dart';
import 'package:job_task/core/utility/utility.dart';
import 'package:job_task/data/model/response/category_entity.dart';
import 'package:job_task/services/home_page/home_cubit.dart';
import 'package:job_task/services/home_page/home_state.dart';

class ProductDetailsPage extends StatefulWidget {
  final CategoryDataDataProductsEntity product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> with  Utility  {
  // ============================================================b
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (
          previous,
          current,
          ) {
        return current is ProductDetailsState;
      },
      builder: (
          context,
          state,
          ) {
        final cubit = HomeCubit.get(context);

        final detailsState =
        state is ProductDetailsState
            ? state
            : null;

        final selectedImage =
            detailsState?.selectedImage ?? 0;

        final selectedColor =
            detailsState?.selectedColor ?? 0;

        final selectedSize =
            detailsState?.selectedSize ?? 0;

        final quantity =
            detailsState?.quantity ?? 1;

        final selectedAdditions =
            detailsState?.selectedAdditions ??
                {};

        return Scaffold(
          backgroundColor:
          AppColors.surface,

          // ==================================================
          // APP BAR
          // ==================================================

          appBar: buildAppBar(
              context: context,title: "Product Details", onBack: (){cubit.loadProducts(); Navigator.maybePop(context);},
              showBackButton: true),





          // ==================================================
          // BODY
          // ==================================================

          body: SafeArea(
            child: SingleChildScrollView(
              physics:
              const BouncingScrollPhysics(),
              padding:
              EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  // IMAGE
                  _buildImages(
                    context,
                    cubit,
                    selectedImage,
                  ),

                  SizedBox(height: 22.h),

                  // NAME
                  Text(
                    widget.product.nameEn,
                    style: TextStyle(
                      color:
                      AppColors.ink,
                      fontSize: 23.sp,
                      fontWeight:
                      FontWeight.w800,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // PRICE
                  Text(
                    '\$${widget.product.price}',
                    style: TextStyle(
                      color:
                      AppColors.accent,
                      fontSize: 20.sp,
                      fontWeight:
                      FontWeight.w800,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // DESCRIPTION
                  if (widget.product
                      .descriptionEn
                      .isNotEmpty)
                    Text(
                      widget.product
                          .descriptionEn,
                      style: TextStyle(
                        color: AppColors
                            .textGreyDark,
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                    ),

                  SizedBox(height: 25.h),

                  // COLORS
                  if (widget.product.colors
                      .isNotEmpty)
                    _buildColors(
                      context,
                      cubit,
                      selectedColor,
                    ),

                  // SIZES
                  if (widget.product.sizes
                      .isNotEmpty)
                    _buildSizes(
                      context,
                      cubit,
                      selectedSize,
                    ),

                  // ADDITIONS
                  if (widget.product.additionals
                      .isNotEmpty)
                    _buildAdditions(
                      context,
                      cubit,
                      selectedAdditions,
                    ),

                  // QUANTITY
                  _buildQuantity(
                    context,
                    cubit,
                    quantity,
                  ),

                  SizedBox(height: 30.h),

                  // ADD TO CART
                  _buildAddToCart(
                    context,
                    cubit,
                    quantity,
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  Widget _buildImages(
      BuildContext context,
      HomeCubit cubit,
      int selectedImage,
      ) {
    final images = <String>[
      widget.product.mainImage,
      ...widget.product.images.map(
            (item) => item.imagePath,
      ),
    ];

    final safeIndex =
    selectedImage >= 0 &&
        selectedImage < images.length
        ? selectedImage
        : 0;

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 320.h,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius:
            BorderRadius.circular(20.r),
            border: Border.all(
              color: AppColors.border,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 12,
                offset:
                const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius:
            BorderRadius.circular(20.r),
            child: Image.network(
              images[safeIndex],
              fit: BoxFit.contain,
              errorBuilder: (
                  context,
                  error,
                  stackTrace,
                  ) {
                return Icon(
                  Icons
                      .image_not_supported_outlined,
                  color:
                  AppColors.textGrey,
                  size: 50.sp,
                );
              },
            ),
          ),
        ),

        SizedBox(height: 12.h),

        if (images.length > 1)
          SizedBox(
            height: 70.h,
            child: ListView.separated(
              scrollDirection:
              Axis.horizontal,
              itemCount: images.length,
              separatorBuilder:
                  (_, _) =>
                  SizedBox(width: 10.w),
              itemBuilder: (
                  context,
                  index,
                  ) {
                final selected =
                    index ==
                        selectedImage;

                return GestureDetector(
                  onTap: () {
                    cubit
                        .selectProductImage(
                      index,
                    );
                  },
                  child: Container(
                    width: 70.w,
                    height: 70.w,
                    padding:
                    EdgeInsets.all(3.w),
                    decoration:
                    BoxDecoration(
                      color:
                      AppColors.card,
                      borderRadius:
                      BorderRadius
                          .circular(
                        12.r,
                      ),
                      border: Border.all(
                        color: selected
                            ? AppColors
                            .accent
                            : AppColors
                            .border,
                        width: selected
                            ? 2
                            : 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius
                          .circular(
                        9.r,
                      ),
                      child:
                      Image.network(
                        images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  // ============================================================
  Widget _buildColors(
      BuildContext context,
      HomeCubit cubit,
      int selectedColor,
      ) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        _sectionTitle('Color'),

        SizedBox(height: 12.h),

        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: List.generate(
            widget.product.colors.length,
                (index) {
              final selected =
                  index == selectedColor;

              return GestureDetector(
                onTap: () {
                  cubit
                      .selectProductColor(
                    index,
                  );
                },
                child: AnimatedContainer(
                  duration:
                  const Duration(
                    milliseconds: 200,
                  ),
                  padding:
                  EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 11.h,
                  ),
                  decoration:
                  BoxDecoration(
                    color: selected
                        ? AppColors.ink
                        : AppColors.card,
                    borderRadius:
                    BorderRadius
                        .circular(
                      12.r,
                    ),
                    border: Border.all(
                      color: selected
                          ? AppColors.ink
                          : AppColors.border,
                    ),
                  ),
                  child: Row(
                    mainAxisSize:
                    MainAxisSize.min,
                    children: [
                      Container(
                        width: 14.w,
                        height: 14.w,
                        decoration:
                        BoxDecoration(
                          color: selected
                              ? AppColors
                              .card
                              : AppColors
                              .textGrey,
                          shape:
                          BoxShape.circle,
                        ),
                      ),

                      SizedBox(
                        width: 8.w,
                      ),

                      Text(
                        widget.product
                            .colors[index],
                        style: TextStyle(
                          color: selected
                              ? AppColors
                              .card
                              : AppColors
                              .ink,
                          fontSize: 14.sp,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 25.h),
      ],
    );
  }

  // ============================================================
  Widget _buildSizes(
      BuildContext context,
      HomeCubit cubit,
      int selectedSize,
      ) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        _sectionTitle('Size'),

        SizedBox(height: 12.h),

        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: List.generate(
            widget.product.sizes.length,
                (index) {
              final selected =
                  index == selectedSize;

              final size =
              widget.product.sizes[index];

              return GestureDetector(
                onTap: () {
                  cubit.selectProductSize(
                    index,
                  );
                },
                child: AnimatedContainer(
                  duration:
                  const Duration(
                    milliseconds: 200,
                  ),
                  padding:
                  EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  decoration:
                  BoxDecoration(
                    color: selected
                        ? AppColors.ink
                        : AppColors.card,
                    borderRadius:
                    BorderRadius
                        .circular(
                      12.r,
                    ),
                    border: Border.all(
                      color: selected
                          ? AppColors.ink
                          : AppColors.border,
                    ),
                  ),
                  child: Text(
                    size.nameEn,
                    style: TextStyle(
                      color: selected
                          ? AppColors.card
                          : AppColors.ink,
                      fontSize: 14.sp,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 25.h),
      ],
    );
  }

  // ============================================================
  Widget _buildAdditions(
      BuildContext context,
      HomeCubit cubit,
      Set<int> selectedAdditions,
      ) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        _sectionTitle('Additions'),

        SizedBox(height: 12.h),

        ...List.generate(
          widget.product.additionals.length,
              (index) {
            final selected =
            selectedAdditions
                .contains(index);

            return GestureDetector(
              onTap: () {
                cubit
                    .toggleProductAddition(
                  index,
                );
              },
              child: Container(
                margin:
                EdgeInsets.only(
                  bottom: 10.h,
                ),
                padding:
                EdgeInsets.all(14.w),
                decoration:
                BoxDecoration(
                  color:
                  AppColors.card,
                  borderRadius:
                  BorderRadius.circular(
                    14.r,
                  ),
                  border: Border.all(
                    color: selected
                        ? AppColors.accent
                        : AppColors.border,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      selected
                          ? Icons.check_circle
                          : Icons
                          .radio_button_unchecked,
                      color: selected
                          ? AppColors.accent
                          : AppColors
                          .textGrey,
                    ),

                    SizedBox(
                      width: 12.w,
                    ),

                    Expanded(
                      child: Text(
                        'Addition ${index + 1}',
                        style:
                        TextStyle(
                          color:
                          AppColors.ink,
                          fontSize:
                          14.sp,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        SizedBox(height: 15.h),
      ],
    );
  }

  // ============================================================
  Widget _buildQuantity(
      BuildContext context,
      HomeCubit cubit,
      int quantity,
      ) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        _sectionTitle('Quantity'),

        Container(
          decoration:
          BoxDecoration(
            color: AppColors.card,
            borderRadius:
            BorderRadius.circular(
              14.r,
            ),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: quantity > 1
                    ? cubit
                    .decreaseQuantity
                    : null,
                icon: Icon(
                  Icons.remove,
                  color: quantity > 1
                      ? AppColors.ink
                      : AppColors.textGrey,
                ),
              ),

              SizedBox(
                width: 25.w,
                child: Text(
                  '$quantity',
                  textAlign:
                  TextAlign.center,
                  style: TextStyle(
                    color:
                    AppColors.ink,
                    fontSize: 16.sp,
                    fontWeight:
                    FontWeight.w700,
                  ),
                ),
              ),

              IconButton(
                onPressed:
                cubit.increaseQuantity,
                icon: const Icon(
                  Icons.add,
                  color: AppColors.ink,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  Widget _buildAddToCart(
      BuildContext context,
      HomeCubit cubit,
      int quantity,
      ) {
    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: ElevatedButton(
        onPressed: () {
          cubit.addToCart(
            widget.product,
            quantity: quantity,
          );
        },
        style:
        ElevatedButton.styleFrom(
          backgroundColor:
          AppColors.ink,
          foregroundColor:
          AppColors.card,
          elevation: 0,
          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(
              16.r,
            ),
          ),
        ),
        child: Text(
          'Add to Cart',
          style: TextStyle(
            color: AppColors.card,
            fontSize: 16.sp,
            fontWeight:
            FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // ============================================================
  Widget _sectionTitle(
      String title,
      ) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.ink,
        fontSize: 17.sp,
        fontWeight:
        FontWeight.w800,
      ),
    );
  }
}