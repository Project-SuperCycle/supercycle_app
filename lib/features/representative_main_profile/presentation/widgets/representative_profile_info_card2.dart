import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
import 'package:supercycle_app/features/sales_process/presentation/views/sales_process_view.dart';
import 'package:supercycle_app/features/shipments_calendar/data/models/shipment_model.dart';
import 'package:supercycle_app/features/shipments_calendar/presentation/widget/shipment_calendar_card.dart';

class RepresentativeProfileInfoCard2 extends StatefulWidget {
  const RepresentativeProfileInfoCard2({super.key});

  @override
  State<RepresentativeProfileInfoCard2> createState() =>
      _RepresentativeProfileInfoCard2State();
}

class _RepresentativeProfileInfoCard2State
    extends State<RepresentativeProfileInfoCard2> {
  List<ShipmentsCalendarCard> transactions = [
    ShipmentsCalendarCard(
      shipment: ShipmentModel(
        id: "01",
        shipmentNumber: "SN0001",
        customPickupAddress: "ميدان الجيزة",
        requestedPickupAt: DateTime.now(),
        status: "pending",
        totalQuantityKg: 1000,
      ),
    ),
    ShipmentsCalendarCard(
      shipment: ShipmentModel(
        id: "02",
        shipmentNumber: "SN0002",
        customPickupAddress: "جسر السويس",
        requestedPickupAt: DateTime.now(),
        status: "pending",
        totalQuantityKg: 2000,
      ),
    ),
    ShipmentsCalendarCard(
      shipment: ShipmentModel(
        id: "03",
        shipmentNumber: "SN0003",
        customPickupAddress: "التحرير -  القاهرة",
        requestedPickupAt: DateTime.now(),
        status: "pending",
        totalQuantityKg: 3000,
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'سجل المعاملات السابقة',
          style: AppStyles.styleSemiBold22(context),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xE4DDFFE7).withAlpha(50),
            border: Border.all(color: Color(0xFF16A243).withAlpha(200)),
            borderRadius: BorderRadius.circular(
              ProfileConstants.cardBorderRadius,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [...transactions]),
          ),
        ),
      ],
    );
  }
}
