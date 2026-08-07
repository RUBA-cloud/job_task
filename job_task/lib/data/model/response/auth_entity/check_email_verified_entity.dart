import 'package:json_annotation/json_annotation.dart';

part 'check_email_verified_entity.g.dart';

@JsonSerializable()
class CheckEmailVerifiedEntity {
  @JsonKey(name: 'email_verified')
  final bool emailVerified;
  final String message;

  CheckEmailVerifiedEntity(this.emailVerified, this.message);

  factory CheckEmailVerifiedEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckEmailVerifiedEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckEmailVerifiedEntityToJson(this);
}
