import 'package:flutter/material.dart';
import 'package:supercycle/core/utils/app_colors.dart';
import 'package:supercycle/core/utils/app_styles.dart';

class SegmentCardHeader extends StatelessWidget {
  final String driverName;
  final String phoneNumber;
  final VoidCallback? onInfoPressed;
  const SegmentCardHeader({
    super.key,
    required this.driverName,
    required this.phoneNumber,
    this.onInfoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Info button
          Container(
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
              color: Color(0xFFD32F2F),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 25,
              ),
              onPressed: onInfoPressed,
              padding: EdgeInsets.zero,
            ),
          ),

          // Driver info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  driverName,
                  style: AppStyles.styleBold20(
                    context,
                  ).copyWith(color: Colors.white),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      phoneNumber,
                      style: AppStyles.styleMedium14(context),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(width: 10),
                    // Call button
                    const Icon(
                      Icons.phone_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
