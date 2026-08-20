import 'package:json_annotation/json_annotation.dart';

part 'favorite_entity.g.dart';

@JsonSerializable()
class FavoriteEntity {
  final String message;
  final FavoriteDataEntity data;

  FavoriteEntity(this.message, this.data);

  factory FavoriteEntity.fromJson(Map<String, dynamic> json) =>
      _$FavoriteEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteEntityToJson(this);
}

@JsonSerializable()
class FavoriteDataEntity {
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'product_id')
  final int productId;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'created_at')
  final String createdAt;
  final int id;
  final FavoriteDataProductEntity product;

  FavoriteDataEntity(
    this.userId,
    this.productId,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.product,
  );

  factory FavoriteDataEntity.fromJson(Map<String, dynamic> json) =>
      _$FavoriteDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteDataEntityToJson(this);
}

@JsonSerializable()
class FavoriteDataProductEntity {
  final int id;
  @JsonKey(name: 'name_en')
  final String nameEn;
  @JsonKey(name: 'name_ar')
  final String nameAr;
  @JsonKey(name: 'description_en')
  final String descriptionEn;
  @JsonKey(name: 'description_ar')
  final String descriptionAr;
  final String price;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'main_image')
  final String mainImage;
  final List<String> colors;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'type_id')
  final int typeId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'deleted_at')
  final dynamic deletedAt;
  @JsonKey(name: 'size_id')
  final int sizeId;

  FavoriteDataProductEntity(
    this.id,
    this.nameEn,
    this.nameAr,
    this.descriptionEn,
    this.descriptionAr,
    this.price,
    this.isActive,
    this.mainImage,
    this.colors,
    this.userId,
    this.categoryId,
    this.typeId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.sizeId,
  );

  factory FavoriteDataProductEntity.fromJson(Map<String, dynamic> json) =>
      _$FavoriteDataProductEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteDataProductEntityToJson(this);
}
