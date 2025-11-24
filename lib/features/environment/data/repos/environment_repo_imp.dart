import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supercycle/core/errors/failures.dart';
import 'package:supercycle/core/services/api_endpoints.dart';
import 'package:supercycle/core/services/api_services.dart';
import 'package:supercycle/features/environment/data/models/trader_eco_info_model.dart';
import 'package:supercycle/features/environment/data/repos/environment_repo.dart';

class EnvironmentRepoImp implements EnvironmentRepo {
  final ApiServices apiServices;

  EnvironmentRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, TraderEcoInfoModel>> getTraderEcoInfo() async {
    // TODO: implement getTraderEcoInfo
    try {
      final response = await apiServices.get(
        endPoint: ApiEndpoints.getTraderEcoInfo,
      );
      var data = response["data"];
      TraderEcoInfoModel traderEcoInfoModel = TraderEcoInfoModel.fromJson(data);

      return right(traderEcoInfoModel);
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
