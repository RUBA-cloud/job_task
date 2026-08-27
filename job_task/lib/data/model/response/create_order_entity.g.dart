// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderEntity _$CreateOrderEntityFromJson(Map<String, dynamic> json) =>
    CreateOrderEntity(
      json['status'] as String,
      json['message'] as String,
      CreateOrderDataEntity.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateOrderEntityToJson(CreateOrderEntity instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

CreateOrderDataEntity _$CreateOrderDataEntityFromJson(
  Map<String, dynamic> json,
) => CreateOrderDataEntity(
  (json['user_id'] as num).toInt(),
  (json['status'] as num).toInt(),
  (json['order_status_id'] as num).toInt(),
  json['address'] as String,
  json['street_name'] as String,
  json['building_number'] as String,
  (json['lat'] as num).toInt(),
  (json['long'] as num).toInt(),
  json['updated_at'] as String,
  json['created_at'] as String,
  (json['id'] as num).toInt(),
  json['created_at_human'] as String,
  json['updated_at_human'] as String,
);

Map<String, dynamic> _$CreateOrderDataEntityToJson(
  CreateOrderDataEntity instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'status': instance.status,
  'order_status_id': instance.orderStatusId,
  'address': instance.address,
  'street_name': instance.streetName,
  'building_number': instance.buildingNumber,
  'lat': instance.lat,
  'long': instance.long,
  'updated_at': instance.updatedAt,
  'created_at': instance.createdAt,
  'id': instance.id,
  'created_at_human': instance.createdAtHuman,
  'updated_at_human': instance.updatedAtHuman,
};
