import 'package:json_annotation/json_annotation.dart';

part 'remove_fav_entity.g.dart';

@JsonSerializable()
class RemoveFavEntity {
  String message;

  RemoveFavEntity(this.message);

  factory RemoveFavEntity.fromJson(Map<String, dynamic> json) =>
      _$RemoveFavEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveFavEntityToJson(this);
}
