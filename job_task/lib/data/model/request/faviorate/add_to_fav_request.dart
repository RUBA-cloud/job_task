class AddToFavRequest {
  final int productId;
  const AddToFavRequest({required this.productId,});

  /// Row map for inserting into the Favorites table.
  Map<String, Object?> toMap() => {'product_id': productId};

  factory AddToFavRequest.fromMap(Map<String, Object?> map) => AddToFavRequest(
    productId: map['product_id'] as int,
  );
}