import 'package:json_annotation/json_annotation.dart';

part 'register_entity.g.dart';

@JsonSerializable()
class RegisterEntity {
  final String message;
  final RegisterUserEntity user;

  RegisterEntity(this.message, this.user);

  factory RegisterEntity.fromJson(Map<String, dynamic> json) =>
      _$RegisterEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterEntityToJson(this);
}

@JsonSerializable()
class RegisterUserEntity {
  final String name;
  final String email;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'created_at')
  final String createdAt;
  final int id;

  RegisterUserEntity(
    this.name,
    this.email,
    this.updatedAt,
    this.createdAt,
    this.id,
  );

  factory RegisterUserEntity.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterUserEntityToJson(this);
}
