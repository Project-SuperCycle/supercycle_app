import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/core/errors/failures.dart';
import 'package:supercycle_app/core/services/api_endpoints.dart';
import 'package:supercycle_app/core/services/api_services.dart';
import 'package:supercycle_app/features/trader_shipment_preview/data/repos/trader_shipment_preview_repo.dart';

class TraderShipmentPreviewRepoImp implements TraderShipmentPreviewRepo {
  final ApiServices apiServices;
  TraderShipmentPreviewRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, String>> createShipment({
    required FormData shipment,
  }) async {
    // TODO: implement createShipment
    try {
      final response = await apiServices.postFormData(
        endPoint: ApiEndpoints.createShipment,
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
