class Product {
  final String id;
  final String type;
  final int quantity;
  final String unit;
  final String description;

  Product({
    required this.id,
    required this.type,
    required this.quantity,
    required this.unit,
    required this.description,
  });

  // هنا الدالة copyWith
  Product copyWith({
    String? id,
    String? type,
    int? quantity,
    String? unit,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, type: $type, quantity: $quantity, unit: $unit, description: $description)';
  }
}
