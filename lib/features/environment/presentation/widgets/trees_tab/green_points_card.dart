import 'package:flutter/material.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';

class GreenPointsCard extends StatelessWidget {
  const GreenPointsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: kGradientContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2,450',
                    style: AppStyles.styleSemiBold24(context).copyWith(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'نقطة خضراء',
                    style: AppStyles.styleSemiBold14(
                      context,
                    ).copyWith(color: Color(0xFFD1FAE5)),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.park, color: Colors.white, size: 24),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'تحتاج 550 نقطة أخرى لزراعة شجرتك التالية باسمك! 🌳',
              style: AppStyles.styleSemiBold14(
                context,
              ).copyWith(color: Color(0xFFD1FAE5)),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
