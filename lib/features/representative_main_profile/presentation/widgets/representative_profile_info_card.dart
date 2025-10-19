import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
import 'package:supercycle_app/features/shipments_calendar/data/models/shipment_model.dart';
import 'package:supercycle_app/features/shipments_calendar/presentation/widget/shipment_calendar_card.dart';

class RepresentativeProfileInfoCard extends StatefulWidget {
  const RepresentativeProfileInfoCard({super.key});

  @override
  State<RepresentativeProfileInfoCard> createState() =>
      _RepresentativeProfileInfoCardState();
}

class _RepresentativeProfileInfoCardState
    extends State<RepresentativeProfileInfoCard> {
  List<ShipmentModel> transactions = [
    ShipmentModel(
      id: "01",
      shipmentNumber: "SN0001",
      customPickupAddress: "ميدان الجيزة",
      requestedPickupAt: DateTime.now(),
      status: "pending",
      totalQuantityKg: 1000,
    ),

    ShipmentModel(
      id: "02",
      shipmentNumber: "SN0002",
      customPickupAddress: "جسر السويس",
      requestedPickupAt: DateTime.now(),
      status: "pending",
      totalQuantityKg: 2000,
    ),

    ShipmentModel(
      id: "03",
      shipmentNumber: "SN0003",
      customPickupAddress: "التحرير -  القاهرة",
      requestedPickupAt: DateTime.now(),
      status: "pending",
      totalQuantityKg: 3000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xE4DDFFE7),
        border: Border.all(color: Color(0xFF16A243)),
        borderRadius: BorderRadius.circular(ProfileConstants.cardBorderRadius),
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
          padding: const EdgeInsets.symmetric(vertical: 20),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return ShipmentsCalendarCard(shipment: transaction);
          },
        ),
      ),
    );
  }
}
