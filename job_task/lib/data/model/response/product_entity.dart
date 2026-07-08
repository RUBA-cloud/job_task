import 'package:json_annotation/json_annotation.dart';

part 'product_entity.g.dart';

@JsonSerializable()
class ProductEntity {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final ProductRatingEntity rating;

  ProductEntity(
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  );

  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductEntityToJson(this);
}

@JsonSerializable()
class ProductRatingEntity {
  final double rate;
  final int count;

  ProductRatingEntity(this.rate, this.count);

  factory ProductRatingEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductRatingEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductRatingEntityToJson(this);
}
