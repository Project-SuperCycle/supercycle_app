import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/widgets/shipment/expandable_section.dart';
import 'package:supercycle_app/features/representative_shipment_accepted/data/models/shipment_segment_data.dart';
import 'package:supercycle_app/features/representative_shipment_accepted/presentation/widgets/shipment_segments_parts/segment_action_button.dart';
import 'package:supercycle_app/features/representative_shipment_accepted/presentation/widgets/shipment_segments_parts/segment_card_progress.dart';
import 'package:supercycle_app/features/representative_shipment_accepted/presentation/widgets/shipment_segments_parts/segment_deliverd_section.dart';
import 'package:supercycle_app/features/representative_shipment_accepted/presentation/widgets/shipment_segments_parts/segment_destination_section.dart';
import 'package:supercycle_app/features/representative_shipment_accepted/presentation/widgets/shipment_segments_parts/segment_truck_info.dart';
import 'package:supercycle_app/features/representative_shipment_accepted/presentation/widgets/shipment_segments_parts/segment_weight_info.dart';

class ShipmentSegmentStep3 extends StatefulWidget {
  final ShipmentSegmentData segment;
  final bool isDelivered;
  final VoidCallback onDeliveredPressed;
  const ShipmentSegmentStep3({
    super.key,
    required this.segment,
    required this.isDelivered,
    required this.onDeliveredPressed,
  });

  @override
  State<ShipmentSegmentStep3> createState() => _ShipmentSegmentStep3State();
}

class _ShipmentSegmentStep3State extends State<ShipmentSegmentStep3> {
  bool isWeightDataExpanded = false;
  int currentStep = 2;

  void _toggleWeightData() {
    setState(() {
      isWeightDataExpanded = !isWeightDataExpanded;
    });
  }

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
        SizedBox(height: 20),
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: ExpandableSection(
            title: 'بيانات الوزنة',
            iconPath: AppAssets.boxPerspective,
            isExpanded: isWeightDataExpanded,
            maxHeight: 280,
            onTap: _toggleWeightData,
            content: SegmentWeightInfo(
              imagePath: AppAssets.miniature,
              weight: '25.5',
            ),
          ),
        ),
        const SizedBox(height: 20),
        widget.isDelivered
            ? SegmentDeliverdSection()
            : Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SegmentActionButton(
                      title: "تم التوصيل",
                      onPressed: () {
                        widget.onDeliveredPressed();
                        setState(() {
                          currentStep = 3;
                        });
                      },
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
