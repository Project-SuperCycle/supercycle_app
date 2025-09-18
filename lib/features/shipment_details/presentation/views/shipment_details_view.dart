import 'package:flutter/material.dart';
import 'package:supercycle_app/features/shipment_details/data/models/shipment_model.dart';
import 'package:supercycle_app/features/shipment_details/presentation/widgets/shipment_details_view_body.dart';

class ShipmentDetailsView extends StatelessWidget {
  const ShipmentDetailsView({super.key, required this.shipment});
  final ShipmentModel shipment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ShipmentDetailsViewBody(shipment: shipment));
  }
}
