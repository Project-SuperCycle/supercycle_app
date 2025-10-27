import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/models/shipment_segment_model.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/shipment_segment_step1.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/shipment_segment_step2.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/shipment_segment_step3.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_card_header.dart';

class ShipmentSegmentCard extends StatefulWidget {
  final ShipmentSegmentModel segment;
  const ShipmentSegmentCard({super.key, required this.segment});

  @override
  State<ShipmentSegmentCard> createState() => _ShipmentSegmentCardState();
}

class _ShipmentSegmentCardState extends State<ShipmentSegmentCard> {
  bool isMoved = false;
  bool isWeighted = false;
  bool isDelivered = false;

  void onMovedPressed() {
    setState(() {
      isMoved = true;
    });
    Logger().i("isMoved: $isMoved");
  }

  void onWeightedPressed() {
    setState(() {
      isWeighted = true;
    });
    Logger().i("isWeighted: $isWeighted");
  }

  void onDeliveredPressed() {
    setState(() {
      isDelivered = true;
    });
    Logger().i("isDelivered: $isDelivered");
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            SegmentCardHeader(
              driverName: widget.segment.driverName!,
              phoneNumber: widget.segment.driverPhone!,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: _buildCurrentStep(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Determines which step to display based on current state
  Widget _buildCurrentStep() {
    // Step 3: Show if weight is uploaded (isWeighted = true)
    if (isWeighted) {
      return ShipmentSegmentStep3(
        segment: widget.segment,
        isDelivered: isDelivered,
        onDeliveredPressed: onDeliveredPressed,
      );
    }

    // Step 2: Show if moved to warehouse (isMoved = true)
    if (isMoved) {
      return ShipmentSegmentStep2(
        segment: widget.segment,
        isWeighted: isWeighted,
        onUploadPressed: onWeightedPressed,
      );
    }

    // Step 1: Default initial step
    return ShipmentSegmentStep1(
      segment: widget.segment,
      isMoved: isMoved,
      onMovedPressed: onMovedPressed,
    );
  }
}
