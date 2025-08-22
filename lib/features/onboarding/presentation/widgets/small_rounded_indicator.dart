import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';

class SmallRoundedIndicator extends StatelessWidget {
  const SmallRoundedIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 8,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: AppColors.primaryColor.withAlpha(250),
      ),
    );
  }
}
