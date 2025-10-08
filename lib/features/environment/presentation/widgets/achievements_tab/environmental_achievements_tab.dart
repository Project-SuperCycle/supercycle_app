import 'package:flutter/material.dart';
import 'package:supercycle_app/features/environment/presentation/widgets/achievements_tab/badges_card.dart';
import 'package:supercycle_app/features/environment/presentation/widgets/achievements_tab/challenge_card.dart';
import 'package:supercycle_app/features/environment/presentation/widgets/achievements_tab/leader_boards_card.dart';

class EnvironmentalAchievementsTab extends StatelessWidget {
  const EnvironmentalAchievementsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          BadgesCard(),
          const SizedBox(height: 12),
          LeaderBoardsCard(),
          const SizedBox(height: 12),
          ChallengeCard(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
