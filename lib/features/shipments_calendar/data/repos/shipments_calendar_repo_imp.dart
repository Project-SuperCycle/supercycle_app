import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/core/errors/failures.dart';
import 'package:supercycle_app/core/services/api_endpoints.dart';
import 'package:supercycle_app/core/services/api_services.dart';
import 'package:supercycle_app/features/shipment_details/data/models/shipment_model.dart';
import 'package:supercycle_app/features/shipments_calendar/data/repos/shipments_calendar_repo.dart';

class ShipmentsCalendarRepoImp implements ShipmentsCalendarRepo {
  final ApiServices apiServices;
  ShipmentsCalendarRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, List<ShipmentModel>>> getAllShipments() async {
    // TODO: implement getAllShipments
    try {
      final response = await apiServices.get(
        endPoint: ApiEndpoints.getAllShipments,
      );
      var data = response["data"];
      List<ShipmentModel> shipments = data
          .map((e) => ShipmentModel.fromJson(e))
          .toList();

      return right(shipments);
    } on DioException catch (dioError) {
      Logger().i("DioException ${dioError.toString()}");
      return left(ServerFailure.fromDioError(dioError));
    } on FormatException catch (formatError) {
      return left(
        ServerFailure(
          formatError.toString(),
          422, // Unprocessable Entity
        ),
      );
    } on TypeError catch (typeError) {
      // أخطاء النوع (مثل null safety)
      return left(
        ServerFailure(
          'Data parsing error: ${typeError.toString()}',
          422, // Unprocessable Entity
        ),
      );
    } catch (e) {
      // أي أخطاء أخرى غير متوقعة
      return left(
        ServerFailure(
          'Unexpected error occurred: ${e.toString()}',
          520, // Unknown Error
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ShipmentModel>> getShipmentById({
    required String shipmentId,
  }) async {
    // TODO: implement getShipmentById
    try {
      final response = await apiServices.get(
        endPoint: ApiEndpoints.getShipmentById.replaceFirst('{id}', shipmentId),
      );
      var data = response["data"];
      ShipmentModel shipment = ShipmentModel.fromJson(data);
      return right(shipment);
    } on DioException catch (dioError) {
      Logger().i("DioException ${dioError.toString()}");
      return left(ServerFailure.fromDioError(dioError));
    } on FormatException catch (formatError) {
      return left(
        ServerFailure(
          formatError.toString(),
          422, // Unprocessable Entity
        ),
      );
    } on TypeError catch (typeError) {
      // أخطاء النوع (مثل null safety)
      return left(
        ServerFailure(
          'Data parsing error: ${typeError.toString()}',
          422, // Unprocessable Entity
        ),
      );
    } catch (e) {
      // أي أخطاء أخرى غير متوقعة
      return left(
        ServerFailure(
          'Unexpected error occurred: ${e.toString()}',
          520, // Unknown Error
        ),
      );
    }
  }
}
