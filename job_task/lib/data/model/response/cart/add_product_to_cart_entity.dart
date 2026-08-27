import 'package:json_annotation/json_annotation.dart';

part 'add_product_to_cart_entity.g.dart';

@JsonSerializable()
class AddProductToCartEntity {
  String status;
  String message;
  List<AddProductToCartDataEntity> data;

  AddProductToCartEntity(this.status, this.message, this.data);

  factory AddProductToCartEntity.fromJson(Map<String, dynamic> json) =>
      _$AddProductToCartEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddProductToCartEntityToJson(this);
}

@JsonSerializable()
class AddProductToCartDataEntity {
  int id;
  @JsonKey(name: 'user_id')
  int userId;
  @JsonKey(name: 'product_id')
  int productId;
  String color;
  @JsonKey(name: 'size_id')
  int sizeId;
  int quantity;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  AddProductToCartDataProductEntity product;
  AddProductToCartDataSizeEntity size;
  @JsonKey(name: 'cart_additional')
  List<dynamic> cartAdditional;

  AddProductToCartDataEntity(
    this.id,
    this.userId,
    this.productId,
    this.color,
    this.sizeId,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.size,
    this.cartAdditional,
  );

  factory AddProductToCartDataEntity.fromJson(Map<String, dynamic> json) =>
      _$AddProductToCartDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddProductToCartDataEntityToJson(this);
}

@JsonSerializable()
class AddProductToCartDataProductEntity {
  int id;
  @JsonKey(name: 'name_en')
  String nameEn;
  @JsonKey(name: 'name_ar')
  String nameAr;
  @JsonKey(name: 'description_en')
  String descriptionEn;
  @JsonKey(name: 'description_ar')
  String descriptionAr;
  String price;
  @JsonKey(name: 'is_active')
  bool isActive;
  @JsonKey(name: 'user_id')
  int userId;
  @JsonKey(name: 'category_id')
  int categoryId;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  @JsonKey(name: 'deleted_at')
  dynamic deletedAt;
  @JsonKey(name: 'type_id')
  int typeId;
  List<String> colors;
  @JsonKey(name: 'main_image')
  String mainImage;
  @JsonKey(name: 'size_id')
  int sizeId;

  AddProductToCartDataProductEntity(
    this.id,
    this.nameEn,
    this.nameAr,
    this.descriptionEn,
    this.descriptionAr,
    this.price,
    this.isActive,
    this.userId,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.typeId,
    this.colors,
    this.mainImage,
    this.sizeId,
  );

  factory AddProductToCartDataProductEntity.fromJson(
    Map<String, dynamic> json,
  ) => _$AddProductToCartDataProductEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AddProductToCartDataProductEntityToJson(this);
}

@JsonSerializable()
class AddProductToCartDataSizeEntity {
  int id;
  @JsonKey(name: 'name_en')
  String nameEn;
  @JsonKey(name: 'name_ar')
  String nameAr;
  @JsonKey(name: 'is_active')
  bool isActive;
  @JsonKey(name: 'user_id')
  int userId;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  dynamic image;
  String descripation;
  int price;

  AddProductToCartDataSizeEntity(
    this.id,
    this.nameEn,
    this.nameAr,
    this.isActive,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.descripation,
    this.price,
  );

  factory AddProductToCartDataSizeEntity.fromJson(Map<String, dynamic> json) =>
      _$AddProductToCartDataSizeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddProductToCartDataSizeEntityToJson(this);
}
