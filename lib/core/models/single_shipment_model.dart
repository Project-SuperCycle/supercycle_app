import 'dart:io';

import 'package:supercycle_app/core/functions/shipment_manager.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/models/rep_note_model.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/models/shipment_segment_model.dart';
import 'package:supercycle_app/features/sales_process/data/models/dosh_item_model.dart';
import 'package:supercycle_app/features/sales_process/data/models/representitive_model.dart';

class SingleShipmentModel {
  final String id;
  final String shipmentNumber;
  final String? customPickupAddress;
  final DateTime requestedPickupAt;
  final String status;
  final List<String> uploadedImages;
  final List<File> images;
  final List<DoshItemModel> items;
  final String userNotes;
  final num totalQuantityKg;
  final RepresentitiveModel? representitive;
  final List<RepNoteModel> mainNotes;
  final List<RepNoteModel> repNotes;
  final List<ShipmentSegmentModel> segments;

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
    required this.mainNotes,
    required this.repNotes,
    required this.segments,
    this.representitive,
    this.images = const [],
  });

  factory SingleShipmentModel.fromJson(Map<String, dynamic> json) {
    // Parse all notes first
    List<RepNoteModel> allNotes = json['notes'] != null
        ? List<RepNoteModel>.from(
            json['notes'].map((x) => RepNoteModel.fromJson(x)),
          )
        : [];

    // Filter notes based on authorRole
    List<RepNoteModel> mainNotes = allNotes
        .where((note) => note.authorRole != 'representative')
        .toList();

    List<RepNoteModel> repNotes = allNotes
        .where((note) => note.authorRole == 'representative')
        .toList();

    return SingleShipmentModel(
      id: json['_id'] as String,
      shipmentNumber: json['shipmentNumber'] ?? "",
      customPickupAddress: json['customPickupAddress'],
      requestedPickupAt: DateTime.parse(json['requestedPickupAt'] as String),
      status: json['status'] ?? "",
      uploadedImages: json['uploadedImages'] != null
          ? List<String>.from(json['uploadedImages'])
          : [],
      items: json['items'] != null
          ? List<DoshItemModel>.from(
              json['items'].map((x) => DoshItemModel.fromJson(x)),
            )
          : [],
      userNotes: json['userNotes'] ?? '',
      totalQuantityKg: json['totalQuantityKg'] as num? ?? 0,
      representitive: json['representitive'] != null
          ? RepresentitiveModel.fromJson(json['representitive'])
          : null,
      mainNotes: mainNotes,
      repNotes: repNotes,
      segments: json['segments'] != null
          ? List<ShipmentSegmentModel>.from(
              json['segments'].map((x) => ShipmentSegmentModel.fromJson(x)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    // Combine mainNotes and repNotes back into a single notes array
    List<RepNoteModel> allNotes = [...mainNotes, ...repNotes];

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
      'notes': allNotes.map((note) => note.toJson()).toList(),
      'segments': segments.map((segment) => segment.toJson()).toList(),
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
    return 'SingleShipmentModel(id: $id, shipmentNumber: $shipmentNumber, customPickupAddress: $customPickupAddress, requestedPickupAt: $requestedPickupAt, status: $status, uploadedImages: $uploadedImages, items: $items, userNotes: $userNotes, totalQuantityKg: $totalQuantityKg, representitive: $representitive, mainNotes: $mainNotes, repNotes: $repNotes, segments: $segments)';
  }

  SingleShipmentModel copyWith({
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
    List<RepNoteModel>? mainNotes,
    List<RepNoteModel>? repNotes,
    List<ShipmentSegmentModel>? segments,
  }) {
    return SingleShipmentModel(
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
      mainNotes: mainNotes ?? this.mainNotes,
      repNotes: repNotes ?? this.repNotes,
      segments: segments ?? this.segments,
    );
  }
}
