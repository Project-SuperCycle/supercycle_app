import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:supercycle/core/constants.dart';
import 'package:supercycle/core/errors/failures.dart';
import 'package:supercycle/core/services/api_endpoints.dart';
import 'package:supercycle/core/services/api_services.dart';
import 'package:supercycle/core/services/auth_manager_services.dart';
import 'package:supercycle/core/services/social_auth_services.dart';
import 'package:supercycle/core/services/storage_services.dart';
import 'package:supercycle/features/sign_in/data/models/logined_user_model.dart';
import 'package:supercycle/features/sign_in/data/models/signin_credentials_model.dart';
import 'package:supercycle/features/sign_in/data/repos/signin_repo.dart';

class SignInRepoImp implements SignInRepo {
  final ApiServices apiServices;
  final AuthManager _authManager = AuthManager();

  SignInRepoImp({required this.apiServices});

  /// تسجيل الدخول بالبريد الإلكتروني وكلمة المرور
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

      // ======= التحقق من البيانات =======
      if (data == null) {
        return left(ServerFailure('Invalid response: Missing user data', 422));
      }

      // ======= معالجة حالات الأخطاء =======
      if (token == null) {
        if (response['Code'] == kNotVerified) {
          return left(ServerFailure.fromResponse(403, response));
        }
      } else {
        if (response['Code'] == kProfileIncomplete) {
          return left(ServerFailure(response['message'], 200));
        }
      }

      // ======= تسجيل الدخول الناجح =======
      LoginedUserModel loginUser = LoginedUserModel.fromJson(data);

      // حفظ البيانات
      await _saveUserData(loginUser, token);

      Logger().i('✅ Email login successful: ${loginUser.displayName}');

      return right(loginUser);
    } on DioException catch (dioError) {
      Logger().e('❌ DioException during email login: ${dioError.message}');
      return left(ServerFailure.fromDioError(dioError));
    } on FormatException catch (formatError) {
      Logger().e('❌ FormatException during email login: $formatError');
      return left(ServerFailure(formatError.toString(), 422));
    } on TypeError catch (typeError) {
      Logger().e('❌ TypeError during email login: $typeError');
      return left(
        ServerFailure('Data parsing error: ${typeError.toString()}', 422),
      );
    } catch (e) {
      Logger().e('❌ Unexpected error during email login: $e');
      return left(
        ServerFailure('Unexpected error occurred: ${e.toString()}', 520),
      );
    }
  }

  /// تسجيل الدخول عبر Google
  @override
  Future<Either<Failure, LoginedUserModel>> signInWithGoogle() async {
    try {
      // 1. الحصول على access token من Google
      final String accessToken = await SocialAuthService.signInWithGoogle();

      // 2. إرسال الـ token للـ backend
      final response = await apiServices.post(
        endPoint: ApiEndpoints.socialLogin, // تأكد من endpoint صحيح
        data: {'accessToken': accessToken},
      );

      Logger().i(response);

      var data = response['data'];
      var token = response['token'];

      if (data == null || token == null) {
        return left(ServerFailure('Invalid response from server', 422));
      }

      // 3. معالجة الاستجابة وحفظ البيانات
      LoginedUserModel loginUser = LoginedUserModel.fromJson(data);

      await _saveUserData(loginUser, token);

      Logger().i('✅ Google login successful: ${loginUser.displayName}');

      return right(loginUser);
    } catch (e) {
      Logger().e('❌ Google login error: $e');

      if (e.toString().contains('Google Sign In failed')) {
        return left(ServerFailure('تم إلغاء تسجيل الدخول بـ Google', 400));
      }

      return left(ServerFailure('حدث خطأ أثناء تسجيل الدخول بـ Google', 520));
    }
  }

  /// تسجيل الدخول عبر Facebook
  @override
  Future<Either<Failure, LoginedUserModel>> signInWithFacebook() async {
    try {
      // 1. الحصول على access token من Facebook
      final String accessToken = await SocialAuthService.signInWithFacebook();

      // 2. إرسال الـ token للـ backend
      final response = await apiServices.post(
        endPoint: ApiEndpoints.socialLogin, // تأكد من endpoint صحيح
        data: {'accessToken': accessToken},
      );

      Logger().i(response);

      var data = response['data'];
      var token = response['token'];

      if (data == null || token == null) {
        return left(ServerFailure('Invalid response from server', 422));
      }

      // 3. معالجة الاستجابة وحفظ البيانات
      LoginedUserModel loginUser = LoginedUserModel.fromJson(data);

      await _saveUserData(loginUser, token);

      Logger().i('✅ Facebook login successful: ${loginUser.displayName}');

      return right(loginUser);
    } catch (e) {
      Logger().e('❌ Facebook login error: $e');

      return left(ServerFailure('حدث خطأ أثناء تسجيل الدخول بـ Facebook', 520));
    }
  }

  /// حفظ بيانات المستخدم وتحديث حالة المصادقة
  Future<void> _saveUserData(LoginedUserModel user, String token) async {
    // 1. حفظ في Storage
    await StorageServices.storeData('user', user.toJson());
    await StorageServices.storeData('token', token);

    // 2. تحديث حالة المصادقة في AuthManager
    await _authManager.onLoginSuccess();
  }
}
