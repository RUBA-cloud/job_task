// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartEntity _$CartEntityFromJson(Map<String, dynamic> json) => CartEntity(
  json['status'] as String,
  json['message'] as String,
  (json['data'] as List<dynamic>)
      .map((e) => CartDataEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CartEntityToJson(CartEntity instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

CartDataEntity _$CartDataEntityFromJson(Map<String, dynamic> json) =>
    CartDataEntity(
      (json['id'] as num).toInt(),
      (json['user_id'] as num).toInt(),
      (json['product_id'] as num).toInt(),
      json['color'] as String,
      (json['size_id'] as num).toInt(),
      (json['quantity'] as num).toInt(),
      json['created_at'] as String,
      json['updated_at'] as String,
      CartDataProductEntity.fromJson(json['product'] as Map<String, dynamic>),
      CartDataSizeEntity.fromJson(json['size'] as Map<String, dynamic>),
      json['cart_additional'] as List<dynamic>,
    );

Map<String, dynamic> _$CartDataEntityToJson(CartDataEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'product_id': instance.productId,
      'color': instance.color,
      'size_id': instance.sizeId,
      'quantity': instance.quantity,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'product': instance.product,
      'size': instance.size,
      'cart_additional': instance.cartAdditional,
    };

CartDataProductEntity _$CartDataProductEntityFromJson(
  Map<String, dynamic> json,
) => CartDataProductEntity(
  (json['id'] as num).toInt(),
  json['name_en'] as String,
  json['name_ar'] as String,
  json['description_en'] as String,
  json['description_ar'] as String,
  json['price'] as String,
  json['is_active'] as bool,
  (json['user_id'] as num).toInt(),
  (json['category_id'] as num).toInt(),
  json['created_at'] as String,
  json['updated_at'] as String,
  json['deleted_at'],
  (json['type_id'] as num).toInt(),
  (json['colors'] as List<dynamic>).map((e) => e as String).toList(),
  json['main_image'] as String,
  (json['size_id'] as num).toInt(),
);

Map<String, dynamic> _$CartDataProductEntityToJson(
  CartDataProductEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'name_en': instance.nameEn,
  'name_ar': instance.nameAr,
  'description_en': instance.descriptionEn,
  'description_ar': instance.descriptionAr,
  'price': instance.price,
  'is_active': instance.isActive,
  'user_id': instance.userId,
  'category_id': instance.categoryId,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'deleted_at': instance.deletedAt,
  'type_id': instance.typeId,
  'colors': instance.colors,
  'main_image': instance.mainImage,
  'size_id': instance.sizeId,
};

CartDataSizeEntity _$CartDataSizeEntityFromJson(Map<String, dynamic> json) =>
    CartDataSizeEntity(
      (json['id'] as num).toInt(),
      json['name_en'] as String,
      json['name_ar'] as String,
      json['is_active'] as bool,
      (json['user_id'] as num).toInt(),
      json['created_at'] as String,
      json['updated_at'] as String,
      json['image'],
      json['descripation'] as String,
      (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$CartDataSizeEntityToJson(CartDataSizeEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
      'is_active': instance.isActive,
      'user_id': instance.userId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'image': instance.image,
      'descripation': instance.descripation,
      'price': instance.price,
    };
