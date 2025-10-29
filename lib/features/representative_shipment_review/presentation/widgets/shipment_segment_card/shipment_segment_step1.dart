import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle_app/core/helpers/custom_loading_indicator.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/cubits/start_segment_cubit/start_segment_cubit.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/cubits/start_segment_cubit/start_segment_state.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/models/shipment_segment_model.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_action_button.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_card_progress.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_destination_section.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_products_details.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_truck_info.dart';

class ShipmentSegmentStep1 extends StatefulWidget {
  final String shipmentID;
  final ShipmentSegmentModel segment;
  final bool isMoved;
  final VoidCallback onMovedPressed;

  const ShipmentSegmentStep1({
    super.key,
    required this.shipmentID,
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
        SegmentTruckInfo(truckNumber: widget.segment.vehicleNumber!),
        const SizedBox(height: 4),
        SegmentDestinationSection(
          destinationTitle: widget.segment.destName ?? "",
          destinationAddress: widget.segment.destAddress ?? "",
        ),
        // Dynamically display products
        if (widget.segment.items.isNotEmpty)
          ...widget.segment.items.map((item) {
            return SegmentProductsDetails(
              quantity: item.quantity,
              productType: item.name,
            );
          }),
        Padding(
          padding: const EdgeInsets.only(right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlocConsumer<StartSegmentCubit, StartSegmentState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is StartSegmentSuccess) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                  if (state is StartSegmentFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                  }
                },
                builder: (context, state) {
                  return (state is StartSegmentLoading)
                      ? SizedBox(
                          width: 60,
                          height: 60,
                          child: Center(child: CustomLoadingIndicator()),
                        )
                      : SegmentActionButton(
                          title: "تم التحرك",
                          onPressed: widget.onMovedPressed,
                        );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
