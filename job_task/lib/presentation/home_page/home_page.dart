import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:job_task/core/theme/app_colors.dart';
import 'package:job_task/core/utility/utility.dart';

import 'package:job_task/presentation/auth/login_screen.dart';
import 'package:job_task/presentation/cart/cart_page.dart';
import 'package:job_task/presentation/faviorate/favorites_page.dart';
import 'package:job_task/presentation/home_page/product_details.dart' hide ProductCard;
import 'package:job_task/presentation/home_page_menu/about_us_page.dart';
import 'package:job_task/presentation/home_page_menu/our_branch_page.dart';
import 'package:job_task/presentation/home_page_menu/profile_page.dart';
import 'package:job_task/presentation/widget/home_drawer.dart';
import 'package:job_task/presentation/widget/product_card.dart';

import 'package:job_task/services/auth/login/login_cubit.dart';
import 'package:job_task/services/home_drawer/home_drawer_cubit.dart';
import 'package:job_task/services/home_page/home_cubit.dart';
import 'package:job_task/services/home_page/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage>
    with Utility {
  final TextEditingController
  _searchController =
  TextEditingController();

  late HomeCubit homeCubit;

  @override
  void initState() {
    super.initState();

    homeCubit =
        HomeCubit.get(context);

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
      drawerEnableOpenDragGesture: true,

      // ==========================================================
      // DRAWER
      // ==========================================================

      drawer: HomeDrawer(
        onMyOrders: () {},

        onHomePage: () {
          Navigator.of(context).pop();
        },

        onSettings: () {
          navigateTo(
            context,
            BlocProvider(
              create: (_) =>
                  HomeDrawerCubit(),
              child:
              const ProfilePage(),
            ),
          );
        },

        onAbout: () {
          navigateTo(
            context,
            BlocProvider(
              create: (_) =>
                  HomeDrawerCubit(),
              child:
              const AboutUsPage(),
            ),
          );
        },

        onBranches: () {
          navigateTo(
            context,
            BlocProvider(
              create: (_) =>
                  HomeDrawerCubit(),
              child:
              const OurBranchesScreen(),
            ),
          );
        },

        onLogout: () {
          homeCubit.logout();
        },
      ),

      backgroundColor:
      AppColors.surface,

      // ==========================================================
      // APP BAR
      // ==========================================================

      appBar: AppBar(
        backgroundColor:
        AppColors.surface,

        elevation: 0,

        automaticallyImplyLeading:
        false,

        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color:
                AppColors.ink,
              ),

              onPressed: () {
                Scaffold.of(context)
                    .openDrawer();
              },
            );
          },
        ),

        title: const Text(
          'Home',

          style: TextStyle(
            color:
            AppColors.ink,

            fontWeight:
            FontWeight.bold,
          ),
        ),

        actions: [
          BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (
                previous,
                current,
                ) {
              return current
              is GetHomeLoaded ||
                  current
                  is FavoritesLoadedState ||
                  current
                  is AddedProductSuccessToCart ||
                  current
                  is CartLoadedState;
            },

            builder: (
                context,
                state,
                ) {
              return Row(
                children: [
                  // ==================================================
                  // FAVORITES
                  // ==================================================

                  getButtonBadge(
                    itemCount:
                    homeCubit
                        .favoriteCount,

                    icon:
                    Icons.favorite,

                    onTap: () async {
                      await Navigator.of(
                        context,
                      ).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              BlocProvider.value(
                                value:
                                homeCubit,

                                child:
                                const FavoritesPage(),
                              ),
                        ),
                      );

                      // Restore existing Home
                      // state without API call.
                      homeCubit
                          .restoreHomeState();
                    },
                  ),

                  SizedBox(
                    width: 5.w,
                  ),

                  // ==================================================
                  // CART
                  // ==================================================

                  getButtonBadge(
                    itemCount:
                    homeCubit
                        .cartCount,

                    icon:
                    Icons.shopping_cart,

                    onTap: () async {
                      await Navigator.of(
                        context,
                      ).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              BlocProvider.value(
                                value:
                                homeCubit,

                                child:
                                const CartPage(),
                              ),
                        ),
                      );

                      // Restore existing Home
                      // state without API call.
                      homeCubit
                          .restoreHomeState();
                    },
                  ),

                  SizedBox(
                    width: 10.w,
                  ),
                ],
              );
            },
          ),
        ],
      ),

      // ==========================================================
      // BODY
      // ==========================================================

      body:
      BlocListener<HomeCubit, HomeState>(
        listener: (
            context,
            state,
            ) {
          // ========================================================
          // LOGOUT
          // ========================================================

          if (state
          is ProfileLogout) {
            navigateTo(
              context,
              BlocProvider(
                create: (_) =>
                    LoginCubit(),

                child:
                const LoginScreen(),
              ),
            );

            return;
          }

          // ========================================================
          // PRODUCT DETAILS
          // ========================================================

          if (state
          is GoToProductDetails) {
            navigateTo(
              context,

              BlocProvider.value(
                value:
                homeCubit,

                child:
                ProductDetailsPage(
                  product:
                  state.productsEntity,
                ),
              ),
            );

            return;
          }

          // ========================================================
          // CART
          // ========================================================

          if (state
          is GoToCarts) {
            _openCart(context);

            return;
          }

          // ========================================================
          // FAVORITES
          // ========================================================

          if (state
          is GoToFavorites) {
            _openFavorites(context);

            return;
          }

          // ========================================================
          // ADD CART ERROR
          // ========================================================

          if (state
          is FailedToAddedProductError) {
            showSnack(
              context,
              state.error,
              AppColors.accent,
            );
          }
        },

        child:
        BlocBuilder<HomeCubit, HomeState>(
          builder: (
              context,
              state,
              ) {
            // ======================================================
            // LOADING
            // ======================================================

            if (state
            is GetHomeLoadingState ||
                state
                is GetHomeInitialState) {
              return const Center(
                child:
                CircularProgressIndicator(),
              );
            }

            // ======================================================
            // ERROR
            // ======================================================

            if (state
            is GetHomeFailed) {
              return getErrorView(
                message:
                state.error ?? '',

                onRetry:
                homeCubit.loadProducts,
              );
            }

            // ======================================================
            // LOADED
            // ======================================================

            if (state
            is GetHomeLoaded) {
              return _buildContent(
                homeCubit,
                state,
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  // ==============================================================
  // OPEN CART
  // ==============================================================

  Future<void> _openCart(
      BuildContext context,
      ) async {
    await Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (_) =>
            BlocProvider.value(
              value: homeCubit,

              child:
              const CartPage(),
            ),
      ),
    );

    homeCubit.restoreHomeState();
  }

  // ==============================================================
  // OPEN FAVORITES
  // ==============================================================

  Future<void> _openFavorites(
      BuildContext context,
      ) async {
    await Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (_) =>
            BlocProvider.value(
              value: homeCubit,

              child:
              const FavoritesPage(),
            ),
      ),
    );

    homeCubit.restoreHomeState();
  }

  // ==============================================================
  // HOME CONTENT
  // ==============================================================

  Widget _buildContent(
      HomeCubit homeCubit,
      GetHomeLoaded state,
      ) {
    return RefreshIndicator(
      onRefresh:
      homeCubit.loadProducts,

      child:
      CustomScrollView(
        physics:
        const AlwaysScrollableScrollPhysics(),

        slivers: [
          // ========================================================
          // SEARCH
          // ========================================================

          SliverToBoxAdapter(
            child: Padding(
              padding:
              const EdgeInsets.all(
                20,
              ),

              child: TextField(
                controller:
                _searchController,

                onChanged:
                homeCubit.search,

                decoration:
                InputDecoration(
                  hintText:
                  'Search products',

                  prefixIcon:
                  const Icon(
                    Icons.search,
                  ),

                  filled: true,

                  fillColor:
                  AppColors.card,

                  border:
                  OutlineInputBorder(
                    borderRadius:
                    BorderRadius
                        .circular(
                      16,
                    ),

                    borderSide:
                    BorderSide.none,
                  ),
                ),
              ),
            ),
          ),

          // ========================================================
          // PRODUCTS
          // ========================================================

          SliverPadding(
            padding:
            const EdgeInsets.all(
              20,
            ),

            sliver:
            SliverGrid(
              delegate:
              SliverChildBuilderDelegate(
                    (
                    context,
                    index,
                    ) {
                  final product =
                  state.products[
                  index];

                  final isFavorite =
                  homeCubit
                      .isProductFavorite(
                    product.id,
                  );

                  final isInCart =
                  homeCubit
                      .isProductInCart(
                    product.id,
                  );

                  return ProductCard(
                    product:
                    product,

                    isFavorite:
                    isFavorite,

                    isInCart:
                    isInCart,

                    // ==================================================
                    // OPEN DETAILS
                    // ==================================================

                    onTapped: () {
                      homeCubit
                          .goToProductDetails(
                        product,
                      );
                    },

                    // ==================================================
                    // FAVORITE
                    // ==================================================

                    onFavoriteTap:
                        () async {
                      await homeCubit
                          .toggleFavorite(
                        product.id,
                      );

                      // Rebuild Home with
                      // updated favoriteIds.
                      homeCubit
                          .restoreHomeState();
                    },

                    // ==================================================
                    // CART
                    // ==================================================

                    onCartTap: () async {
                      if (isInCart) {
                        _openCart(
                          context,
                        );

                        return;
                      }

                      await homeCubit
                          .addToCart(
                        product,
                        quantity: 1,
                      );

                      // Update cart icon
                      // on the product card.
                      homeCubit
                          .restoreHomeState();
                    },
                  );
                },

                childCount:
                state.products.length,
              ),

              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,

                childAspectRatio:
                .72,

                mainAxisSpacing:
                16,

                crossAxisSpacing:
                16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}