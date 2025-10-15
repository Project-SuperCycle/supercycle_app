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
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 35,
          child: Center(
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).push(EndPoints.representativeProfileView);
              },
              child: Image.asset(
                AppAssets.defaultAvatar,
                height: 66,
                width: 66,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.of(context).welcome,
              style: AppStyles.styleSemiBold16(
                context,
              ).copyWith(color: Colors.white),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push(EndPoints.traderProfileView);
              },
              child: Text(
                managerName,
                textDirection: TextDirection.ltr,
                style: AppStyles.styleSemiBold16(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
