import 'package:dartz/dartz.dart';
import 'package:supercycle_app/core/errors/failures.dart';
import 'package:supercycle_app/core/models/single_shipment_model.dart';
import 'package:supercycle_app/features/shipments_calendar/data/models/shipment_model.dart';

abstract class ShipmentsCalendarRepo {
  Future<Either<Failure, List<ShipmentModel>>> getAllShipments();

  Future<Either<Failure, List<ShipmentModel>>> getAllRepShipments();

  Future<Either<Failure, SingleShipmentModel>> getShipmentById({
    required String shipmentId,
  });
}
