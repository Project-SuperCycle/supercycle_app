import 'package:flutter/material.dart';
import 'package:supercycle/features/sales_process/data/models/create_shipment_model.dart';
import 'package:supercycle/features/trader_shipment_preview/presentation/widgets/trader_shipment_review_view_body.dart';

class TraderShipmentReviewView extends StatelessWidget {
  const TraderShipmentReviewView({super.key, required this.shipment});
  final CreateShipmentModel shipment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: TraderShipmentReviewViewBody(shipment: shipment));
  }
}
