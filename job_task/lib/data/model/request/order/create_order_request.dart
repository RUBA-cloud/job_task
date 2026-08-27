class CreateOrderRequest {
  final int cartId;
  final String address;
  final String streetName;
  final String buildingNumber;
  final double lat;
  final double long;
  final double totalPrice;
  final List<OrderProductRequest> products;

  const CreateOrderRequest({
    required this.cartId,
    required this.address,
    required this.streetName,
    required this.buildingNumber,
    required this.lat,
    required this.long,
    required this.totalPrice,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return {
      'cart_id': cartId,
      'address': address,
      'street_name': streetName,
      'building_number': buildingNumber,
      'lat': lat,
      'long': long,
      'total_price': totalPrice.toStringAsFixed(2),
      'products': products
          .map((product) => product.toJson())
          .toList(),
    };
  }
}

class OrderProductRequest {
  final int productId;
  final int? sizeId;
  final int quantity;
  final List<String> colors;

  const OrderProductRequest({
    required this.productId,
    this.sizeId,
    required this.quantity,
    this.colors = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      if (sizeId != null) 'size_id': sizeId,
      'quantity': quantity,
      'colors': colors,
    };
  }
}