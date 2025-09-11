import 'package:logger/logger.dart';
import 'package:supercycle_app/features/calendar/data/models/shipment.dart';

class ShipmentDataService {
  static final Map<String, List<Shipment>> _deliveryData = {
    '2025-09-04': [
      Shipment(
        number: 'SH-TEST',
        time: '12:00',
        quantity: '50',
        address: 'Test Street',
        status: ShipmentStatus.pending,
      ),
    ],

    '2025-09-15': [
      Shipment(
        number: 'SH-2025-001',
        time: '10:00 صباحًا',
        quantity: '150 كيلو',
        address: '123 شارع النجاح، القاهرة',
        status: ShipmentStatus.pending,
      ),
      Shipment(
        number: 'SH-2025-002',
        time: '2:00 مساءً',
        quantity: '80 كيلو',
        address: '456 شارع التحرير، الجيزة',
        status: ShipmentStatus.delivered,
      ),
    ],
    '2025-09-20': [
      Shipment(
        number: 'SH-2025-003',
        time: '9:30 صباحًا',
        quantity: '200 كيلو',
        address: '789 شارع الهرم، الجيزة',
        status: ShipmentStatus.pending,
      ),
    ],
    '2025-09-25': [
      Shipment(
        number: 'SH-2025-004',
        time: '11:00 صباحًا',
        quantity: '120 كيلو',
        address: '321 شارع الدقي، الجيزة',
        status: ShipmentStatus.delivered,
      ),
      Shipment(
        number: 'SH-2025-005',
        time: '3:00 مساءً',
        quantity: '90 كيلو',
        address: '654 شارع جامعة القاهرة',
        status: ShipmentStatus.delivered,
      ),
    ],
    '2025-10-03': [
      Shipment(
        number: 'SH-2025-006',
        time: '1:00 مساءً',
        quantity: '180 كيلو',
        address: '987 شارع المعادي، القاهرة',
        status: ShipmentStatus.pending,
      ),
    ],
    '2025-10-10': [
      Shipment(
        number: 'SH-2025-007',
        time: '10:30 صباحًا',
        quantity: '220 كيلو',
        address: '147 شارع السودان، المهندسين',
        status: ShipmentStatus.delivered,
      ),
    ],
    '2025-09-03': [
      Shipment(
        number: 'SH-2025-008',
        time: '9:00 صباحًا',
        quantity: '100 كيلو',
        address: '555 شارع التجمع الخامس، القاهرة الجديدة',
        status: ShipmentStatus.pending,
      ),
      Shipment(
        number: 'SH-2025-009',
        time: '4:00 مساءً',
        quantity: '75 كيلو',
        address: '777 شارع مصر الجديدة، القاهرة',
        status: ShipmentStatus.delivered,
      ),
    ],
  };


  static List<Shipment>? getShipmentsForDate(String dateKey) {
    return _deliveryData[dateKey];
  }

  static Map<String, List<Shipment>> getAllDeliveryData() {
    return Map.from(_deliveryData);
  }

  static bool hasShipmentsForDate(String dateKey) {
    final shipments = _deliveryData[dateKey];
    return shipments != null && shipments.isNotEmpty;
  }

  static int getPendingShipmentsCount(String dateKey) {
    final shipments = _deliveryData[dateKey];
    if (shipments == null) return 0;
    return shipments.where((s) => s.status == ShipmentStatus.pending).length;
  }

  static int getDeliveredShipmentsCount(String dateKey) {
    final shipments = _deliveryData[dateKey];
    if (shipments == null) return 0;
    return shipments.where((s) => s.status == ShipmentStatus.delivered).length;
  }

  static bool areAllShipmentsDelivered(String dateKey) {
    final shipments = _deliveryData[dateKey];
    if (shipments == null || shipments.isEmpty) return false;
    return shipments.every((s) => s.status == ShipmentStatus.delivered);
  }

  static bool hasAnyPendingShipments(String dateKey) {
    Logger().i(dateKey);
    final shipments = _deliveryData[dateKey];
    Logger().i(shipments);
    if (shipments == null || shipments.isEmpty) return false;
    return shipments.any((s) => s.status == ShipmentStatus.pending);
  }

  static Future<List<Shipment>?> fetchShipmentsForDate(String dateKey) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return getShipmentsForDate(dateKey);
  }

  static void addShipment(String dateKey, Shipment shipment) {
    if (_deliveryData[dateKey] == null) {
      _deliveryData[dateKey] = [];
    }
    _deliveryData[dateKey]!.add(shipment);
  }

  static bool updateShipmentStatus(String shipmentNumber, ShipmentStatus newStatus) {
    for (var dateKey in _deliveryData.keys) {
      final shipments = _deliveryData[dateKey]!;
      for (var shipment in shipments) {
        if (shipment.number == shipmentNumber) {
          final updatedShipment = Shipment(
            number: shipment.number,
            time: shipment.time,
            quantity: shipment.quantity,
            address: shipment.address,
            status: newStatus,
          );

          final index = shipments.indexOf(shipment);
          shipments[index] = updatedShipment;
          return true;
        }
      }
    }
    return false;
  }

  static List<String> getDatesWithShipments() {
    return _deliveryData.keys.where((dateKey) => hasShipmentsForDate(dateKey)).toList();
  }

  static Map<String, int> getShipmentsSummary() {
    int totalShipments = 0;
    int totalPending = 0;
    int totalDelivered = 0;

    for (var shipments in _deliveryData.values) {
      totalShipments += shipments.length;
      for (var shipment in shipments) {
        if (shipment.status == ShipmentStatus.pending) {
          totalPending++;
        } else {
          totalDelivered++;
        }
      }
    }

    return {
      'total': totalShipments,
      'pending': totalPending,
      'delivered': totalDelivered,
    };
  }
}