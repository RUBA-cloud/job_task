import 'package:json_annotation/json_annotation.dart';

part 'favorite_entity.g.dart';

/// The DB stores price as TEXT — accept both String and num when reading.
double _priceFromDb(Object? v) =>
    v is num ? v.toDouble() : double.tryParse(v?.toString() ?? '') ?? 0.0;

/// Write it back as TEXT to match the column type.
String _priceToDb(double v) => v.toString();

@JsonSerializable()
class FavoriteEntity {
  final int id;
  @JsonKey(name: 'product_id')
  final int productId;
  @JsonKey(name: 'is_fav')
  final int isFav;
  final String name;
  final String image;
  @JsonKey(fromJson: _priceFromDb, toJson: _priceToDb)
  final double price;
  final int value;
  @JsonKey(name: 'created_date')
  final String createdDate;
  @JsonKey(name: 'updated_date')
  final String updatedDate;

  FavoriteEntity(
      this.id,
      this.productId,
      this.isFav,
      this.name,
      this.image,
      this.price,
      this.value,
      this.createdDate,
      this.updatedDate,
      );

  factory FavoriteEntity.fromJson(Map<String, dynamic> json) =>
      _$FavoriteEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteEntityToJson(this);
}