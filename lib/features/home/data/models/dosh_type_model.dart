class DoshTypeModel {
  final String name;
  final String pic;
  final String unit;
  final num minPrice;
  final num maxPrice;

  DoshTypeModel({
    required this.name,
    required this.pic,
    required this.unit,
    required this.minPrice,
    required this.maxPrice,
  });

  // fromJson constructor
  factory DoshTypeModel.fromJson(Map<String, dynamic> json) {
    return DoshTypeModel(
      name: json['name'] as String,
      pic: json['pic'] ?? "",
      unit: json['unit'] as String,
      minPrice: json['priceRange']['min'] as num,
      maxPrice: json['priceRange']['max'] as num,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'pic': pic,
      'unit': unit,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
    };
  }

  // Optional: toString method for debugging
  @override
  String toString() {
    return 'DoshTypeModel(name: $name, pic: $pic, unit: $unit, minPrice: $minPrice, maxPrice: $maxPrice)';
  }

  // Optional: copyWith method for creating modified copies
  DoshTypeModel copyWith({
    String? name,
    String? pic,
    String? unit,
    num? minPrice,
    num? maxPrice,
  }) {
    return DoshTypeModel(
      name: name ?? this.name,
      pic: pic ?? this.pic,
      unit: unit ?? this.unit,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }
}
