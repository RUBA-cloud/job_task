class AddProductToCartRequest {
  final int productId;
  final int quantity;
  final String name;
  final String image;
  final String price;
  final int value;

  const AddProductToCartRequest({
    required this.productId,
    this.quantity = 1,
    required this.name,
    required this.image,
    required this.price,
    required this.value,
  });

  /// Row map for inserting into the Carts table.
  Map<String, Object?> toMap() => {
    'product_id': productId,
    'quantity': quantity,
    'name': name,
    'image': image,
    'price': price,
    'value': value,
  };

  factory AddProductToCartRequest.fromMap(Map<String, Object?> map) =>
      AddProductToCartRequest(
        productId: map['product_id'] as int,
        quantity: map['quantity'] as int,
        name: map['name'] as String,
        image: map['image'] as String,
        price: map['price'] as String,
        value: map['value'] as int,
      );
}