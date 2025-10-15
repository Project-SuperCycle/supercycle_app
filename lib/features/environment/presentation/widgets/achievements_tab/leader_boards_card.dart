import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/environment/presentation/widgets/achievements_tab/leader_board_item.dart';

class LeaderBoardsCard extends StatelessWidget {
  const LeaderBoardsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('لوحة المتصدرين', style: AppStyles.styleBold18(context)),
          const SizedBox(height: 16),
          LeaderBoardItem(
            rank: '1',
            name: 'شركة الخير للتجارة',
            points: '15,450 نقطة',
            color: const Color(0xFFF59E0B),
            isHighlighted: false,
          ),
          const SizedBox(height: 12),
          LeaderBoardItem(
            rank: '2',
            name: 'مؤسسة النور',
            points: '12,890 نقطة',
            color: Colors.grey,
            isHighlighted: false,
          ),
          const SizedBox(height: 12),
          LeaderBoardItem(
            rank: '8',
            name: 'أنت 🎉',
            points: '2,450 نقطة',
            color: const Color(0xFF059669),
            isHighlighted: true,
          ),
        ],
      ),
    );
  }
}
