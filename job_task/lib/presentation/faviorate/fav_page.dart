import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_task/data/model/response/faviorate_entity.dart';
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
    homeCubit=HomeCubit.get(context);
    // Assumes HomeCubit is provided above this page (same as the cart page).
    homeCubit.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: BlocConsumer<HomeCubit, HomeState>(
        listenWhen: (_, current) =>
        current is FailedToUpdateFavoriteError ||
            current is ProductAlreadyInCart ||
            current is AddedProductSuccessToCart ||
            current is FailedToAddedProductError,
        listener: (context, state) {
          final messenger = ScaffoldMessenger.of(context);
          switch (state) {
            case FailedToUpdateFavoriteError(:final error):
              messenger.showSnackBar(SnackBar(content: Text(error)));
            case FailedToAddedProductError(:final error):
              messenger.showSnackBar(SnackBar(content: Text(error)));
            case ProductAlreadyInCart(:final productName):
              messenger.showSnackBar(
                SnackBar(content: Text('$productName is already in the cart')),
              );
            case AddedProductSuccessToCart():
              messenger.showSnackBar(
                const SnackBar(content: Text('Added to cart')),
              );
          }
        },
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
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Could not load favorites'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: homeCubit.loadFavorites,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );

            case FavoritesLoadedState(:final favorites):
              if (favorites.isEmpty) {
                return const Center(
                  child: Text('No favorites yet — tap the heart on a product'),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: favorites.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) =>
                    _FavoriteTile(item: favorites[index], cubit: homeCubit),
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _FavoriteTile extends StatelessWidget {
  const _FavoriteTile({required this.item, required this.cubit});

  final FavoriteEntity item;
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: SizedBox(
          width: 48,
          height: 48,
          child: item.image == null
              ? const Icon(Icons.image_not_supported)
              : Image.network(
            item.image!,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) =>
            const Icon(Icons.image_not_supported),
          ),
        ),
        title: Text(
          item.name ?? 'Product ${item.productId}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: item.priceAsDouble == null
            ? null
            : Text('\$${item.priceAsDouble!.toStringAsFixed(2)}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              tooltip: 'Add to cart',
              onPressed: () => cubit.addFavoriteToCart(item),
            ),
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              tooltip: 'Remove from favorites',
              onPressed: () => cubit.removeFavorite(item),
            ),
          ],
        ),
      ),
    );
  }
}