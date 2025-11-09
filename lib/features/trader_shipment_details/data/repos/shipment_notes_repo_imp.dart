import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/core/errors/failures.dart';
import 'package:supercycle_app/core/services/api_endpoints.dart';
import 'package:supercycle_app/core/services/api_services.dart';
import 'package:supercycle_app/core/models/create_notes_model.dart';
import 'package:supercycle_app/features/trader_shipment_details/data/repos/shipment_notes_repo.dart';

class ShipmentNotesRepoImp implements ShipmentNotesRepo {
  final ApiServices apiServices;
  ShipmentNotesRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, String>> addNotes({
    required CreateNotesModel notes,
    required String shipmentId,
  }) async {
    // TODO: implement addNotes
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.addNotes.replaceFirst('{id}', shipmentId),
        data: notes.toJson(),
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
  Future<Either<Failure, List<String>>> getAllNotes({
    required String shipmentId,
  }) async {
    // TODO: implement getAllNotes
    try {
      final response = await apiServices.get(
        endPoint: ApiEndpoints.getAllNotes.replaceFirst('{id}', shipmentId),
      );
      var data = response["data"];
      List<String> notes = [];
      for (var note in data) {
        notes.add(note["content"]);
      }
      return right(notes);
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
