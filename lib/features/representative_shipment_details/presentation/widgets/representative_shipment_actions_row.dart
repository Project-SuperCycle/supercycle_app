import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';

class RepresentativeShipmentActionsRow extends StatelessWidget {
  final String shipmentID;
  const RepresentativeShipmentActionsRow({super.key, required this.shipmentID});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
          onPressed: () {
            GoRouter.of(context).push(
              EndPoints.representativeShipmentReviewView,
              extra: shipmentID,
            );
          },
          child: Text(
            'تأكيد الشحنة',
            style: AppStyles.styleBold14(context).copyWith(color: Colors.white),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
          onPressed: () {},
          child: Text(
            'تعديل',
            style: AppStyles.styleBold14(context).copyWith(color: Colors.white),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.failureColor,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
          onPressed: () {},
          child: Text(
            'رفض الشحنة',
            style: AppStyles.styleBold14(context).copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
