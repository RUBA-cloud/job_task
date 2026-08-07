import 'package:json_annotation/json_annotation.dart';

part 'update_profile_entity.g.dart';

@JsonSerializable()
class UpdateProfileEntity {
  final String message;
  final UpdateProfileUserEntity user;

  UpdateProfileEntity(this.message, this.user);

  factory UpdateProfileEntity.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileEntityToJson(this);
}

@JsonSerializable()
class UpdateProfileUserEntity {
  final int id;
  final String name;
  final String email;
  final String role;
  @JsonKey(name: 'avatar_path')
  final dynamic avatarPath;
  @JsonKey(name: 'email_verified_at')
  final String emailVerifiedAt;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  final String language;
  final String theme;
  @JsonKey(name: 'device_token')
  final String deviceToken;
  final dynamic phone;
  @JsonKey(name: 'notification_on')
  final bool notificationOn;
  final dynamic address;
  final dynamic street;
  @JsonKey(name: 'country_id')
  final int countryId;
  @JsonKey(name: 'city_id')
  final int cityId;
  @JsonKey(name: 'payment_id')
  final dynamic paymentId;
  final UpdateProfileUserCountryEntity country;
  final UpdateProfileUserCityEntity city;

  UpdateProfileUserEntity(
    this.id,
    this.name,
    this.email,
    this.role,
    this.avatarPath,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.language,
    this.theme,
    this.deviceToken,
    this.phone,
    this.notificationOn,
    this.address,
    this.street,
    this.countryId,
    this.cityId,
    this.paymentId,
    this.country,
    this.city,
  );

  factory UpdateProfileUserEntity.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileUserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileUserEntityToJson(this);
}

@JsonSerializable()
class UpdateProfileUserCountryEntity {
  final int id;
  @JsonKey(name: 'name_en')
  final String nameEn;
  @JsonKey(name: 'name_ar')
  final String nameAr;
  @JsonKey(name: 'is_active')
  final int isActive;
  @JsonKey(name: 'user_id')
  final dynamic userId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  UpdateProfileUserCountryEntity(
    this.id,
    this.nameEn,
    this.nameAr,
    this.isActive,
    this.userId,
    this.createdAt,
    this.updatedAt,
  );

  factory UpdateProfileUserCountryEntity.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileUserCountryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileUserCountryEntityToJson(this);
}

@JsonSerializable()
class UpdateProfileUserCityEntity {
  final int id;
  @JsonKey(name: 'name_en')
  final String nameEn;
  @JsonKey(name: 'name_ar')
  final String nameAr;
  @JsonKey(name: 'is_active')
  final int isActive;
  @JsonKey(name: 'country_id')
  final int countryId;
  @JsonKey(name: 'user_id')
  final dynamic userId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  UpdateProfileUserCityEntity(
    this.id,
    this.nameEn,
    this.nameAr,
    this.isActive,
    this.countryId,
    this.userId,
    this.createdAt,
    this.updatedAt,
  );

  factory UpdateProfileUserCityEntity.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileUserCityEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileUserCityEntityToJson(this);
}
