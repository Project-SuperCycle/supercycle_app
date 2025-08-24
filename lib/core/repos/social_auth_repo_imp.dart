import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' show DioException;
import 'package:logger/logger.dart';
import 'package:supercycle_app/core/errors/failures.dart';
import 'package:supercycle_app/core/repos/social_auth_repo.dart';
import 'package:supercycle_app/core/services/api_endpoints.dart' show ApiEndpoints;
import 'package:supercycle_app/core/services/api_services.dart';
import 'package:supercycle_app/core/models/social_auth_request_model.dart' show SocialAuthRequestModel;
import 'package:supercycle_app/core/models/social_auth_response_model.dart' show SocialAuthResponseModel;

import '../services/auth_services.dart';
import '../services/services_locator.dart';

class SocialAuthRepoImp implements SocialAuthRepo {
  final ApiServices apiServices;
  SocialAuthRepoImp({required this.apiServices});


  @override
  Future<Either<Failure, SocialAuthResponseModel>> socialSignup({
    required SocialAuthRequestModel credentials,
  }) async{
    // TODO: implement googleSignup
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.socialLogin,
        data: credentials.toJson(),
      );

     if (response['status'] == 201){
       SocialAuthResponseModel socialAuth = SocialAuthResponseModel.fromJson({
         "status": response['status'],
         "message": response['message'],
         "token": response['token'],
       });
       getIt<AuthService>().setToken(socialAuth.token);
       return right(socialAuth);
     } else if (response['status'] == 200){
       SocialAuthResponseModel socialAuth = SocialAuthResponseModel.fromJson({
         "status": response['status'],
         "message": response['message'],
         "token": response['token'],
         "user": response['data'],
       });
       getIt<AuthService>().setToken(socialAuth.token);
       getIt<AuthService>().setUser(socialAuth.user!);
        return right(socialAuth);
     }
      SocialAuthResponseModel socialAuth = SocialAuthResponseModel.fromJson({
        "status": response['status'],
        "message": response['message'],
      });

     return  right(socialAuth);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

}
