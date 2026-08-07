import 'package:json_annotation/json_annotation.dart';

part 'about_us_entity.g.dart';

@JsonSerializable()
class AboutUsEntity {
  final String status;
  final String message;
  final AboutUsCompanyEntity company;

  AboutUsEntity(this.status, this.message, this.company);

  factory AboutUsEntity.fromJson(Map<String, dynamic> json) => _$AboutUsEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AboutUsEntityToJson(this);
}

@JsonSerializable()
class AboutUsCompanyEntity {
  final int id;
  final dynamic image;
  @JsonKey(name: 'name_en')
  final String nameEn;
  @JsonKey(name: 'name_ar')
  final String nameAr;
  @JsonKey(name: 'about_us_en')
  final String aboutUsEn;
  @JsonKey(name: 'about_us_ar')
  final String aboutUsAr;
  @JsonKey(name: 'mission_en')
  final String missionEn;
  @JsonKey(name: 'mission_ar')
  final String missionAr;
  @JsonKey(name: 'vision_en')
  final String visionEn;
  @JsonKey(name: 'vision_ar')
  final String visionAr;
  final dynamic phone;
  final dynamic email;
  @JsonKey(name: 'address_en')
  final String addressEn;
  @JsonKey(name: 'address_ar')
  final String addressAr;
  final dynamic location;
  final dynamic facebook;
  final dynamic instagram;
  final dynamic twitter;
  @JsonKey(name: 'main_color')
  final String mainColor;
  @JsonKey(name: 'sub_color')
  final String subColor;
  @JsonKey(name: 'text_color')
  final String textColor;
  @JsonKey(name: 'button_color')
  final String buttonColor;
  @JsonKey(name: 'icon_color')
  final String iconColor;
  @JsonKey(name: 'text_filed_color')
  final String textFiledColor;
  @JsonKey(name: 'hint_color')
  final String hintColor;
  @JsonKey(name: 'button_text_color')
  final String buttonTextColor;
  @JsonKey(name: 'card_color')
  final String cardColor;
  @JsonKey(name: 'label_color')
  final String labelColor;
  @JsonKey(name: 'main_color_dark')
  final String mainColorDark;
  @JsonKey(name: 'sub_color_dark')
  final String subColorDark;
  @JsonKey(name: 'text_color_dark')
  final String textColorDark;
  @JsonKey(name: 'button_color_dark')
  final String buttonColorDark;
  @JsonKey(name: 'icon_color_dark')
  final String iconColorDark;
  @JsonKey(name: 'text_filed_color_dark')
  final String textFiledColorDark;
  @JsonKey(name: 'hint_color_dark')
  final String hintColorDark;
  @JsonKey(name: 'button_text_color_dark')
  final String buttonTextColorDark;
  final bool dark;
  @JsonKey(name: 'country_id')
  final dynamic countryId;
  @JsonKey(name: 'city_id')
  final dynamic cityId;
  @JsonKey(name: 'is_active')
  final int isActive;
  @JsonKey(name: 'user_id')
  final dynamic userId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  AboutUsCompanyEntity(
    this.id,
    this.image,
    this.nameEn,
    this.nameAr,
    this.aboutUsEn,
    this.aboutUsAr,
    this.missionEn,
    this.missionAr,
    this.visionEn,
    this.visionAr,
    this.phone,
    this.email,
    this.addressEn,
    this.addressAr,
    this.location,
    this.facebook,
    this.instagram,
    this.twitter,
    this.mainColor,
    this.subColor,
    this.textColor,
    this.buttonColor,
    this.iconColor,
    this.textFiledColor,
    this.hintColor,
    this.buttonTextColor,
    this.cardColor,
    this.labelColor,
    this.mainColorDark,
    this.subColorDark,
    this.textColorDark,
    this.buttonColorDark,
    this.iconColorDark,
    this.textFiledColorDark,
    this.hintColorDark,
    this.buttonTextColorDark,
    this.dark,
    this.countryId,
    this.cityId,
    this.isActive,
    this.userId,
    this.createdAt,
    this.updatedAt,
  );

  factory AboutUsCompanyEntity.fromJson(Map<String, dynamic> json) =>
      _$AboutUsCompanyEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AboutUsCompanyEntityToJson(this);
}
