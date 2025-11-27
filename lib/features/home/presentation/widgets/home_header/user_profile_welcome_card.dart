import 'package:flutter/material.dart';
import 'package:supercycle/core/functions/navigate_to_profile.dart';
import 'package:supercycle/core/services/storage_services.dart';
import 'package:supercycle/core/utils/app_assets.dart';
import 'package:supercycle/core/utils/app_styles.dart' show AppStyles;
import 'package:supercycle/features/sign_in/data/models/logined_user_model.dart';
import 'package:supercycle/generated/l10n.dart' show S;

class UserProfileWelcomeCard extends StatefulWidget {
  const UserProfileWelcomeCard({super.key});

  @override
  State<UserProfileWelcomeCard> createState() => _UserProfileWelcomeCardState();
}

class _UserProfileWelcomeCardState extends State<UserProfileWelcomeCard> {
  late String userName = '';
  late String userRole = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    LoginedUserModel? user = await StorageServices.getUserData();
    setState(() {
      if (user != null) {
        if (user.doshMangerName != null) {
          userName = user.doshMangerName!;
          userRole = user.role!;
        } else {
          userName = user.displayName!;
          userRole = user.role!;
        }
      } else {
        userName = '';
        userRole = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      textDirection: TextDirection.ltr,
      children: [
        Column(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              S.of(context).welcome,
              style: AppStyles.styleMedium14(
                context,
              ).copyWith(color: const Color(0xFFD1FAE5)),
            ),
            const SizedBox(height: 4),
            Text(
              userName,
              textDirection: TextDirection.ltr,
              style: AppStyles.styleBold18(
                context,
              ).copyWith(color: Colors.white),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withAlpha(150), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(25),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 32,
            child: GestureDetector(
              onTap: () => navigateToProfile(context),
              child: ClipOval(
                child: Image.asset(
                  AppAssets.defaultAvatar,
                  height: 64,
                  width: 64,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
