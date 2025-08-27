import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:supercycle_app/core/services/storage_services.dart';
import 'package:supercycle_app/core/utils/app_assets.dart' show AppAssets;
import 'package:supercycle_app/features/sign_in/data/models/logined_user_model.dart';

class HomeHeaderNavActions extends StatefulWidget {
  const HomeHeaderNavActions({super.key, required this.onDrawerPressed});
  final VoidCallback onDrawerPressed;

  @override
  State<HomeHeaderNavActions> createState() => _HomeHeaderNavActionsState();
}

class _HomeHeaderNavActionsState extends State<HomeHeaderNavActions> {
  bool isUserLoggedIn = false;

  void _onNotificationPressed() {}

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    LoginedUserModel? user = await StorageServices.getUserData();
    setState(() {
      isUserLoggedIn = (user != null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.onDrawerPressed,
          child: SvgPicture.asset(AppAssets.drawerIcon, fit: BoxFit.cover),
        ),
        const SizedBox(height: 24),
        isUserLoggedIn
            ? GestureDetector(
                onTap: _onNotificationPressed,
                child: SvgPicture.asset(
                  AppAssets.notificationIcon,
                  fit: BoxFit.cover,
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
