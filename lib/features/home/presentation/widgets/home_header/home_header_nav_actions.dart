import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supercycle_app/core/utils/app_assets.dart' show AppAssets;

class HomeHeaderNavActions extends StatelessWidget {
  final VoidCallback onDrawerPressed;
  final VoidCallback onNotificationPressed;

  const HomeHeaderNavActions({
    super.key,
    required this.onDrawerPressed,
    required this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onDrawerPressed,
          child: SvgPicture.asset(AppAssets.drawerIcon, fit: BoxFit.cover),
        ),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: onNotificationPressed,
          child: SvgPicture.asset(
            AppAssets.notificationIcon,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
