import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:supercycle/core/utils/app_assets.dart';
import 'package:supercycle/core/utils/app_colors.dart';
import 'package:supercycle/core/widgets/shipment/expandable_section.dart';
import 'package:supercycle/features/representative_shipment_review/data/cubits/deliver_segment_cubit/deliver_segment_cubit.dart';
import 'package:supercycle/features/representative_shipment_review/data/cubits/fail_segment_cubit/fail_segment_cubit.dart';
import 'package:supercycle/features/representative_shipment_review/data/models/deliver_segment_model.dart';
import 'package:supercycle/features/representative_shipment_review/data/models/fail_segment_model.dart';
import 'package:supercycle/features/representative_shipment_review/data/models/shipment_segment_model.dart';
import 'package:supercycle/features/representative_shipment_review/presentation/widgets/segment_deliver_modal/segment_deliver_modal.dart';
import 'package:supercycle/features/representative_shipment_review/presentation/widgets/segment_fail_modal/segment_fail_modal.dart';
import 'package:supercycle/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_action_button.dart';
import 'package:supercycle/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_deliverd_section.dart';
import 'package:supercycle/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_weight_info.dart';

class ShipmentSegmentStep3 extends StatefulWidget {
  final ShipmentSegmentModel segment;
  final bool isDelivered;
  final VoidCallback onDeliveredPressed;
  final Function(List<File>?)? onImagesSelected;
  final String shipmentID;
  final String segmentID;

  const ShipmentSegmentStep3({
    super.key,
    required this.segment,
    required this.isDelivered,
    required this.onDeliveredPressed,
    required this.onImagesSelected,
    required this.shipmentID,
    required this.segmentID,
  });

  @override
  State<ShipmentSegmentStep3> createState() => _ShipmentSegmentStep3State();
}

class _ShipmentSegmentStep3State extends State<ShipmentSegmentStep3> {
  bool isWeightDataExpanded = false;

  void _toggleWeightData() {
    setState(() {
      isWeightDataExpanded = !isWeightDataExpanded;
    });
  }

  void _showDeliverModal(BuildContext context) {
    SegmentDeliverModal.show(
      context,
      shipmentID: widget.shipmentID,
      onSubmit: (List<File> images, String name) {
        Logger().i('✅ Deliver Shipment Segment');

        DeliverSegmentModel deliverModel = DeliverSegmentModel(
          shipmentID: widget.shipmentID,
          segmentID: widget.segmentID,
          receivedByName: name,
          images: images,
        );

        BlocProvider.of<DeliverSegmentCubit>(
          context,
        ).deliverSegment(deliverModel: deliverModel);

        widget.onDeliveredPressed();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('تم تأكيد الشحنة بنجاح'),
              ],
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }

  void _showFailModal(BuildContext context) {
    SegmentFailModal.show(
      context,
      shipmentID: widget.shipmentID,
      onSubmit: (List<File> images, String reason) {
        Logger().i('✅ Fail Shipment Segment');

        FailSegmentModel failModel = FailSegmentModel(
          shipmentID: widget.shipmentID,
          segmentID: widget.segmentID,
          reason: reason,
          images: images,
        );

        BlocProvider.of<FailSegmentCubit>(
          context,
        ).failSegment(failModel: failModel);

        widget.onDeliveredPressed();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('تم تسجيل العطلة'),
              ],
            ),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
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
              segment: widget.segment,
            ),
          ),
        ),
        const SizedBox(height: 20),
        widget.segment.status == "failed"
            ? SegmentStateInfo(
                title: "حدث مشكلة",
                icon: FontAwesomeIcons.xmark,
                mainColor: AppColors.failureColor,
              )
            : widget.isDelivered
            ? SegmentStateInfo(
                title: "تم التسليم",
                icon: Icons.check_circle_outline_rounded,
                mainColor: AppColors.primaryColor,
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SegmentActionButton(
                        title: "تم التوصيل",
                        onPressed: () => _showDeliverModal(context),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: SegmentActionButton(
                        backgroundColor: AppColors.failureColor,
                        title: "عطلة",
                        onPressed: () => _showFailModal(context),
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
