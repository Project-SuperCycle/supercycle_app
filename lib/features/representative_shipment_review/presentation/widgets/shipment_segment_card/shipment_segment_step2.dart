import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/models/shipment_segment_model.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_card_progress.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_destination_section.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_products_details.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_truck_info.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_weight_section.dart';

class ShipmentSegmentStep2 extends StatefulWidget {
  final ShipmentSegmentModel segment;
  final bool isWeighted;
  final VoidCallback onUploadPressed;

  const ShipmentSegmentStep2({
    super.key,
    required this.segment,
    required this.isWeighted,
    required this.onUploadPressed,
  });

  @override
  State<ShipmentSegmentStep2> createState() => _ShipmentSegmentStep2State();
}

class _ShipmentSegmentStep2State extends State<ShipmentSegmentStep2> {
  int currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: SegmentCardProgress(currentStep: currentStep),
        ),
        SegmentTruckInfo(truckNumber: widget.segment.vehicleNumber!),
        SizedBox(height: 4),
        SegmentDestinationSection(
          destinationTitle: widget.segment.destName!,
          destinationAddress: widget.segment.destAddress!,
        ),
        SegmentProductsDetails(quantity: 3, productType: "ورق أبيض"),
        SegmentWeightSection(
          onImagesSelected: (List<File>? image) {},
          onUploadTap: widget.onUploadPressed,
          shipmentID: widget.segment.id!,
          segmentID: widget.segment.id!,
        ),
      ],
    );
  }
}
