import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/core/errors/failures.dart';
import 'package:supercycle_app/core/services/api_endpoints.dart';
import 'package:supercycle_app/core/services/api_services.dart';
import 'package:supercycle_app/features/shipment_edit/data/repos/shipment_edit_repo.dart';

class ShipmentEditRepoImp implements ShipmentEditRepo {
  final ApiServices apiServices;
  ShipmentEditRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, String>> editShipment({
    required FormData shipment,
    required String id,
  }) async {
    // TODO: implement createShipment
    try {
      final response = await apiServices.patchFormData(
        endPoint: ApiEndpoints.editShipment.replaceFirst('{id}', id),
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
