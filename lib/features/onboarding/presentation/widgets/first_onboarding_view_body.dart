import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_colors.dart' show AppColors;
import 'package:supercycle_app/core/utils/app_styles.dart' show AppStyles;
import 'package:supercycle_app/features/onboarding/presentation/widgets/small_circular_indicator.dart'
    show SmallCircularIndicator;
import 'package:supercycle_app/features/onboarding/presentation/widgets/small_rounded_indicator.dart'
    show SmallRoundedIndicator;
import 'package:supercycle_app/generated/l10n.dart' show S;

class FirstOnboardingViewBody extends StatelessWidget {
  const FirstOnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: const BoxDecoration(gradient: kGradientBackground),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: Text(
                  S.of(context).skip,
                  style: AppStyles.styleSemiBold18(
                    context,
                  ).copyWith(color: Colors.white),
                ),
                onPressed: () {
                  GoRouter.of(context).pushReplacement(EndPoints.homeView);
                },
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Image.asset(AppAssets.onboarding1, fit: BoxFit.cover),
          ),
          SizedBox(height: 10),
          Text(
            S.of(context).onboarding_1,
            style: AppStyles.styleSemiBold18(context).copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    SmallRoundedIndicator(),
                    SizedBox(width: 5),
                    SmallCircularIndicator(),
                    SizedBox(width: 5),
                    SmallCircularIndicator(),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    GoRouter.of(
                      context,
                    ).pushReplacement(EndPoints.secondOnboardingView);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
