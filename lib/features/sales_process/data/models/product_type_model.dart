class ProductTypeModel {
  final String id;
  final String type;
  final num quantity;
  final String unit;

  ProductTypeModel({
    required this.id,
    required this.type,
    required this.quantity,
    required this.unit,
  });

  factory ProductTypeModel.fromJson(Map<String, dynamic> json) {
    return ProductTypeModel(
      id: json['id'] as String,
      type: json['type'] ?? "",
      unit: json['unit'] as String,
      quantity: json['quantity'] as num,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {'id': id, 'type': type, 'unit': unit, 'quantity': quantity};
  }

  // Optional: toString method for debugging
  @override
  String toString() {
    return 'ProductTypeModel(id: $id, type: $type, unit: $unit, quantity: $quantity)';
  }

  // Optional: copyWith method for creating modified copies
  ProductTypeModel copyWith({
    String? id,
    String? type,
    String? unit,
    num? quantity,
  }) {
    return ProductTypeModel(
      id: id ?? this.id,
      type: type ?? this.type,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
    );
  }
}
