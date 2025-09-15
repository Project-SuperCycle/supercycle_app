import 'dart:io';
import 'package:supercycle_app/features/sales_process/data/models/dosh_item_model.dart';
import 'package:supercycle_app/features/sales_process/data/models/representitive_model.dart';

class ShipmentModel {
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

  ShipmentModel({
    required this.id,
    required this.shipmentNumber,
    required this.customPickupAddress,
    required this.requestedPickupAt,
    required this.status,
    required this.uploadedImages,
    required this.images,
    required this.items,
    required this.userNotes,
    required this.totalQuantityKg,
    this.representitive,
  });

  factory ShipmentModel.fromJson(Map<String, dynamic> json) {
    return ShipmentModel(
      id: json['id'] as String,
      shipmentNumber: json['shipmentNumber'] as String,
      customPickupAddress: json['customPickupAddress'] as String,
      requestedPickupAt: DateTime.parse(json['requestedPickupAt'] as String),
      status: json['status'] as String,
      uploadedImages: json['uploadedImages'] as List<String>,
      images: json['images'] ?? [] as List<File>,
      items: json['items']
          .map<DoshItemModel>((x) => DoshItemModel.fromJson(x))
          .toList(),
      userNotes: json['userNotes'] as String,
      totalQuantityKg: json['totalQuantityKg'] as num,
      representitive: json['representitive'] ?? null as RepresentitiveModel?,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'shipmentNumber': shipmentNumber,
      'customPickupAddress': customPickupAddress,
      'requestedPickupAt': requestedPickupAt,
      'status': status,
      'uploadedImages': uploadedImages,
      'images': images,
      'items': items,
      'userNotes': userNotes,
      'totalQuantityKg': totalQuantityKg,
      'representitive': representitive,
    };
  }

  // Optional: toString method for debugging
  @override
  String toString() {
    return 'ShipmentModel(id: $id, shipmentNumber: $shipmentNumber, customPickupAddress: $customPickupAddress, requestedPickupAt: $requestedPickupAt, status: $status, uploadedImages: $uploadedImages, images: $images, items: $items, userNotes: $userNotes, totalQuantityKg: $totalQuantityKg, representitive: $representitive)';
  }

  // Optional: copyWith method for creating modified copies
  ShipmentModel copyWith({
    String? id,
    String? shipmentNumber,
    String? customPickupAddress,
    DateTime? requestedPickupAt,
    String? status,
    List<String>? uploadedImages,
    List<File>? images,
    List<DoshItemModel>? items,
    String? userNotes,
    num? totalQuantityKg,
    RepresentitiveModel? representitive,
  }) {
    return ShipmentModel(
      id: id ?? this.id,
      shipmentNumber: shipmentNumber ?? this.shipmentNumber,
      customPickupAddress: customPickupAddress ?? this.customPickupAddress,
      requestedPickupAt: requestedPickupAt ?? this.requestedPickupAt,
      status: status ?? this.status,
      uploadedImages: uploadedImages ?? this.uploadedImages,
      images: images ?? this.images,
      items: items ?? this.items,
      userNotes: userNotes ?? this.userNotes,
      totalQuantityKg: totalQuantityKg ?? this.totalQuantityKg,
      representitive: representitive ?? this.representitive,
    );
  }
}
