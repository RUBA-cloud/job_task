import 'package:json_annotation/json_annotation.dart';

part 'login_entity.g.dart';

@JsonSerializable()
class LoginEntity {
  final LoginDataEntity data;
  final String country;
  final String city;
  @JsonKey(name: 'token_type')
  final String tokenType;
  @JsonKey(name: 'expires_in')
  final int expiresIn;

  LoginEntity(
    this.data,
    this.country,
    this.city,
    this.tokenType,
    this.expiresIn,
  );

  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LoginEntityToJson(this);
}

@JsonSerializable()
class LoginDataEntity {
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
  @JsonKey(name: 'access_token')
  final String accessToken;
  final LoginDataCountryEntity country;
  final LoginDataCityEntity city;

  LoginDataEntity(
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
    this.accessToken,
    this.country,
    this.city,
  );

  factory LoginDataEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataEntityToJson(this);
}

@JsonSerializable()
class LoginDataCountryEntity {
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

  LoginDataCountryEntity(
    this.id,
    this.nameEn,
    this.nameAr,
    this.isActive,
    this.userId,
    this.createdAt,
    this.updatedAt,
  );

  factory LoginDataCountryEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginDataCountryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataCountryEntityToJson(this);
}

@JsonSerializable()
class LoginDataCityEntity {
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

  LoginDataCityEntity(
    this.id,
    this.nameEn,
    this.nameAr,
    this.isActive,
    this.countryId,
    this.userId,
    this.createdAt,
    this.updatedAt,
  );

  factory LoginDataCityEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginDataCityEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataCityEntityToJson(this);
}
