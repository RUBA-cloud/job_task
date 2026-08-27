import 'package:json_annotation/json_annotation.dart';

part 'create_order_entity.g.dart';

@JsonSerializable()
class CreateOrderEntity {
  String status;
  String message;
  CreateOrderDataEntity data;

  CreateOrderEntity(this.status, this.message, this.data);

  factory CreateOrderEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderEntityToJson(this);
}

@JsonSerializable()
class CreateOrderDataEntity {
  @JsonKey(name: 'user_id')
  int userId;
  int status;
  @JsonKey(name: 'order_status_id')
  int orderStatusId;
  String address;
  @JsonKey(name: 'street_name')
  String streetName;
  @JsonKey(name: 'building_number')
  String buildingNumber;
  int lat;
  int long;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  @JsonKey(name: 'created_at')
  String createdAt;
  int id;
  @JsonKey(name: 'created_at_human')
  String createdAtHuman;
  @JsonKey(name: 'updated_at_human')
  String updatedAtHuman;

  CreateOrderDataEntity(
    this.userId,
    this.status,
    this.orderStatusId,
    this.address,
    this.streetName,
    this.buildingNumber,
    this.lat,
    this.long,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.createdAtHuman,
    this.updatedAtHuman,
  );

  factory CreateOrderDataEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderDataEntityToJson(this);
}
