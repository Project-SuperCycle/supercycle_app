import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' show DioException;
import 'package:supercycle_app/core/errors/failures.dart';
import 'package:supercycle_app/core/services/api_endpoints.dart'
    show ApiEndpoints;
import 'package:supercycle_app/core/services/api_services.dart'
    show ApiServices;
import 'package:supercycle_app/features/sign_in/data/models/logined_user_model.dart';
import 'package:supercycle_app/features/sign_in/data/models/signin_credentials_model.dart';
import 'package:supercycle_app/features/sign_in/data/repos/signin_repo.dart';

class SignInRepoImp implements SignInRepo {
  final ApiServices apiServices;

  SignInRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, LoginedUserModel>> userSignin({
    required SigninCredentialsModel credentials,
  }) async {
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.login,
        data: credentials.toJson(),
      );

      // التحقق من وجود البيانات المطلوبة
      if (response == null) {
        return left(ServerFailure('No response received from server', 500));
      }

      var data = response['data'];
      var token = response['token'];

      // التحقق من وجود البيانات الأساسية
      if (data == null) {
        return left(
          ServerFailure(
            'Invalid response: Missing user data',
            422, // Unprocessable Entity
          ),
        );
      }

      if (token == null) {
        return left(
          ServerFailure(
            'Invalid response: Missing authentication token',
            422, // Unprocessable Entity
          ),
        );
      }
      LoginedUserModel loginUser = LoginedUserModel.fromJson(data);

      return right(loginUser);
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
