import 'package:json_annotation/json_annotation.dart';

part 'faviorate_entity.g.dart';

@JsonSerializable()
class FaviorateEntity {
  final String? message;
  final List<FavoriteItem> data;

  const FaviorateEntity({
    this.message,
    required this.data,
  });

  factory FaviorateEntity.fromJson(Map<String, dynamic> json) =>
      _$FaviorateEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FaviorateEntityToJson(this);
}

@JsonSerializable()
class FavoriteItem {
  final int id;

  @JsonKey(name: 'product_id')
  final int productId;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'is_active')
  final int isActive;

  final ProductFavorite product;

  const FavoriteItem({
    required this.id,
    required this.productId,
    required this.userId,
    required this.isActive,
    required this.product,
  });

  factory FavoriteItem.fromJson(Map<String, dynamic> json) =>
      _$FavoriteItemFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteItemToJson(this);
}

@JsonSerializable()
class ProductFavorite {
  final int id;

  @JsonKey(name: 'name_en')
  final String nameEn;

  @JsonKey(name: 'name_ar')
  final String nameAr;

  final String? descriptionEn;
  final String? descriptionAr;
  final String price;

  @JsonKey(name: 'main_image')
  final String mainImage;

  const ProductFavorite({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    this.descriptionEn,
    this.descriptionAr,
    required this.price,
    required this.mainImage,
  });

  factory ProductFavorite.fromJson(Map<String, dynamic> json) =>
      _$ProductFavoriteFromJson(json);

  Map<String, dynamic> toJson() => _$ProductFavoriteToJson(this);
}