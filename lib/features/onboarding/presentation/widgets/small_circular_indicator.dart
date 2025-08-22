import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_colors.dart' show AppColors;

class SmallCircularIndicator extends StatelessWidget {
  const SmallCircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor.withAlpha(100),
      ),
    );
  }
}
