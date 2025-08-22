import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' show DioException;
import 'package:supercycle_app/core/errors/failures.dart';
import 'package:supercycle_app/core/services/api_endpoints.dart' show ApiEndpoints;
import 'package:supercycle_app/core/services/api_services.dart' show ApiServices;
import 'package:supercycle_app/core/services/auth_services.dart';
import 'package:supercycle_app/core/services/services_locator.dart' show getIt;
import 'package:supercycle_app/features/sign_in/data/models/logined_user_model.dart';
import 'package:supercycle_app/features/sign_in/data/models/signin_credentials_model.dart';
import 'package:supercycle_app/features/sign_in/data/repos/signin_repo.dart';

class SignInRepoImp implements SignInRepo {
  final ApiServices apiServices;
  SignInRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, String>> facebookSignin({
    required SigninCredentialsModel credentials,
  }) {
    // TODO: implement facebookSignin
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> googleSignin({
    required SigninCredentialsModel credentials,
  }) {
    // TODO: implement googleSignin
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LoginedUserModel>> userSignin({
    required SigninCredentialsModel credentials,
  }) async {
    // TODO: implement userSignin
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.login,
        data: credentials.toJson(),
      );
      var data = response['data'];
      var token = response['token'];
      getIt<AuthService>().setToken(token);
      LoginedUserModel loginUser = LoginedUserModel.fromJson(data);
      return right(loginUser);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
