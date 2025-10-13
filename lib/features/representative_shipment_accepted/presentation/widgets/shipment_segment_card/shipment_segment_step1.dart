import 'package:flutter/material.dart';
import 'package:supercycle_app/features/representative_shipment_accepted/data/models/shipment_segment_data.dart';
import 'package:supercycle_app/features/representative_shipment_accepted/presentation/widgets/shipment_segments_parts/segment_action_button.dart';
import 'package:supercycle_app/features/representative_shipment_accepted/presentation/widgets/shipment_segments_parts/segment_card_header.dart';
import 'package:supercycle_app/features/representative_shipment_accepted/presentation/widgets/shipment_segments_parts/segment_card_progress.dart';
import 'package:supercycle_app/features/representative_shipment_accepted/presentation/widgets/shipment_segments_parts/segment_destination_section.dart';
import 'package:supercycle_app/features/representative_shipment_accepted/presentation/widgets/shipment_segments_parts/segment_products_details.dart';
import 'package:supercycle_app/features/representative_shipment_accepted/presentation/widgets/shipment_segments_parts/segment_truck_info.dart';

class ShipmentSegmentStep1 extends StatefulWidget {
  final ShipmentSegmentData segment;
  final bool isMoved;
  final VoidCallback onMovedPressed;
  const ShipmentSegmentStep1({
    super.key,
    required this.segment,
    required this.isMoved,
    required this.onMovedPressed,
  });

  @override
  State<ShipmentSegmentStep1> createState() => _ShipmentSegmentStep1State();
}

class _ShipmentSegmentStep1State extends State<ShipmentSegmentStep1> {
  int currentStep = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: SegmentCardProgress(currentStep: currentStep),
        ),
        SegmentTruckInfo(truckNumber: widget.segment.truckNumber),
        SizedBox(height: 4),
        SegmentDestinationSection(
          destinationTitle: widget.segment.destinationTitle,
          destinationAddress: widget.segment.destinationAddress,
        ),
        SegmentProductsDetails(quantity: 3, productType: "ورق أبيض"),
        Padding(
          padding: const EdgeInsets.only(right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SegmentActionButton(
                title: "تم التحرك",
                onPressed: widget.onMovedPressed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
