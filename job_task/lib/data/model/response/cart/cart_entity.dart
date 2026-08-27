import 'package:json_annotation/json_annotation.dart';

part 'cart_entity.g.dart';

@JsonSerializable()
class CartEntity {
  String status;
  String message;
  List<CartDataEntity> data;

  CartEntity(this.status, this.message, this.data);

  factory CartEntity.fromJson(Map<String, dynamic> json) =>
      _$CartEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CartEntityToJson(this);
}

@JsonSerializable()
class CartDataEntity {
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
  CartDataProductEntity product;
  CartDataSizeEntity size;
  @JsonKey(name: 'cart_additional')
  List<dynamic> cartAdditional;

  CartDataEntity(
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

  factory CartDataEntity.fromJson(Map<String, dynamic> json) =>
      _$CartDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CartDataEntityToJson(this);
}

@JsonSerializable()
class CartDataProductEntity {
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

  CartDataProductEntity(
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

  factory CartDataProductEntity.fromJson(Map<String, dynamic> json) =>
      _$CartDataProductEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CartDataProductEntityToJson(this);
}

@JsonSerializable()
class CartDataSizeEntity {
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

  CartDataSizeEntity(
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

  factory CartDataSizeEntity.fromJson(Map<String, dynamic> json) =>
      _$CartDataSizeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CartDataSizeEntityToJson(this);
}
