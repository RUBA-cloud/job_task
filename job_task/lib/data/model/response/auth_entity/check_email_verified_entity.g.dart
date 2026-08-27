// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_email_verified_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckEmailVerifiedEntity _$CheckEmailVerifiedEntityFromJson(
  Map<String, dynamic> json,
) => CheckEmailVerifiedEntity(
  json['email_verified'] as bool,
  json['message'] as String,
);

Map<String, dynamic> _$CheckEmailVerifiedEntityToJson(
  CheckEmailVerifiedEntity instance,
) => <String, dynamic>{
  'email_verified': instance.emailVerified,
  'message': instance.message,
};
