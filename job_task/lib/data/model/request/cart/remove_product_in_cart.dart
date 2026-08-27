class RemoveProductFromCartRequest {
  final int id;

  const RemoveProductFromCartRequest({
    required this.id,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
  };
}