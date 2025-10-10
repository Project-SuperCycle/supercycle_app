import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/segment_card_header.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/segment_card_progress.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/segment_destination_section.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/segment_next_button.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/segment_products_details.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/segment_truck_info.dart';

class DeliveryOrderCard extends StatelessWidget {
  final String driverName;
  final String phoneNumber;
  final String truckNumber;
  final int currentStage;
  final int totalStages;
  final String destinationTitle;
  final String destinationAddress;
  final String productType;
  final String quantity;
  final VoidCallback? onNextPressed;
  final VoidCallback? onInfoPressed;

  const DeliveryOrderCard({
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
    this.onNextPressed,
    this.onInfoPressed,
  });

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
            SegmentCardHeader(driverName: driverName, phoneNumber: phoneNumber),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: SegmentCardProgress(
                currentStep: currentStep,
                steps: steps,
              ),
            ),
            SegmentTruckInfo(truckNumber: truckNumber),
            SizedBox(height: 4),
            SegmentDestinationSection(
              destinationTitle: destinationTitle,
              destinationAddress: destinationAddress,
            ),
            SegmentProductsDetails(
              quantity: quantity,
              productType: productType,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [SegmentNextButton(onNextPressed: onNextPressed)],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
