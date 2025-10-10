import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/widgets/shipment/expandable_section.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/segment_card_header.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/segment_card_progress.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/segment_deliverd_section.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/segment_destination_section.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/segment_products_details.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/segment_truck_info.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/segment_weight_info.dart';

class ShipmentSegmentCard extends StatefulWidget {
  final String driverName;
  final String phoneNumber;
  final String truckNumber;
  final int currentStage;
  final int totalStages;
  final String destinationTitle;
  final String destinationAddress;
  final String productType;
  final String quantity;

  const ShipmentSegmentCard({
    super.key,
    required this.driverName,
    required this.phoneNumber,
    required this.truckNumber,
    this.currentStage = 0,
    this.totalStages = 3,
    required this.destinationTitle,
    required this.destinationAddress,
    required this.productType,
    required this.quantity,
  });

  @override
  State<ShipmentSegmentCard> createState() => _ShipmentSegmentCardState();
}

class _ShipmentSegmentCardState extends State<ShipmentSegmentCard> {
  bool isWeightDataExpanded = false;

  void _toggleWeightData() {
    setState(() {
      isWeightDataExpanded = !isWeightDataExpanded;
    });
  }

  void onNextPressed() {}

  void onMovePressed() {}

  @override
  Widget build(BuildContext context) {
    int currentStep = 1;

    final List<StepData> steps = const [
      StepData(title: 'تم التحرك', icon: Icons.shopping_cart_rounded),
      StepData(title: 'تم الوزن', icon: Icons.local_shipping_rounded),
      StepData(title: 'تم التسليم', icon: Icons.check_circle_rounded),
    ];

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
              driverName: widget.driverName,
              phoneNumber: widget.phoneNumber,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: SegmentCardProgress(
                currentStep: currentStep,
                steps: steps,
              ),
            ),
            SegmentTruckInfo(truckNumber: widget.truckNumber),
            SizedBox(height: 4),
            SegmentDestinationSection(
              destinationTitle: widget.destinationTitle,
              destinationAddress: widget.destinationAddress,
            ),
            SegmentProductsDetails(
              quantity: widget.quantity,
              productType: widget.productType,
            ),

            // Padding(
            //   padding: const EdgeInsets.only(right: 25.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       SegmentActionButton(
            //         title: "تم التحرك",
            //         onPressed: onNextPressed,
            //       ),
            //     ],
            //   ),
            // ),
            // SegmentWeightSection(
            //   onImageSelected: (File? image) {},
            //   onUploadTap: () {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       const SnackBar(
            //         content: Text('تم رفع البيانات بنجاح'),
            //         backgroundColor: Colors.green,
            //       ),
            //     );
            //   },
            // ),
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
            // Padding(
            //   padding: const EdgeInsets.only(right: 25.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       SegmentActionButton(
            //         title: "تم التوصيل",
            //         onPressed: onMovePressed,
            //       ),
            //     ],
            //   ),
            // ),
            SegmentDeliverdSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
