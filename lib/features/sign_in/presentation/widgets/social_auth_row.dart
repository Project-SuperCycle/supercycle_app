import 'dart:convert' show base64Url, utf8, json;
import 'package:firebase_auth/firebase_auth.dart' show UserCredential, FirebaseAuth, OAuthCredential, FacebookAuthProvider, GoogleAuthProvider;import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' show LoginResult, FacebookAuth;
import 'package:google_sign_in/google_sign_in.dart' show GoogleSignInAccount, GoogleSignInAuthentication, GoogleSignIn;
import 'package:logger/logger.dart' show Logger;
import 'package:supercycle_app/core/utils/app_assets.dart';

class SocialAuthRow extends StatelessWidget {
  const SocialAuthRow({
    super.key,
    required this.handleGoogleAuth,
    required this.handleFacebookAuth,
  });
  final VoidCallback handleGoogleAuth;
  final VoidCallback handleFacebookAuth;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn.instance.initialize(clientId:
      '855015056699-o21tck1692lvdu6s5nfmgqr7m78b6tnf.apps.googleusercontent.com',
    ).then((value) => GoogleSignIn.instance.authenticate());

    if (googleUser == null) {
      return Future.error('Google Sign In failed');
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    Logger().i("Google Auth Token: ${googleAuth.idToken}");
    decodeToken(googleAuth.idToken!);

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    final user = await FirebaseAuth.instance.signInWithCredential(credential);

    final idToken = await user.user?.getIdToken();

    Logger().i("Id Token: $idToken");
    // Once signed in, return the UserCredential
    return user;
    }

  static Map<String, dynamic> decodeToken(String token) {
    final parts = token.split('.');

    if (parts.length != 3) {
      throw Exception('Invalid JWT token');
    }

    // فك تشفير الـ payload (الجزء الثاني)
    final payload = parts[1];

    // إضافة padding إذا لزم الأمر
    var normalizedPayload = payload;
    while (normalizedPayload.length % 4 != 0) {
      normalizedPayload += '=';
    }

    // فك التشفير من Base64
    final decodedBytes = base64Url.decode(normalizedPayload);
    final decodedString = utf8.decode(decodedBytes);

    // تحويل إلى JSON
    Logger().i(json.decode(decodedString));
    return json.decode(decodedString);
  }


  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    Logger().i("FACEBOOK TOKEN -> ${loginResult.accessToken!.tokenString}");

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: signInWithGoogle,
          child: Image.asset(AppAssets.googleIcon, scale: 3.5),
        ),
        SizedBox(width: 30),
        GestureDetector(
          onTap: signInWithFacebook,
          child: Image.asset(AppAssets.facebookIcon, scale: 3.5),
        ),
      ],
    );
  }
}
