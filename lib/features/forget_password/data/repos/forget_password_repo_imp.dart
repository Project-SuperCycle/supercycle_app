import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supercycle/core/errors/failures.dart';
import 'package:supercycle/core/services/api_endpoints.dart';
import 'package:supercycle/core/services/api_services.dart';
import 'package:supercycle/features/forget_password/data/model/reset_password_model.dart';
import 'package:supercycle/features/forget_password/data/model/verify_reset_otp_model.dart';

import 'forget_password_repo.dart';

class ForgetPasswordRepoImp implements ForgetPasswordRepo {
  final ApiServices apiServices;

  ForgetPasswordRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, String>> resetPassword(
    ResetPasswordModel resetModel,
  ) async {
    // TODO: implement updatePassword
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.resetPassword,
        data: resetModel.toJson(),
      );
      var message = response['message'];
      return right(message);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString(), 500));
    }
  }

  @override
  Future<Either<Failure, String>> verifyResetOtp(
    VerifyResetOtpModel verifyModel,
  ) async {
    // TODO: implement verifySentEmail
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.verifyResetOtp,
        data: verifyModel.toJson(),
      );
      var token = response['resetToken'];
      return right(token);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString(), 500));
    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword(String email) async {
    // TODO: implement sentEmail
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.forgetPassword,
        data: {"email": email},
      );
      var message = response['message'];
      return right(message);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString(), 500));
    }
  }
}
