import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_assets.dart' show AppAssets;

class ProfileHeaderLogo extends StatelessWidget {
  const ProfileHeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(AppAssets.logoName, fit: BoxFit.contain, scale: 6.0),
        SizedBox(width: 5),
        Image.asset(AppAssets.logoIcon, fit: BoxFit.contain, scale: 7.5),
      ],
    );
  }
}
