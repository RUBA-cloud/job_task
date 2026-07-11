import 'package:job_task/data/model/response/product_entity.dart';
import 'package:job_task/data/model/response/cart_entity.dart';

class ConvertFromCartEntityToProductItem {
  const ConvertFromCartEntityToProductItem._(); // no instances

  /// Maps a CartEntity to a ProductEntity.
  ///
  /// CartEntity has no description/rating and stores price as a nullable String,
  /// so those fall back to defaults. `productId` becomes the product's `id`.
  static ProductEntity call(CartEntity cart) {
    return ProductEntity(
      cart.productId,                              // id
      cart.name,                             // title
      cart.price ,                 // price (String -> double)
      '',                                          // description (not in cart)
      '',                                          // category (not in cart)
      cart.image,                            // image
      ProductRatingEntity(0, 0),                   // rating (not in cart)
    );
  }

  /// Convenience for converting a whole cart list.
  static List<ProductEntity> fromList(List<CartEntity> carts) =>
      carts.map(call).toList();
}