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
import 'package:supercycle/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_card_progress.dart';
import 'package:supercycle/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_deliverd_section.dart';
import 'package:supercycle/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_destination_section.dart';
import 'package:supercycle/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_truck_info.dart';
import 'package:supercycle/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_weight_info.dart';

class ShipmentSegmentStep3 extends StatefulWidget {
  final ShipmentSegmentModel segment;
  final bool isDelivered;
  final VoidCallback onDeliveredPressed;
  final Function(List<File>?)? onImagesSelected;
  final String shipmentID;
  final String segmentID;
  final int maxImages;
  const ShipmentSegmentStep3({
    super.key,
    required this.segment,
    required this.isDelivered,
    required this.onDeliveredPressed,
    required this.onImagesSelected,
    required this.shipmentID,
    required this.segmentID,
    this.maxImages = 5,
  });

  @override
  State<ShipmentSegmentStep3> createState() => _ShipmentSegmentStep3State();
}

class _ShipmentSegmentStep3State extends State<ShipmentSegmentStep3> {
  bool isWeightDataExpanded = false;
  int currentStep = 2;
  final TextEditingController _weightController = TextEditingController();
  final List<File> _selectedImages = [];
  bool _isButtonEnabled = false;

  void _toggleWeightData() {
    setState(() {
      isWeightDataExpanded = !isWeightDataExpanded;
    });
  }

  @override
  void initState() {
    super.initState();
    _weightController.addListener(_updateButtonState);
    setState(() {
      currentStep = widget.isDelivered == true ? 3 : 2;
    });
  }

  @override
  void dispose() {
    _weightController.removeListener(_updateButtonState);
    _weightController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    final newState =
        _selectedImages.isNotEmpty && _weightController.text.trim().isNotEmpty;
    if (_isButtonEnabled != newState) {
      setState(() {
        _isButtonEnabled = newState;
      });
    }
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

        Logger().w("DELIVER SEGMENT MODEL: $deliverModel");

        // هنا أضف منطق إرسال البيانات للـ API
        BlocProvider.of<DeliverSegmentCubit>(
          context,
        ).deliverSegment(deliverModel: deliverModel);
        setState(() {
          currentStep = 3;
        });
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

        Logger().w("FAIL SEGMENT MODEL: $failModel");

        // هنا أضف منطق إرسال البيانات للـ API
        BlocProvider.of<FailSegmentCubit>(
          context,
        ).failSegment(failModel: failModel);
        setState(() {
          currentStep = 3;
        });
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

  String get weightValue => _weightController.text;
  List<File> get selectedImages => _selectedImages;

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
                        onPressed: () {
                          _showDeliverModal(context);
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: SegmentActionButton(
                        backgroundColor: AppColors.failureColor,
                        title: "عطلة",
                        onPressed: () {
                          _showFailModal(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
