import 'package:json_annotation/json_annotation.dart';

part 'verify_email_entity.g.dart';

@JsonSerializable()
class VerifyEmailEntity {
  final String message;

  VerifyEmailEntity(this.message);

  factory VerifyEmailEntity.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyEmailEntityToJson(this);
}
