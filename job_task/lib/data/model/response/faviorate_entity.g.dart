// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faviorate_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaviorateEntity _$FaviorateEntityFromJson(Map<String, dynamic> json) =>
    FaviorateEntity(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>)
          .map((e) => FavoriteItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FaviorateEntityToJson(FaviorateEntity instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};

FavoriteItem _$FavoriteItemFromJson(Map<String, dynamic> json) => FavoriteItem(
  id: (json['id'] as num).toInt(),
  productId: (json['product_id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  isActive: (json['is_active'] as num).toInt(),
  product: ProductFavorite.fromJson(json['product'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FavoriteItemToJson(FavoriteItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'user_id': instance.userId,
      'is_active': instance.isActive,
      'product': instance.product,
    };

ProductFavorite _$ProductFavoriteFromJson(Map<String, dynamic> json) =>
    ProductFavorite(
      id: (json['id'] as num).toInt(),
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
      descriptionEn: json['descriptionEn'] as String?,
      descriptionAr: json['descriptionAr'] as String?,
      price: json['price'] as String,
      mainImage: json['main_image'] as String,
    );

Map<String, dynamic> _$ProductFavoriteToJson(ProductFavorite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
      'descriptionEn': instance.descriptionEn,
      'descriptionAr': instance.descriptionAr,
      'price': instance.price,
      'main_image': instance.mainImage,
    };
