import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
import 'package:supercycle_app/features/shipments_calendar/data/models/shipment_model.dart';
import 'package:supercycle_app/features/shipments_calendar/presentation/widget/shipment_calendar_card.dart';

class TraderProfileInfoCard2 extends StatefulWidget {
  const TraderProfileInfoCard2({super.key});

  @override
  State<TraderProfileInfoCard2> createState() => _TraderProfileInfoCard2State();
}

class _TraderProfileInfoCard2State extends State<TraderProfileInfoCard2> {
  List<ShipmentModel> transactions = [
    ShipmentModel(
      id: "1101",
      shipmentNumber: "SC-1101",
      customPickupAddress: "جسر السويس - القاهرة",
      requestedPickupAt: DateTime.now(),
      status: "pending",
      totalQuantityKg: 3000,
    ),
    ShipmentModel(
      id: "1102",
      shipmentNumber: "SC-1102",
      customPickupAddress: "جسر السويس - القاهرة",
      requestedPickupAt: DateTime.now(),
      status: "pending",
      totalQuantityKg: 3000,
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
            color: const Color(0xFF10B981).withAlpha(25),
            border: Border.all(color: const Color(0xFF10B981)),
            borderRadius: BorderRadius.circular(
              ProfileConstants.cardBorderRadius,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(25),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 12),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ShipmentsCalendarCard(shipment: transaction),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
