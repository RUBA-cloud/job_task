class CreateOrderRequest {
  final List<int> products;
  final int cartId;
  final String address;
  final String streetName;
  final String buildingNumber;
  final double lat;
  final double long;
  final double totalPrice;

  const CreateOrderRequest({
    required this.products,
    required this.cartId,
    required this.address,
    required this.streetName,
    required this.buildingNumber,
    required this.lat,
    required this.long,
    required this.totalPrice,
  });
  Map<String, dynamic> toJson() => {
    'products': products,
    'cart_id': cartId,
    'address': address,
    'street_name': streetName,
    'building_number': buildingNumber,
    'lat': lat,
    'long': long,
    'total_price': totalPrice,
  };
}