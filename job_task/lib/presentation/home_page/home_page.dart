import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_task/core/theme/app_colors.dart';
import 'package:job_task/core/utility/utility.dart';
import 'package:job_task/presentation/auth/login_screen.dart';
import 'package:job_task/presentation/home_page/product_details.dart';
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
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Utility {
  final TextEditingController _searchController = TextEditingController();

  late HomeCubit homeCubit;

  @override
  void initState() {
    super.initState();

    homeCubit = HomeCubit.get(context);

    homeCubit.loadProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          // IMPORTANT
          drawerEnableOpenDragGesture: true,

          drawer: HomeDrawer(
            onMyOrders: () {},
            onHomePage: (){
              navigateTo(
                context,
                BlocProvider(
                    create: (_) => HomeCubit()..loadProducts(),
                    child: HomePage()
                ),
              );},


            onSettings: () { navigateTo(
              context,
              BlocProvider(
                create: (_) => HomeDrawerCubit(),
                child: ProfilePage()
              ),
            );},

            onAbout: () {
              navigateTo(
                context,
                BlocProvider(
                  create: (_) => HomeDrawerCubit(),
                  child: AboutUsPage(),
                ),
              );
            },

            onBranches: () {
              navigateTo(
                context,
                BlocProvider(
                  create: (_) => HomeDrawerCubit(),
                  child: OurBranchesScreen(),
                ),
              );
            },

            onLogout: () { homeCubit.logout();
              },
          ),

          backgroundColor: AppColors.surface,

          appBar: AppBar(
            backgroundColor: AppColors.surface,

            elevation: 0,

            automaticallyImplyLeading: true,

            // Hamburger button
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.ink),

                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),

            title: const Text(
              "Home",
              style: TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.bold,
              ),
            ),

            actions: [
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      getButtonBadge(
                        itemCount: homeCubit.favoriteCount,
                        icon: Icons.favorite,
                        onTap: () {
                          homeCubit.gotToFavorites();
                        },
                      ),

                      SizedBox(width: 5.w),

                      getButtonBadge(
                        itemCount: homeCubit.cartCount,
                        onTap: () {
                          homeCubit.gotToCarts();
                        },
                      ),

                      SizedBox(width: 10.w),
                    ],
                  );
                },
              ),
            ],
          ),

          body: BlocListener<HomeCubit, HomeState>(
            listener: (context, state) {
              if(state is ProfileLogout){ navigateTo(
                context,
                BlocProvider(
                  create:(c)=> LoginCubit(),

                  child: LoginScreen(),
                ),
              );}
              if (state is GoToProductDetails) {



                navigateTo(
                  context,
                  BlocProvider.value(
                    value: homeCubit,
                    child: ProductDetailsPage(product: state.productsEntity),
                  ),
                );
              } else if (state is GoToCarts) {
                // navigateTo(
                //   context,
                //   BlocProvider.value(value: homeCubit, child: const CartPage()),
                // );
              } else if (state is GoToFavorites) {
                // navigateTo(
                //   context,
                //   BlocProvider.value(
                //     value: homeCubit,
                //     child: const FavoritesPage(),
                //   ),
                // );
              } else if (state is GoToFavorites) {
                // navigateTo(
                //   context,
                //   BlocProvider.value(
                //     value: homeCubit,
                //     child: const FavoritesPage(),
                //   ),
              //  );
              }
              if (state is FailedToAddedProductError) {
                showSnack(context, state.error, AppColors.accent);
              }
            },

            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is GetHomeLoadingState ||
                    state is GetHomeInitialState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is GetHomeFailed) {
                  return getErrorView(
                    message: state.error ?? "",
                    onRetry: homeCubit.loadProducts,
                  );
                }

                if (state is GetHomeLoaded) {
                  return _buildContent(homeCubit, state);
                }

                return const SizedBox();
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(HomeCubit homeCubit, GetHomeLoaded state) {
    return RefreshIndicator(
      onRefresh: homeCubit.loadProducts,

      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: TextField(
                controller: _searchController,

                onChanged: homeCubit.search,

                decoration: InputDecoration(
                  hintText: "Search products",

                  prefixIcon: const Icon(Icons.search),

                  filled: true,

                  fillColor: AppColors.card,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),

                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(20),

            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final product = state.products[index];

                return ProductCard(
                  product: product,

                  onTapped: () {
                    homeCubit.goToProductDetails(product);
                  },

                  onCartTap: () {
                 //   homeCubit.addToCart(product);
                  },

                  isFavorite: false,

                  onFavoriteTap: () {
                   // homeCubit.toggleFavorite(product.id);
                  },
                );
              }, childCount: state.products.length),

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,

                childAspectRatio: .72,

                mainAxisSpacing: 16,

                crossAxisSpacing: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
