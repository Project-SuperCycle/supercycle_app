import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supercycle/core/utils/app_colors.dart';
import 'package:supercycle/features/representative_shipment_review/data/cubits/weigh_segment_cubit/weigh_segment_cubit.dart';
import 'package:supercycle/features/representative_shipment_review/data/models/shipment_segment_model.dart';
import 'package:supercycle/features/representative_shipment_review/data/models/weigh_segment_model.dart';
import 'package:supercycle/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_card_progress.dart';
import 'package:supercycle/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_deliverd_section.dart';
import 'package:supercycle/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_destination_section.dart';
import 'package:supercycle/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_products_details.dart';
import 'package:supercycle/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_truck_info.dart';
import 'package:supercycle/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_weight_section.dart';

class ShipmentSegmentStep2 extends StatefulWidget {
  final String shipmentID;
  final ShipmentSegmentModel segment;
  final bool isWeighted;
  final VoidCallback onWeightedPressed;

  const ShipmentSegmentStep2({
    super.key,
    required this.shipmentID,
    required this.segment,
    required this.isWeighted,
    required this.onWeightedPressed,
  });

  @override
  State<ShipmentSegmentStep2> createState() => _ShipmentSegmentStep2State();
}

class _ShipmentSegmentStep2State extends State<ShipmentSegmentStep2> {
  int currentStep = 1;
  List<File> images = [];
  TextEditingController weightController = TextEditingController();

  void onWeightedPressed() {
    widget.onWeightedPressed;
    WeighSegmentModel weighModel = WeighSegmentModel(
      shipmentID: widget.shipmentID,
      segmentID: widget.segment.id,
      images: images,
      actualWeightKg: double.tryParse(weightController.text) ?? 0.0,
    );

    BlocProvider.of<WeighSegmentCubit>(
      context,
    ).weighSegment(weighModel: weighModel);
    setState(() {
      currentStep = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: SegmentCardProgress(
            currentStep: currentStep,
            segmentStatus: widget.segment.status!,
          ),
        ),
        SegmentTruckInfo(truckNumber: widget.segment.vehicleNumber!),
        SizedBox(height: 4),
        SegmentDestinationSection(
          destinationTitle: widget.segment.destName!,
          destinationAddress: widget.segment.destAddress!,
        ),
        if (widget.segment.items.isNotEmpty)
          ...widget.segment.items.map((item) {
            return SegmentProductsDetails(
              quantity: item.quantity,
              productType: item.name,
            );
          }),
        widget.segment.status == "failed"
            ? SegmentStateInfo(
                title: "حدث مشكلة",
                icon: FontAwesomeIcons.xmark,
                mainColor: AppColors.failureColor,
              )
            : SegmentWeightSection(
                weightController: weightController,
                onImagesSelected: (List<File>? weightImages) {
                  setState(() {
                    images = weightImages ?? [];
                  });
                },
                onWeightedPressed: onWeightedPressed,
                shipmentID: widget.shipmentID,
                segmentID: widget.segment.id,
              ),
      ],
    );
  }
}
