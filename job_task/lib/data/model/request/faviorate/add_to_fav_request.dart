class AddToFavRequest {
  final int productId;

  const AddToFavRequest({
    required this.productId,
  });

  /// JSON body for API request
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
    };
  }

  /// Row map for SQLite
  Map<String, Object?> toMap() {
    return {
      'product_id': productId,
    };
  }

  factory AddToFavRequest.fromMap(Map<String, Object?> map) {
    return AddToFavRequest(
      productId: map['product_id'] as int,
    );
  }
}