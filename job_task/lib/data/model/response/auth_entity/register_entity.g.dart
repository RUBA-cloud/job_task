// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterEntity _$RegisterEntityFromJson(Map<String, dynamic> json) =>
    RegisterEntity(
      json['message'] as String,
      RegisterUserEntity.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterEntityToJson(RegisterEntity instance) =>
    <String, dynamic>{'message': instance.message, 'user': instance.user};

RegisterUserEntity _$RegisterUserEntityFromJson(Map<String, dynamic> json) =>
    RegisterUserEntity(
      json['name'] as String,
      json['email'] as String,
      json['updated_at'] as String,
      json['created_at'] as String,
      (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$RegisterUserEntityToJson(RegisterUserEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
      'id': instance.id,
    };
