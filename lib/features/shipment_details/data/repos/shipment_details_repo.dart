import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supercycle_app/core/errors/failures.dart';

abstract class ShipmentDetailsRepo {
  Future<Either<Failure, String>> cancelShipment({required String shipmentId});
}
