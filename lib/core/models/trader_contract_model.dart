class TraderContractModel {
  final DateTime startDate;
  final DateTime endDate;
  final String paymentMethod;
  final num fullQuantity;
  final List<String> types;

  const TraderContractModel({
    required this.startDate,
    required this.endDate,
    required this.paymentMethod,
    required this.fullQuantity,
    required this.types,
  });

  factory TraderContractModel.fromJson(Map<String, dynamic> json) {
    return TraderContractModel(
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : DateTime.now(),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'])
          : DateTime.now(),
      paymentMethod: json['paymentMethod'] ?? '',
      fullQuantity: json['fullQuantity'] ?? 0,
      types: (json['types'] != null)
          ? (json['types'] as List).map((type) => type.toString()).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'paymentMethod': paymentMethod,
      'fullQuantity': fullQuantity,
      'types': types,
    };
  }

  TraderContractModel copyWith({
    DateTime? startDate,
    DateTime? endDate,
    String? paymentMethod,
    num? fullQuantity,
    List<String>? types,
  }) {
    return TraderContractModel(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      fullQuantity: fullQuantity ?? this.fullQuantity,
      types: types ?? this.types,
    );
  }
}
