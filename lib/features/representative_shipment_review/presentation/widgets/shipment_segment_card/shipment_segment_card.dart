import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/core/helpers/custom_confirm_dialog.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/cubits/start_segment_cubit/start_segment_cubit.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/models/shipment_segment_model.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/models/start_segment_model.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/shipment_segment_step1.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/shipment_segment_step2.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/shipment_segment_step3.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_card_header.dart';

class ShipmentSegmentCard extends StatefulWidget {
  final String shipmentID;
  final ShipmentSegmentModel segment;
  const ShipmentSegmentCard({
    super.key,
    required this.segment,
    required this.shipmentID,
  });

  @override
  State<ShipmentSegmentCard> createState() => _ShipmentSegmentCardState();
}

class _ShipmentSegmentCardState extends State<ShipmentSegmentCard> {
  bool isMoved = false;
  bool isWeighted = false;
  bool isDelivered = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isMoved = widget.segment.status == "in_transit_to_scale";
      isWeighted = widget.segment.status == "in_transit_to_destination";
      isDelivered =
          widget.segment.status == "delivered" ||
          widget.segment.status == "failed";
    });
  }

  void onMovedPressed() {
    StartSegmentModel startModel = StartSegmentModel(
      shipmentID: widget.shipmentID,
      segmentID: widget.segment.id,
    );
    showCustomConfirmationDialog(
      context: context,
      title: 'هل أنت متأكد؟',
      message: 'من تحريك العربية',
      onConfirmed: () {
        BlocProvider.of<StartSegmentCubit>(
          context,
        ).startSegment(startModel: startModel);
        setState(() {
          isMoved = true;
        });
      },
    );
  }

  void onWeightedPressed() {
    setState(() {
      isWeighted = true;
    });
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
    if (isWeighted || isDelivered) {
      return ShipmentSegmentStep3(
        segment: widget.segment,
        isDelivered: isDelivered,
        onDeliveredPressed: onDeliveredPressed,
        onImagesSelected: (List<File>? image) {},
        shipmentID: widget.shipmentID,
        segmentID: widget.segment.id,
      );
    }

    // Step 2: Show if moved to warehouse (isMoved = true)
    if (isMoved) {
      return ShipmentSegmentStep2(
        shipmentID: widget.shipmentID,
        segment: widget.segment,
        isWeighted: isWeighted,
        onWeightedPressed: onWeightedPressed,
      );
    }

    // Step 1: Default initial step
    return ShipmentSegmentStep1(
      shipmentID: widget.shipmentID,
      segment: widget.segment,
      isMoved: isMoved,
      onMovedPressed: onMovedPressed,
    );
  }
}
