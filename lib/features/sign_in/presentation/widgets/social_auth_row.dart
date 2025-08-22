import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';

class SocialAuthRow extends StatelessWidget {
  const SocialAuthRow({
    super.key,
    required this.handleGoogleAuth,
    required this.handleFacebookAuth,
  });
  final VoidCallback handleGoogleAuth;
  final VoidCallback handleFacebookAuth;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: handleGoogleAuth,
          child: Image.asset(AppAssets.googleIcon, scale: 3.5),
        ),
        SizedBox(width: 30),
        GestureDetector(
          onTap: handleFacebookAuth,
          child: Image.asset(AppAssets.facebookIcon, scale: 3.5),
        ),
      ],
    );
  }
}
