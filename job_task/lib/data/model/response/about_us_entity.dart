import 'package:json_annotation/json_annotation.dart';

part 'about_us_entity.g.dart';

/// Converts API values such as:
/// 1
/// "1"
/// null
/// into int?
int? _toNullableInt(dynamic value) {
  if (value == null) {
    return null;
  }

  if (value is int) {
    return value;
  }

  if (value is String) {
    return int.tryParse(value);
  }

  return null;
}

/// Converts API values to String?
String? _toNullableString(dynamic value) {
  if (value == null) {
    return null;
  }

  return value.toString();
}

/// Converts API values to String.
/// If the API returns null, returns an empty string.
String _toString(dynamic value) {
  if (value == null) {
    return '';
  }

  return value.toString();
}

/// Converts API values to int.
/// Supports both:
/// 1
/// "1"
/// null
int _toInt(dynamic value) {
  if (value is int) {
    return value;
  }

  if (value is String) {
    return int.tryParse(value) ?? 0;
  }

  return 0;
}

/// Converts API values to bool.
/// Supports:
/// true / false
/// 1 / 0
/// "1" / "0"
/// "true" / "false"
bool _toBool(dynamic value) {
  if (value is bool) {
    return value;
  }

  if (value is int) {
    return value == 1;
  }

  if (value is String) {
    return value == '1' ||
        value.toLowerCase() == 'true';
  }

  return false;
}


// ======================================================================
// ABOUT US RESPONSE
// ======================================================================

@JsonSerializable(explicitToJson: true)
class AboutUsEntity {
  final String status;

  final String message;

  final AboutUsCompanyEntity company;

  const AboutUsEntity({
    required this.status,
    required this.message,
    required this.company,
  });

  factory AboutUsEntity.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$AboutUsEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AboutUsEntityToJson(this);
}


// ======================================================================
// COMPANY
// ======================================================================

@JsonSerializable(explicitToJson: true)
class AboutUsCompanyEntity {
  // ====================================================================
  // BASIC INFORMATION
  // ====================================================================

  final int id;

  @JsonKey(fromJson: _toNullableString)
  final String? image;

  @JsonKey(
    name: 'name_en',
    fromJson: _toString,
  )
  final String nameEn;

  @JsonKey(
    name: 'name_ar',
    fromJson: _toString,
  )
  final String nameAr;

  @JsonKey(
    name: 'about_us_en',
    fromJson: _toString,
  )
  final String aboutUsEn;

  @JsonKey(
    name: 'about_us_ar',
    fromJson: _toString,
  )
  final String aboutUsAr;


  // ====================================================================
  // MISSION
  // ====================================================================

  @JsonKey(
    name: 'mission_en',
    fromJson: _toString,
  )
  final String missionEn;

  @JsonKey(
    name: 'mission_ar',
    fromJson: _toString,
  )
  final String missionAr;


  // ====================================================================
  // VISION
  // ====================================================================

  @JsonKey(
    name: 'vision_en',
    fromJson: _toString,
  )
  final String visionEn;

  @JsonKey(
    name: 'vision_ar',
    fromJson: _toString,
  )
  final String visionAr;


  // ====================================================================
  // CONTACT
  // ====================================================================

  @JsonKey(fromJson: _toNullableString)
  final String? phone;

  @JsonKey(fromJson: _toNullableString)
  final String? email;

  @JsonKey(
    name: 'address_en',
    fromJson: _toString,
  )
  final String addressEn;

  @JsonKey(
    name: 'address_ar',
    fromJson: _toString,
  )
  final String addressAr;

  @JsonKey(fromJson: _toNullableString)
  final String? location;


  // ====================================================================
  // SOCIAL MEDIA
  // ====================================================================

  @JsonKey(fromJson: _toNullableString)
  final String? facebook;

  @JsonKey(fromJson: _toNullableString)
  final String? instagram;

  @JsonKey(fromJson: _toNullableString)
  final String? twitter;


  // ====================================================================
  // LIGHT COLORS
  // ====================================================================

  @JsonKey(
    name: 'main_color',
    fromJson: _toString,
  )
  final String mainColor;

  @JsonKey(
    name: 'sub_color',
    fromJson: _toString,
  )
  final String subColor;

