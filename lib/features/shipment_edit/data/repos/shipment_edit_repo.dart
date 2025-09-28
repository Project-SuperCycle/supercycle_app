import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supercycle_app/core/errors/failures.dart';

abstract class ShipmentEditRepo {
  Future<Either<Failure, String>> editShipment({
    required FormData shipment,
    required String id,
  });
}
