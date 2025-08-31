import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' show DioException;
import 'package:supercycle_app/core/errors/failures.dart';
import 'package:supercycle_app/core/services/api_endpoints.dart';
import 'package:supercycle_app/core/services/api_services.dart'
    show ApiServices;
import 'package:supercycle_app/features/home/data/models/dosh_data_model.dart';
import 'package:supercycle_app/features/home/data/models/dosh_type_model.dart';
import 'package:supercycle_app/features/home/data/models/type_history_model.dart';
import 'package:supercycle_app/features/home/data/repos/home_repo.dart';

class HomeRepoImp implements HomeRepo {
  final ApiServices apiServices;
  HomeRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, List<DoshTypeModel>>> fetchDoshTypes() async {
    // TODO: implement fetchDoshTypes
    try {
      final response = await apiServices.get(
        endPoint: ApiEndpoints.doshPricesCurrent,
      );
      var data = response["data"];
      List<DoshTypeModel> types = [];
      for (var type in data) {
        types.add(DoshTypeModel.fromJson(type));
      }
      return right(types);
    } on DioException catch (dioError) {
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
  Future<Either<Failure, List<TypeHistoryModel>>> fetchTypeHistory({
    required String typeId,
  }) async {
    // TODO: implement fetchTypeHistory
    try {
      final response = await apiServices.get(
        endPoint: ApiEndpoints.doshPricesHistory,
        query: {"typeId": typeId},
      );

      var data = response['data']["history"];
      List<TypeHistoryModel> history = [];
      for (var month in data) {
        history.add(TypeHistoryModel.fromJson(month));
      }

      return right(history);
    } on DioException catch (dioError) {
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
  Future<Either<Failure, List<DoshDataModel>>> fetchTypesData() async {
    // TODO: implement fetchTypesData
    try {
      final response = await apiServices.get(
        endPoint: ApiEndpoints.doshTypesData,
      );

      var data = response['data'];
      List<DoshDataModel> typesData = [];
      for (var type in data) {
        typesData.add(DoshDataModel.fromJson(type));
      }

      return right(typesData);
    } on DioException catch (dioError) {
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
