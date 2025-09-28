import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supercycle_app/core/errors/failures.dart';

abstract class ShipmentReviewRepo {
  Future<Either<Failure, String>> createShipment({required FormData shipment});
}
