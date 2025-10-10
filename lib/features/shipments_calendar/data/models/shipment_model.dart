class ShipmentModel {
  final String id;
  final String shipmentNumber;
  final String customPickupAddress;
  final DateTime requestedPickupAt;
  final String status;
  final num totalQuantityKg;

  ShipmentModel({
    required this.id,
    required this.shipmentNumber,
    required this.customPickupAddress,
    required this.requestedPickupAt,
    required this.status,
    required this.totalQuantityKg,
  });

  factory ShipmentModel.fromJson(Map<String, dynamic> json) {
    return ShipmentModel(
      id: json['_id'] ?? "",
      shipmentNumber: json['shipmentNumber'] ?? "",
      customPickupAddress: json['customPickupAddress'] ?? "",
      requestedPickupAt: DateTime.parse(json['requestedPickupAt'] as String),
      status: json['status'] as String,
      totalQuantityKg: json['totalQuantityKg'] as num? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'shipmentNumber': shipmentNumber,
      'customPickupAddress': customPickupAddress,
      'requestedPickupAt': requestedPickupAt.toIso8601String(),
      'status': status,
      'totalQuantityKg': totalQuantityKg,
    };
  }

  @override
  String toString() {
    return 'ShipmentModel(id: $id, shipmentNumber: $shipmentNumber, customPickupAddress: $customPickupAddress, requestedPickupAt: $requestedPickupAt, status: $status, totalQuantityKg: $totalQuantityKg)';
  }

  ShipmentModel copyWith({
    String? id,
    String? shipmentNumber,
    String? customPickupAddress,
    DateTime? requestedPickupAt,
    String? status,
    num? totalQuantityKg,
  }) {
    return ShipmentModel(
      id: id ?? this.id,
      shipmentNumber: shipmentNumber ?? this.shipmentNumber,
      customPickupAddress: customPickupAddress ?? this.customPickupAddress,
      requestedPickupAt: requestedPickupAt ?? this.requestedPickupAt,
      status: status ?? this.status,
      totalQuantityKg: totalQuantityKg ?? this.totalQuantityKg,
    );
  }
}
