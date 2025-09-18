import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/core/errors/failures.dart';
import 'package:supercycle_app/core/services/api_endpoints.dart';
import 'package:supercycle_app/core/services/api_services.dart';
import 'package:supercycle_app/features/shipment_details/data/models/create_notes_model.dart';
import 'package:supercycle_app/features/shipment_details/data/models/notes_model.dart';
import 'package:supercycle_app/features/shipment_details/data/repos/shipment_details_repo.dart';

class ShipmentDetailsRepoImp implements ShipmentDetailsRepo {
  final ApiServices apiServices;
  ShipmentDetailsRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, String>> cancelShipment({
    required String shipmentId,
  }) async {
    // TODO: implement cancelShipment
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.cancelShipment.replaceFirst('{id}', shipmentId),
        data: {},
      );
      String message = response["message"];
      return right(message);
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
  Future<Either<Failure, String>> updateShipment({
    required FormData shipment,
    required String shipmentId,
  }) async {
    // TODO: implement updateShipment
    try {
      final response = await apiServices.postFormData(
        endPoint: ApiEndpoints.updateShipment.replaceFirst('{id}', shipmentId),
        data: shipment,
      );
      String message = response["message"];
      return right(message);
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
