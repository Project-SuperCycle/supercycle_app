import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' show DioException;
import 'package:logger/logger.dart';
import 'package:supercycle/core/constants.dart';
import 'package:supercycle/core/errors/failures.dart';
import 'package:supercycle/core/services/api_endpoints.dart' show ApiEndpoints;
import 'package:supercycle/core/services/api_services.dart' show ApiServices;
import 'package:supercycle/core/services/storage_services.dart';
import 'package:supercycle/features/sign_in/data/models/logined_user_model.dart';
import 'package:supercycle/features/sign_in/data/models/signin_credentials_model.dart';
import 'package:supercycle/features/sign_in/data/repos/signin_repo.dart';

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
      Logger().i(response);
      var data = response['data'];
      var token = response['token'];

      if (data == null) {
        return left(
          ServerFailure(
            'Invalid response: Missing user data',
            422, // Unprocessable Entity
          ),
        );
      }

      if (token == null) {
        if (response['Code'] == kNotVerified) {
          return left(ServerFailure.fromResponse(403, response));
        }
      } else {
        if (response['Code'] == kProfileIncomplete) {
          return left(ServerFailure(response['message'], 200));
        }
      }

      LoginedUserModel loginUser = LoginedUserModel.fromJson(data);

      StorageServices.storeData('user', loginUser.toJson());
      StorageServices.storeData('token', token);
      return right(loginUser);
    } on DioException catch (dioError) {
      return left(ServerFailure.fromDioError(dioError));
    } on FormatException catch (formatError) {
      return left(ServerFailure(formatError.toString(), 422));
    } on TypeError catch (typeError) {
      return left(
        ServerFailure(
          'Data parsing error: ${typeError.toString()}',
          422, // Unprocessable Entity
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          'Unexpected error occurred: ${e.toString()}',
          520, // Unknown Error
        ),
      );
    }
  }
}
