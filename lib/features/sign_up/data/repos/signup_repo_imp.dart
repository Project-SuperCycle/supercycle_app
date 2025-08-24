import 'dart:developer' show log;

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' show DioException;
import 'package:supercycle_app/core/errors/failures.dart';
import 'package:supercycle_app/core/services/api_endpoints.dart' show ApiEndpoints;
import 'package:supercycle_app/core/services/api_services.dart';
import 'package:supercycle_app/core/services/auth_services.dart' show AuthService;
import 'package:supercycle_app/core/services/services_locator.dart' show getIt;
import 'package:supercycle_app/features/sign_up/data/models/business_information_model.dart';
import 'package:supercycle_app/features/sign_up/data/models/otp_verification_model.dart';
import 'package:supercycle_app/features/sign_up/data/models/signup_credentials_model.dart';
import 'package:supercycle_app/core/models/social_auth_request_model.dart' show SocialAuthRequestModel;
import 'package:supercycle_app/core/models/social_auth_response_model.dart' show SocialAuthResponseModel;
import 'package:supercycle_app/features/sign_up/data/repos/signup_repo.dart'
    show SignUpRepo;

class SignUpRepoImp implements SignUpRepo {
  final ApiServices apiServices;
  SignUpRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, String>> initiateSignup({
    required SignupCredentialsModel credentials,
  }) async {
    // TODO: implement initiateSignup
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.signup,
        data: credentials.toJson(),
      );
      var message = response['message'];
      return right(message);
    } catch (e) {
      if (e is DioException) {
        log(e.toString());
        return left(ServerFailure.fromDioError(e));
      }
      log(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp({
    required OtpVerificationModel credentials,
  }) async {
    // TODO: implement verifyOtp
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.verifyOtp,
        data: credentials.toJson(),
      );
      var message = response['message'];
      var token = response['token'];
      getIt<AuthService>().setToken(token);
      return right(message);
    } catch (e) {
      if (e is DioException) {
        log(e.toString());
        return left(ServerFailure.fromDioError(e));
      }
      log(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> completeSignup({
    required BusinessInformationModel businessInfo,
  }) async {
    // TODO: implement userSignin
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.completeSignup,
        data: businessInfo.toJson(),
      );
      var message = response['message'];
      return right(message);
    } catch (e) {
      if (e is DioException) {
        log(e.response.toString());
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
