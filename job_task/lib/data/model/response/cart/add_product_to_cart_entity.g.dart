// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_product_to_cart_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddProductToCartEntity _$AddProductToCartEntityFromJson(
  Map<String, dynamic> json,
) => AddProductToCartEntity(
  json['status'] as String,
  json['message'] as String,
  (json['data'] as List<dynamic>)
      .map(
        (e) => AddProductToCartDataEntity.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$AddProductToCartEntityToJson(
  AddProductToCartEntity instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

AddProductToCartDataEntity _$AddProductToCartDataEntityFromJson(
  Map<String, dynamic> json,
) => AddProductToCartDataEntity(
  (json['id'] as num).toInt(),
  (json['user_id'] as num).toInt(),
  (json['product_id'] as num).toInt(),
  json['color'] as String,
  (json['size_id'] as num).toInt(),
  (json['quantity'] as num).toInt(),
  json['created_at'] as String,
  json['updated_at'] as String,
  AddProductToCartDataProductEntity.fromJson(
    json['product'] as Map<String, dynamic>,
  ),
  AddProductToCartDataSizeEntity.fromJson(json['size'] as Map<String, dynamic>),
  json['cart_additional'] as List<dynamic>,
);

Map<String, dynamic> _$AddProductToCartDataEntityToJson(
  AddProductToCartDataEntity instance,
) => <String, dynamic>{
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

AddProductToCartDataProductEntity _$AddProductToCartDataProductEntityFromJson(
  Map<String, dynamic> json,
) => AddProductToCartDataProductEntity(
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

Map<String, dynamic> _$AddProductToCartDataProductEntityToJson(
  AddProductToCartDataProductEntity instance,
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

AddProductToCartDataSizeEntity _$AddProductToCartDataSizeEntityFromJson(
  Map<String, dynamic> json,
) => AddProductToCartDataSizeEntity(
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

Map<String, dynamic> _$AddProductToCartDataSizeEntityToJson(
  AddProductToCartDataSizeEntity instance,
) => <String, dynamic>{
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
