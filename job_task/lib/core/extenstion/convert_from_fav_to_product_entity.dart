import 'package:job_task/data/model/response/product_entity.dart';
import 'package:job_task/data/model/response/favorite_entity.dart';

class ConvertFromFavoriteEntityToProductItem {
  const ConvertFromFavoriteEntityToProductItem._(); // no instances

  /// Maps a FavoriteEntity back to a ProductEntity.
  ///
  /// FavoriteEntity has no description/category/rating,
  /// so those fall back to defaults. `productId` becomes the product's `id`.
  static ProductEntity call(FavoriteEntity favorite) {
    return ProductEntity(
      favorite.productId, // id
      favorite.name, // title
      favorite.price, // price
      '', // description (not in favorite)
      '', // category (not in favorite)
      favorite.image, // image
      ProductRatingEntity(0, 0), // rating (not in favorite)
    );
  }

  /// Convenience for converting a whole favorites list.
  static List<ProductEntity> fromList(List<FavoriteEntity> favorites) =>
      favorites.map(call).toList();
}