enum ShipmentStatus { pending, delivered }

class Shipment {
  final String number;
  final String time;
  final String quantity;
  final String address;
  final ShipmentStatus status;

  Shipment({
    required this.number,
    required this.time,
    required this.quantity,
    required this.address,
    required this.status,
  });

  String get statusText {
    return status == ShipmentStatus.delivered ? 'تم التسليم' : 'قيد التوصيل';
  }

  bool get isDelivered => status == ShipmentStatus.delivered;
}