  @JsonKey(
    name: 'text_color',
    fromJson: _toString,
  )
  final String textColor;

  @JsonKey(
    name: 'button_color',
    fromJson: _toString,
  )
  final String buttonColor;

  @JsonKey(
    name: 'icon_color',
    fromJson: _toString,
  )
  final String iconColor;

  @JsonKey(
    name: 'text_filed_color',
    fromJson: _toString,
  )
  final String textFiledColor;

  @JsonKey(
    name: 'hint_color',
    fromJson: _toString,
  )
  final String hintColor;

  @JsonKey(
    name: 'button_text_color',
    fromJson: _toString,
  )
  final String buttonTextColor;

  @JsonKey(
    name: 'card_color',
    fromJson: _toString,
  )
  final String cardColor;

  @JsonKey(
    name: 'label_color',
    fromJson: _toString,
  )
  final String labelColor;


  // ====================================================================
  // DARK COLORS
  // ====================================================================

  @JsonKey(
    name: 'main_color_dark',
    fromJson: _toString,
  )
  final String mainColorDark;

  @JsonKey(
    name: 'sub_color_dark',
    fromJson: _toString,
  )
  final String subColorDark;

  @JsonKey(
    name: 'text_color_dark',
    fromJson: _toString,
  )
  final String textColorDark;

  @JsonKey(
    name: 'button_color_dark',
    fromJson: _toString,
  )
  final String buttonColorDark;

  @JsonKey(
    name: 'icon_color_dark',
    fromJson: _toString,
  )
  final String iconColorDark;

  @JsonKey(
    name: 'text_filed_color_dark',
    fromJson: _toString,
  )
  final String textFiledColorDark;

  @JsonKey(
    name: 'hint_color_dark',
    fromJson: _toString,
  )
  final String hintColorDark;

  @JsonKey(
    name: 'button_text_color_dark',
    fromJson: _toString,
  )
  final String buttonTextColorDark;


  // ====================================================================
  // SETTINGS
  // ====================================================================

  @JsonKey(fromJson: _toBool)
  final bool dark;


  // ====================================================================
  // LOCATION
  // ====================================================================

  @JsonKey(
    name: 'country_id',
    fromJson: _toNullableInt,
  )
  final int? countryId;

  @JsonKey(
    name: 'city_id',
    fromJson: _toNullableInt,
  )
  final int? cityId;


  // ====================================================================
  // STATUS
  // ====================================================================

  @JsonKey(
    name: 'is_active',
    fromJson: _toInt,
  )
  final int isActive;

  @JsonKey(
    name: 'user_id',
    fromJson: _toNullableInt,
  )
  final int? userId;


  // ====================================================================
  // DATES
  // ====================================================================

  @JsonKey(fromJson: _toString)
  final String createdAt;

  @JsonKey(fromJson: _toString)
  final String updatedAt;


  // ====================================================================
  // CONSTRUCTOR
  // ====================================================================

  const AboutUsCompanyEntity({
    required this.id,
    this.image,

    required this.nameEn,
    required this.nameAr,

    required this.aboutUsEn,
    required this.aboutUsAr,

    required this.missionEn,
    required this.missionAr,

    required this.visionEn,
    required this.visionAr,

    this.phone,
    this.email,

    required this.addressEn,
    required this.addressAr,

    this.location,

    this.facebook,
    this.instagram,
    this.twitter,

    required this.mainColor,
    required this.subColor,
    required this.textColor,
    required this.buttonColor,
    required this.iconColor,
    required this.textFiledColor,
    required this.hintColor,
    required this.buttonTextColor,
    required this.cardColor,
    required this.labelColor,

    required this.mainColorDark,
    required this.subColorDark,
    required this.textColorDark,
    required this.buttonColorDark,
    required this.iconColorDark,
    required this.textFiledColorDark,
    required this.hintColorDark,
    required this.buttonTextColorDark,

    required this.dark,

    this.countryId,
    this.cityId,

    required this.isActive,

    this.userId,

    required this.createdAt,
    required this.updatedAt,
  });


  // ====================================================================
  // JSON
  // ====================================================================

  factory AboutUsCompanyEntity.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$AboutUsCompanyEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AboutUsCompanyEntityToJson(this);
}