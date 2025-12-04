import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class SocialAuthService {
  static final Logger _logger = Logger();

  /// تسجيل الدخول باستخدام Google
  static Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );

      await googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        _logger.w('تم إلغاء تسجيل الدخول بواسطة المستخدم');
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      _logger.i('Google Sign In Success: ${googleUser.email}');
      return googleAuth.accessToken;
    } catch (e) {
      _logger.e('خطأ في تسجيل الدخول بـ Google: $e');
      throw Exception('فشل تسجيل الدخول بـ Google: $e');
    }
  }

  /// تسجيل الدخول باستخدام Facebook
  static Future<String?> signInWithFacebook() async {
    try {
      await FacebookAuth.instance.logOut();

      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
        loginBehavior: LoginBehavior.dialogOnly,
      );

      switch (result.status) {
        case LoginStatus.success:
          final AccessToken? accessToken = result.accessToken;

          if (accessToken == null || accessToken.tokenString.isEmpty) {
            _logger.e('Access Token is null or empty');
            throw Exception('فشل الحصول على Access Token');
          }

          _logger.i('✅ Facebook Sign In Success');
          _logger.i('Token Type: ${accessToken.type}');

          // الحصول على بيانات المستخدم
          try {
            final userData = await FacebookAuth.instance.getUserData(
              fields: "name,email,picture.width(200)",
            );

            _logger.i('User Name: ${userData['name'] ?? 'No Name'}');
            _logger.i('User Email: ${userData['email'] ?? 'No Email'}');
            _logger.i('User ID: ${userData['id'] ?? 'No ID'}');
          } catch (e) {
            _logger.w('تحذير في الحصول على بيانات المستخدم: $e');
          }

          return accessToken.tokenString;

        case LoginStatus.cancelled:
          _logger.w('تم إلغاء تسجيل الدخول بواسطة المستخدم');
          return null;

        case LoginStatus.failed:
          _logger.e('فشل تسجيل الدخول: ${result.message}');
          throw Exception('فشل تسجيل الدخول بـ Facebook: ${result.message}');

        case LoginStatus.operationInProgress:
          _logger.w('عملية تسجيل الدخول قيد التنفيذ');
          throw Exception('عملية تسجيل الدخول قيد التنفيذ بالفعل');

        default:
          _logger.e('حالة غير معروفة في تسجيل الدخول');
          throw Exception('حالة غير معروفة في تسجيل الدخول');
      }
    } catch (e) {
      _logger.e('خطأ في تسجيل الدخول بـ Facebook: $e');
      rethrow;
    }
  }

  /// تسجيل الخروج من Google
  static Future<void> signOutGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      _logger.i('تم تسجيل الخروج من Google بنجاح');
    } catch (e) {
      _logger.e('خطأ في تسجيل الخروج من Google: $e');
    }
  }

  /// تسجيل الخروج من Facebook
  static Future<void> signOutFacebook() async {
    try {
      await FacebookAuth.instance.logOut();
      _logger.i('تم تسجيل الخروج من Facebook بنجاح');
    } catch (e) {
      _logger.e('خطأ في تسجيل الخروج من Facebook: $e');
    }
  }

  /// تسجيل الخروج من جميع المنصات
  static Future<void> signOutAll() async {
    await Future.wait([
      signOutGoogle(),
      signOutFacebook(),
    ]);
    _logger.i('تم تسجيل الخروج من جميع المنصات');
  }

  /// التحقق من حالة تسجيل الدخول في Facebook
  static Future<bool> isFacebookLoggedIn() async {
    try {
      final accessToken = await FacebookAuth.instance.accessToken;
      return accessToken != null;
    } catch (e) {
      _logger.e('خطأ في التحقق من حالة Facebook: $e');
      return false;
    }
  }

  /// التحقق من حالة تسجيل الدخول في Google
  static Future<bool> isGoogleLoggedIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final currentUser = await googleSignIn.signInSilently();
      return currentUser != null;
    } catch (e) {
      _logger.e('خطأ في التحقق من حالة Google: $e');
      return false;
    }
  }

  /// الحصول على بيانات المستخدم من Facebook
  static Future<Map<String, dynamic>?> getFacebookUserData() async {
    try {
      final isLoggedIn = await isFacebookLoggedIn();

      if (!isLoggedIn) {
        _logger.w('المستخدم غير مسجل الدخول في Facebook');
        return null;
      }

      final userData = await FacebookAuth.instance.getUserData(
        fields: "id,name,email,picture.width(400)",
      );

      _logger.i('تم الحصول على بيانات المستخدم من Facebook');
      return userData;
    } catch (e) {
      _logger.e('خطأ في الحصول على بيانات المستخدم من Facebook: $e');
      return null;
    }
  }

  /// الحصول على Access Token الحالي من Facebook
  static Future<String?> getCurrentFacebookToken() async {
    try {
      final accessToken = await FacebookAuth.instance.accessToken;

      if (accessToken == null) {
        _logger.w('لا يوجد Facebook Token');
        return null;
      }

      return accessToken.tokenString;
    } catch (e) {
      _logger.e('خطأ في الحصول على Facebook Token: $e');
      return null;
    }
  }
}