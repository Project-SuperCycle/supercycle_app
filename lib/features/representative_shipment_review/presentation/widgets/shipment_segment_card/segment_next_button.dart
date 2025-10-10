import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';

class SegmentNextButton extends StatelessWidget {
  final VoidCallback? onNextPressed;

  const SegmentNextButton({super.key, this.onNextPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onNextPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
      child: Text(
        'التالي',
        style: AppStyles.styleBold16(context).copyWith(color: Colors.white),
      ),
    );
  }
}
