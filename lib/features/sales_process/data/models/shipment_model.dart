import 'package:supercycle_app/features/sales_process/data/models/product_type_model.dart';
import 'package:supercycle_app/features/sales_process/data/models/representitive_model.dart';

class ShipmentModel {
  final String pickupDate;
  final String status;
  final String shipmentNo;
  final List<ProductTypeModel> products;
  final List<String> notes;
  final RepresentitiveModel? representitive;

  ShipmentModel({
    required this.pickupDate,
    required this.status,
    required this.shipmentNo,
    required this.products,
    required this.notes,
    this.representitive,
  });

  factory ShipmentModel.fromJson(Map<String, dynamic> json) {
    return ShipmentModel(
      pickupDate: json['pickupDate'] as String,
      status: json['status'] ?? "",
      shipmentNo: json['shipmentNo'] as String,
      products: json['products']
          .map<ProductTypeModel>((x) => ProductTypeModel.fromJson(x))
          .toList(),
      notes: json['notes'] as List<String>,
      representitive: json['representitive']
          ? RepresentitiveModel.fromJson(json['representitive'])
          : null,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'pickupDate': pickupDate,
      'status': status,
      'shipmentNo': shipmentNo,
      'products': products,
      'notes': notes,
      'representitive': representitive,
    };
  }

  // Optional: toString method for debugging
  @override
  String toString() {
    return 'ShipmentModel(pickupDate: $pickupDate, status: $status, shipmentNo: $shipmentNo, products: ${products.toString()}, notes: ${notes.toString()}, representitive: ${representitive.toString()})';
  }

  // Optional: copyWith method for creating modified copies
  ShipmentModel copyWith({
    String? pickupDate,
    String? status,
    String? shipmentNo,
    List<ProductTypeModel>? products,
    List<String>? notes,
    RepresentitiveModel? representitive,
  }) {
    return ShipmentModel(
      pickupDate: pickupDate ?? this.pickupDate,
      status: status ?? this.status,
      shipmentNo: shipmentNo ?? this.shipmentNo,
      products: products ?? this.products,
      notes: notes ?? this.notes,
      representitive: representitive ?? this.representitive,
    );
  }
}
