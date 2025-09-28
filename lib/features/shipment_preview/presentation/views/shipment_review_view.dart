import 'package:flutter/material.dart';
import 'package:supercycle_app/features/sales_process/data/models/create_shipment_model.dart';
import 'package:supercycle_app/features/shipment_preview/presentation/widgets/shipment_review_view_body.dart';

class ShipmentReviewView extends StatelessWidget {
  const ShipmentReviewView({super.key, required this.shipment});
  final CreateShipmentModel shipment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ShipmentReviewViewBody(shipment: shipment));
  }
}
