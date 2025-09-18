import 'package:dartz/dartz.dart';
import 'package:supercycle_app/core/errors/failures.dart';
import 'package:supercycle_app/features/shipment_details/data/models/shipment_model.dart';

abstract class ShipmentsCalendarRepo {
  Future<Either<Failure, List<ShipmentModel>>> getAllShipments();

  Future<Either<Failure, ShipmentModel>> getShipmentById({
    required String shipmentId,
  });
}
