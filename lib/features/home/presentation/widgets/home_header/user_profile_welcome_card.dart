import 'package:flutter/material.dart';
import 'package:supercycle_app/core/services/auth_services.dart' show AuthService;
import 'package:supercycle_app/core/services/services_locator.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_styles.dart' show AppStyles;
import 'package:supercycle_app/generated/l10n.dart' show S;

class UserProfileWelcomeCard extends StatelessWidget {
  const UserProfileWelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getIt.get<AuthService>().user;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      textDirection: TextDirection.ltr,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 35,
          child: Center(
            child: Image.asset(
              AppAssets.defaultAvatar,
              height: 66,
              width: 66,
              fit: BoxFit.fill,
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
            Text(
              user == null ? '' : user.doshManagerName,
              textDirection: TextDirection.ltr,
              style: AppStyles.styleSemiBold16(context),
            ),
          ],
        ),
      ],
    );
  }
}
