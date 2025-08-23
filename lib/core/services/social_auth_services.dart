import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class SocialAuthService {
 static Future<String> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    if (googleAuth == null) {
      return Future.error('Google Sign In failed');
    }

    final String accessToken = googleAuth.accessToken!;
    return accessToken;
  }

 static Future<String> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final String accessToken = loginResult.accessToken!.tokenString;
    return accessToken;
  }

}
