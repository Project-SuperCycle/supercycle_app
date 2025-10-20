class FailSegmentModel {
  final String shipmentID;
  final String segmentID;
  final String reason;

  FailSegmentModel({
    required this.shipmentID,
    required this.segmentID,
    required this.reason,
  });

  factory FailSegmentModel.fromJson(Map<String, dynamic> json) {
    return FailSegmentModel(
      shipmentID: json['shipmentID'] as String,
      segmentID: json['segmentID'] as String,
      reason: json['reason'] as String,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {'shipmentID': shipmentID, 'segmentID': segmentID, 'reason': reason};
  }

  // Optional: toString method for debugging
  @override
  String toString() {
    return 'FailSegmentModel(shipmentID: $shipmentID, segmentID: $segmentID, reason: $reason)';
  }

  // Optional: copyWith method for creating modified copies
  FailSegmentModel copyWith({
    String? shipmentID,
    String? segmentID,
    String? reason,
  }) {
    return FailSegmentModel(
      shipmentID: shipmentID ?? this.shipmentID,
      segmentID: segmentID ?? this.segmentID,
      reason: reason ?? this.reason,
    );
  }
}
