import 'dart:io';
import 'package:supercycle_app/core/functions/shipment_manager.dart';
import 'package:supercycle_app/features/sales_process/data/models/dosh_item_model.dart';
import 'package:supercycle_app/features/sales_process/data/models/representitive_model.dart';

class SingleShipmentModel {
  final String id;
  final String shipmentNumber;
  final String customPickupAddress;
  final DateTime requestedPickupAt;
  final String status;
  final List<String> uploadedImages;
  final List<File> images;
  final List<DoshItemModel> items;
  final String userNotes;
  final num totalQuantityKg;
  final RepresentitiveModel? representitive;

  SingleShipmentModel({
    required this.id,
    required this.shipmentNumber,
    required this.customPickupAddress,
    required this.requestedPickupAt,
    required this.status,
    required this.uploadedImages,
    required this.items,
    required this.userNotes,
    required this.totalQuantityKg,
    this.representitive,
    this.images = const [],
  });

  factory SingleShipmentModel.fromJson(Map<String, dynamic> json) {
    return SingleShipmentModel(
      id: json['_id'] as String,
      shipmentNumber: json['shipmentNumber'] as String,
      customPickupAddress: json['customPickupAddress'] as String,
      requestedPickupAt: DateTime.parse(json['requestedPickupAt'] as String),
      status: json['status'] as String,
      uploadedImages: json['uploadedImages'] != null
          ? List<String>.from(json['uploadedImages'])
          : [],
      items: json['items'] != null
          ? List<DoshItemModel>.from(
              json['items'].map((x) => DoshItemModel.fromJson(x)),
            )
          : [],
      userNotes: json['userNotes'] as String? ?? '',
      totalQuantityKg: json['totalQuantityKg'] as num? ?? 0,
      representitive: json['representitive'] != null
          ? RepresentitiveModel.fromJson(json['representitive'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'shipmentNumber': shipmentNumber,
      'customPickupAddress': customPickupAddress,
      'requestedPickupAt': requestedPickupAt.toIso8601String(),
      'status': status,
      'uploadedImages': uploadedImages,
      'items': items.map((item) => item.toJson()).toList(),
      'userNotes': userNotes,
      'totalQuantityKg': totalQuantityKg,
      'representitive': representitive?.toJson(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'customPickupAddress': customPickupAddress,
      'requestedPickupAt': requestedPickupAt,
      'items': ShipmentManager.createDoshItemsMap(items: items),
      'userNotes': userNotes,
    };
  }

  @override
  String toString() {
    return 'ShipmentModel(id: $id, shipmentNumber: $shipmentNumber, customPickupAddress: $customPickupAddress, requestedPickupAt: $requestedPickupAt, status: $status, uploadedImages: $uploadedImages, items: $items, userNotes: $userNotes, totalQuantityKg: $totalQuantityKg, representitive: $representitive)';
  }

  SingleShipmentModel copyWith({
    String? id,
    String? shipmentNumber,
    String? customPickupAddress,
    DateTime? requestedPickupAt,
    String? status,
    List<String>? uploadedImages,
    List<DoshItemModel>? items,
    String? userNotes,
    num? totalQuantityKg,
    RepresentitiveModel? representitive,
    List<File>? images,
  }) {
    return SingleShipmentModel(
      id: id ?? this.id,
      shipmentNumber: shipmentNumber ?? this.shipmentNumber,
      customPickupAddress: customPickupAddress ?? this.customPickupAddress,
      requestedPickupAt: requestedPickupAt ?? this.requestedPickupAt,
      status: status ?? this.status,
      uploadedImages: uploadedImages ?? this.uploadedImages,
      items: items ?? this.items,
      userNotes: userNotes ?? this.userNotes,
      totalQuantityKg: totalQuantityKg ?? this.totalQuantityKg,
      representitive: representitive ?? this.representitive,
      images: images ?? this.images,
    );
  }
}
