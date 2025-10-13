import 'package:flutter/material.dart';
import 'package:supercycle_app/core/models/single_shipment_model.dart';
import 'package:supercycle_app/features/representative_shipment_rejected/presentation/widgets/representative_shipment_rejected_body.dart';

class RepresentativeShipmentRejectedView extends StatelessWidget {
  final SingleShipmentModel shipment;
  const RepresentativeShipmentRejectedView({super.key, required this.shipment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepresentativeShipmentRejectedBody(shipment: shipment),
    );
  }
}
