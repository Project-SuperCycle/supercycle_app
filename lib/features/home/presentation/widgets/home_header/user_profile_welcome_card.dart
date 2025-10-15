import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/services/storage_services.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_styles.dart' show AppStyles;
import 'package:supercycle_app/features/sign_in/data/models/logined_user_model.dart';
import 'package:supercycle_app/generated/l10n.dart' show S;

class UserProfileWelcomeCard extends StatefulWidget {
  const UserProfileWelcomeCard({super.key});

  @override
  State<UserProfileWelcomeCard> createState() => _UserProfileWelcomeCardState();
}

class _UserProfileWelcomeCardState extends State<UserProfileWelcomeCard> {
  late String managerName = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    LoginedUserModel? user = await StorageServices.getUserData();
    setState(() {
      managerName = (user != null) ? user.doshMangerName : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      textDirection: TextDirection.ltr,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 32,
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).push(EndPoints.traderProfileView);
              },
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
        const SizedBox(width: 12),
        Column(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).welcome,
              style: AppStyles.styleMedium14(context).copyWith(
                color: const Color(0xFFD1FAE5),
              ),
            ),
<<<<<<< Updated upstream
            const SizedBox(height: 5),
            Text(
              managerName,
              textDirection: TextDirection.ltr,
              style: AppStyles.styleSemiBold16(context),
=======
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push(EndPoints.traderProfileView);
              },
              child: Text(
                managerName,
                textDirection: TextDirection.ltr,
                style: AppStyles.styleBold18(context).copyWith(
                  color: Colors.white,
                ),
              ),
>>>>>>> Stashed changes
            ),
          ],
        ),
      ],
    );
  }
}