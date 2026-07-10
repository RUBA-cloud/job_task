class CartEntity {
  final int id;          // row primary key
  final int productId;
  final int quantity;
  final String? name;
  final int? value;
  final String? image;
  final String? price;   // stored as TEXT in the Carts table
  final String? createdDate;
  final String? updatedDate;

  const CartEntity({
    required this.id,
    required this.productId,
    required this.quantity,
    this.name,
    this.value,
    this.image,
    this.price,
    this.createdDate,
    this.updatedDate,
  });

  /// Builds a CartItem from a SQLite row (or a decoded JSON map).
  factory CartEntity.fromMap(Map<String, Object?> map) => CartEntity(
    id: map['id'] as int,
    productId: map['product_id'] as int,
    quantity: (map['quantity'] as int?) ?? 1,
    name: map['name'] as String?,
    value: map['value'] as int?,
    image: map['image'] as String?,
    price: map['price'] as String?,
    createdDate: map['created_date'] as String?,
    updatedDate: map['updated_date'] as String?,
  );

  /// JSON/map representation (column names match the Carts table).
  Map<String, Object?> toJson() => {
    'id': id,
    'product_id': productId,
    'quantity': quantity,
    'name': name,
    'value': value,
    'image': image,
    'price': price,
    'created_date': createdDate,
    'updated_date': updatedDate,
  };

  /// price is TEXT; parse it when you need a number (returns null if unparseable).
  double? get priceAsDouble => price == null ? null : double.tryParse(price!);
}