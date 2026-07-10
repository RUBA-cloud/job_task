class AddToFavRequest {
  final int productId;
  final String name;
  final String image;
  final String price;
  final int value;

  const AddToFavRequest({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.value,
  });

  /// Row map for inserting into the Favorites table.
  Map<String, Object?> toMap() => {
    'product_id': productId,
    'is_fav': 1,
    'name': name,
    'image': image,
    'price': price,
    'value': value,
  };

  factory AddToFavRequest.fromMap(Map<String, Object?> map) => AddToFavRequest(
    productId: map['product_id'] as int,
    name: map['name'] as String,
    image: map['image'] as String,
    price: map['price'] as String,
    value: map['value'] as int,
  );
}