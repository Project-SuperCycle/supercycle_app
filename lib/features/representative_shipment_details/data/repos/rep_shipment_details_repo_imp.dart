import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/core/errors/failures.dart';
import 'package:supercycle_app/core/services/api_endpoints.dart';
import 'package:supercycle_app/core/services/api_services.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/models/accept_shipment_model.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/models/reject_shipment_model.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/models/update_shipment_model.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/repos/rep_shipment_details_repo.dart';

class RepShipmentDetailsRepoImp implements RepShipmentDetailsRepo {
  final ApiServices apiServices;
  RepShipmentDetailsRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, String>> acceptShipment({
    required AcceptShipmentModel acceptModel,
  }) async {
    // TODO: implement acceptShipment
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.acceptRepShipment.replaceFirst(
          '{id}',
          acceptModel.shipmentID,
        ),
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
  Future<Either<Failure, String>> rejectShipment({
    required RejectShipmentModel rejectModel,
  }) async {
    // TODO: implement rejectShipment
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.rejectRepShipment.replaceFirst(
          '{id}',
          rejectModel.shipmentID,
        ),
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
    required UpdateShipmentModel updateModel,
  }) async {
    // TODO: implement updateShipment
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.updateRepShipment.replaceFirst(
          '{id}',
          updateModel.shipmentID,
        ),
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
}
