class WeighSegmentModel {
  final String shipmentID;
  final String segmentID;
  final num actualWeightKg;
  final List<String> images;

  WeighSegmentModel({
    required this.shipmentID,
    required this.segmentID,
    required this.actualWeightKg,
    required this.images,
  });

  factory WeighSegmentModel.fromJson(Map<String, dynamic> json) {
    return WeighSegmentModel(
      shipmentID: json['shipmentID'] as String,
      segmentID: json['segmentID'] as String,
      actualWeightKg: json['actualWeightKg'] as num,
      images: List<String>.from(json['images'] as List),
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'shipmentID': shipmentID,
      'segmentID': segmentID,
      'actualWeightKg': actualWeightKg,
      'images': images,
    };
  }

  // Optional: toString method for debugging
  @override
  String toString() {
    return 'WeighSegmentModel(shipmentID: $shipmentID, segmentID: $segmentID, actualWeightKg: $actualWeightKg, images: $images)';
  }

  // Optional: copyWith method for creating modified copies
  WeighSegmentModel copyWith({
    String? shipmentID,
    String? segmentID,
    num? actualWeightKg,
    List<String>? images,
  }) {
    return WeighSegmentModel(
      shipmentID: shipmentID ?? this.shipmentID,
      segmentID: segmentID ?? this.segmentID,
      actualWeightKg: actualWeightKg ?? this.actualWeightKg,
      images: images ?? this.images,
    );
  }
}
