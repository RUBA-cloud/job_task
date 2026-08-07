import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_entity.g.dart';

@JsonSerializable()
class ForgotPasswordEntity {
  final String message;
  final String status;

  ForgotPasswordEntity(this.message, this.status);

  factory ForgotPasswordEntity.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordEntityToJson(this);
}
