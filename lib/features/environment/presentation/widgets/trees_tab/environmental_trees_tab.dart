import 'package:flutter/material.dart';
import 'package:supercycle_app/features/environment/data/models/trader_eco_info_model.dart';
import 'package:supercycle_app/features/environment/presentation/widgets/trees_tab/earn_points_card.dart';
import 'package:supercycle_app/features/environment/presentation/widgets/trees_tab/green_points_card.dart';
import 'package:supercycle_app/features/environment/presentation/widgets/trees_tab/tree_initiative_card.dart';

class EnvironmentalTreesTab extends StatelessWidget {
  final TraderEcoInfoModel ecoInfoModel;
  const EnvironmentalTreesTab({super.key, required this.ecoInfoModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          GreenPointsCard(points: ecoInfoModel.stats.totalPoints),
          const SizedBox(height: 12),
          TreeInitiativeCard(trees: ecoInfoModel.stats.treesPlanted),
          const SizedBox(height: 12),
          EarnPointsCard(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
