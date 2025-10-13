import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/representative_shipment_accepted/presentation/widgets/shipment_states_row/shipment_state_info_row.dart';

class RepresentativeShipmentStates extends StatelessWidget {
  const RepresentativeShipmentStates({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ShipmentStateInfoRow(
                title: "الأجمالى:",
                value: "3",
                valColor: AppColors.mainTextColor,
              ),
              ShipmentStateInfoRow(
                title: "قيد التنفيذ:",
                value: "3",
                valColor: Color(0xffE04133),
              ),
              ShipmentStateInfoRow(
                title: "تم التسليم:",
                value: "0",
                valColor: Color(0xff078531),
              ),
            ],
          ),
          SizedBox(width: 30),
          Text(
            "33%",
            style: AppStyles.styleBold24(context).copyWith(
              color: AppColors.primaryColor,
              fontSize: 36,
              shadows: [
                Shadow(
                  color: Colors.black45,
                  offset: Offset(0, 1),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
