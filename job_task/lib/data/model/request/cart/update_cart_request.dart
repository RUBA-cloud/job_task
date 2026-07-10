class UpdateCartRequest {
  final int id;        // the Carts row's primary key
  final int quantity;

  const UpdateCartRequest({
    required this.id,
    required this.quantity,
  });

  /// Column map for updating a Carts row. `id` is NOT included here —
  /// it's the WHERE condition, not a value to change.
  Map<String, Object?> toMap() => {
    'quantity': quantity,
    'updated_date': DateTime.now().toIso8601String(),
  };
}