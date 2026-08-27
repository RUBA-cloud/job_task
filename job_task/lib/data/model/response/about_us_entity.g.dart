// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_us_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutUsEntity _$AboutUsEntityFromJson(Map<String, dynamic> json) =>
    AboutUsEntity(
      status: json['status'] as String,
      message: json['message'] as String,
      company: AboutUsCompanyEntity.fromJson(
        json['company'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$AboutUsEntityToJson(AboutUsEntity instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'company': instance.company.toJson(),
    };

AboutUsCompanyEntity _$AboutUsCompanyEntityFromJson(
  Map<String, dynamic> json,
) => AboutUsCompanyEntity(
  id: (json['id'] as num).toInt(),
  image: _toNullableString(json['image']),
  nameEn: _toString(json['name_en']),
  nameAr: _toString(json['name_ar']),
  aboutUsEn: _toString(json['about_us_en']),
  aboutUsAr: _toString(json['about_us_ar']),
  missionEn: _toString(json['mission_en']),
  missionAr: _toString(json['mission_ar']),
  visionEn: _toString(json['vision_en']),
  visionAr: _toString(json['vision_ar']),
  phone: _toNullableString(json['phone']),
  email: _toNullableString(json['email']),
  addressEn: _toString(json['address_en']),
  addressAr: _toString(json['address_ar']),
  location: _toNullableString(json['location']),
  facebook: _toNullableString(json['facebook']),
  instagram: _toNullableString(json['instagram']),
  twitter: _toNullableString(json['twitter']),
  mainColor: _toString(json['main_color']),
  subColor: _toString(json['sub_color']),
  textColor: _toString(json['text_color']),
  buttonColor: _toString(json['button_color']),
  iconColor: _toString(json['icon_color']),
  textFiledColor: _toString(json['text_filed_color']),
  hintColor: _toString(json['hint_color']),
  buttonTextColor: _toString(json['button_text_color']),
  cardColor: _toString(json['card_color']),
  labelColor: _toString(json['label_color']),
  mainColorDark: _toString(json['main_color_dark']),
  subColorDark: _toString(json['sub_color_dark']),
  textColorDark: _toString(json['text_color_dark']),
  buttonColorDark: _toString(json['button_color_dark']),
  iconColorDark: _toString(json['icon_color_dark']),
  textFiledColorDark: _toString(json['text_filed_color_dark']),
  hintColorDark: _toString(json['hint_color_dark']),
  buttonTextColorDark: _toString(json['button_text_color_dark']),
  dark: _toBool(json['dark']),
  countryId: _toNullableInt(json['country_id']),
  cityId: _toNullableInt(json['city_id']),
  isActive: _toInt(json['is_active']),
  userId: _toNullableInt(json['user_id']),
  createdAt: _toString(json['createdAt']),
  updatedAt: _toString(json['updatedAt']),
);

Map<String, dynamic> _$AboutUsCompanyEntityToJson(
  AboutUsCompanyEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'image': instance.image,
  'name_en': instance.nameEn,
  'name_ar': instance.nameAr,
  'about_us_en': instance.aboutUsEn,
  'about_us_ar': instance.aboutUsAr,
  'mission_en': instance.missionEn,
  'mission_ar': instance.missionAr,
  'vision_en': instance.visionEn,
  'vision_ar': instance.visionAr,
  'phone': instance.phone,
  'email': instance.email,
  'address_en': instance.addressEn,
  'address_ar': instance.addressAr,
  'location': instance.location,
  'facebook': instance.facebook,
  'instagram': instance.instagram,
  'twitter': instance.twitter,
  'main_color': instance.mainColor,
  'sub_color': instance.subColor,
  'text_color': instance.textColor,
  'button_color': instance.buttonColor,
  'icon_color': instance.iconColor,
  'text_filed_color': instance.textFiledColor,
  'hint_color': instance.hintColor,
  'button_text_color': instance.buttonTextColor,
  'card_color': instance.cardColor,
  'label_color': instance.labelColor,
  'main_color_dark': instance.mainColorDark,
  'sub_color_dark': instance.subColorDark,
  'text_color_dark': instance.textColorDark,
  'button_color_dark': instance.buttonColorDark,
  'icon_color_dark': instance.iconColorDark,
  'text_filed_color_dark': instance.textFiledColorDark,
  'hint_color_dark': instance.hintColorDark,
  'button_text_color_dark': instance.buttonTextColorDark,
  'dark': instance.dark,
  'country_id': instance.countryId,
  'city_id': instance.cityId,
  'is_active': instance.isActive,
  'user_id': instance.userId,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
