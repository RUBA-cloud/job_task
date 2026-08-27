// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileEntity _$UpdateProfileEntityFromJson(Map<String, dynamic> json) =>
    UpdateProfileEntity(
      json['message'] as String,
      UpdateProfileUserEntity.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateProfileEntityToJson(
  UpdateProfileEntity instance,
) => <String, dynamic>{'message': instance.message, 'user': instance.user};

UpdateProfileUserEntity _$UpdateProfileUserEntityFromJson(
  Map<String, dynamic> json,
) => UpdateProfileUserEntity(
  (json['id'] as num).toInt(),
  json['name'] as String,
  json['email'] as String,
  json['role'] as String,
  json['avatar_path'],
  json['email_verified_at'] as String,
  json['created_at'] as String,
  json['updated_at'] as String,
  json['language'] as String,
  json['theme'] as String,
  json['device_token'] as String,
  json['phone'],
  json['notification_on'] as bool,
  json['address'],
  json['street'],
  (json['country_id'] as num).toInt(),
  (json['city_id'] as num).toInt(),
  json['payment_id'],
  UpdateProfileUserCountryEntity.fromJson(
    json['country'] as Map<String, dynamic>,
  ),
  UpdateProfileUserCityEntity.fromJson(json['city'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UpdateProfileUserEntityToJson(
  UpdateProfileUserEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'role': instance.role,
  'avatar_path': instance.avatarPath,
  'email_verified_at': instance.emailVerifiedAt,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'language': instance.language,
  'theme': instance.theme,
  'device_token': instance.deviceToken,
  'phone': instance.phone,
  'notification_on': instance.notificationOn,
  'address': instance.address,
  'street': instance.street,
  'country_id': instance.countryId,
  'city_id': instance.cityId,
  'payment_id': instance.paymentId,
  'country': instance.country,
  'city': instance.city,
};

UpdateProfileUserCountryEntity _$UpdateProfileUserCountryEntityFromJson(
  Map<String, dynamic> json,
) => UpdateProfileUserCountryEntity(
  (json['id'] as num).toInt(),
  json['name_en'] as String,
  json['name_ar'] as String,
  (json['is_active'] as num).toInt(),
  json['user_id'],
  json['created_at'] as String,
  json['updated_at'] as String,
);

Map<String, dynamic> _$UpdateProfileUserCountryEntityToJson(
  UpdateProfileUserCountryEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'name_en': instance.nameEn,
  'name_ar': instance.nameAr,
  'is_active': instance.isActive,
  'user_id': instance.userId,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

UpdateProfileUserCityEntity _$UpdateProfileUserCityEntityFromJson(
  Map<String, dynamic> json,
) => UpdateProfileUserCityEntity(
  (json['id'] as num).toInt(),
  json['name_en'] as String,
  json['name_ar'] as String,
  (json['is_active'] as num).toInt(),
  (json['country_id'] as num).toInt(),
  json['user_id'],
  json['created_at'] as String,
  json['updated_at'] as String,
);

Map<String, dynamic> _$UpdateProfileUserCityEntityToJson(
  UpdateProfileUserCityEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'name_en': instance.nameEn,
  'name_ar': instance.nameAr,
  'is_active': instance.isActive,
  'country_id': instance.countryId,
  'user_id': instance.userId,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
