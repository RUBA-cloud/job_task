class AddProductToCartRequest {
  final int productId;
  final int quantity;
  final int? sizeId;
  final String? color;
  final List<int>? additionalsId;

  const AddProductToCartRequest({
    required this.productId,
    this.quantity = 1,
    this.sizeId,
    this.color,
    this.additionalsId,
  });

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'quantity': quantity,
    if (sizeId != null) 'size_id': sizeId,
    if (color != null && color!.isNotEmpty) 'color': color,
    if (additionalsId != null && additionalsId!.isNotEmpty)
      'additionals_id': additionalsId,
  };
}