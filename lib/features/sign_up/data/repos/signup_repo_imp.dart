import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' show DioException;
import 'package:supercycle_app/core/errors/failures.dart';
import 'package:supercycle_app/core/services/api_endpoints.dart'
    show ApiEndpoints;
import 'package:supercycle_app/core/services/api_services.dart';
import 'package:supercycle_app/core/services/storage_services.dart';
import 'package:supercycle_app/features/sign_up/data/models/business_information_model.dart';
import 'package:supercycle_app/features/sign_up/data/models/otp_verification_model.dart';
import 'package:supercycle_app/features/sign_up/data/models/signup_credentials_model.dart';
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
      StorageServices.storeData('token', token);
      return right(message);
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
