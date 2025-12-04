import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle/core/routes/end_points.dart';
import 'package:supercycle/core/services/storage_services.dart';
import 'package:supercycle/core/utils/app_assets.dart';
import 'package:supercycle/core/utils/app_colors.dart' show AppColors;
import 'package:supercycle/core/utils/app_styles.dart' show AppStyles;
import 'package:supercycle/features/onboarding/presentation/widgets/partial_circle_border_painter.dart';

import 'package:supercycle/generated/l10n.dart' show S;

class FourthOnboardingViewBody extends StatelessWidget {
  const FourthOnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                  ).copyWith(color: AppColors.primaryColor),
                ),
                onPressed: () {
                  StorageServices.storeData("isUser", "true");
                  GoRouter.of(context).pushReplacement(EndPoints.homeView);
                },
              ),
            ),
          ),
          Text(
            "فلوس",
            style: AppStyles.styleBold24(
              context,
            ).copyWith(fontSize: 36, color: AppColors.primaryColor),
          ),
          SizedBox(height: 30),
          Flexible(
            fit: FlexFit.tight,
            child: Image.asset(AppAssets.onboarding4, fit: BoxFit.cover),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "استلم فلوسك بعد البيع للمصنع مباشرة بكل سهولة",
              style: AppStyles.styleSemiBold18(
                context,
              ).copyWith(color: AppColors.primaryColor, height: 1.6),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 30),
          CustomPaint(
            painter: PartialCircleBorderPainter(
              color: AppColors.primaryColor,
              strokeWidth: 4,
              percentage: 1.0, // 25% of the circle
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () {
                  GoRouter.of(context).pushReplacement(EndPoints.homeView);
                },
                child: Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 50),
        ],
      ),
    );
  }
}
