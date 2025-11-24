import 'package:flutter/material.dart';
import 'package:supercycle/features/environment/presentation/widgets/impact_tab/environmental_impact_info_card.dart';
import 'package:supercycle/features/environment/presentation/widgets/impact_tab/environmental_impact_saving_card.dart';

class EnvironmentalImpactTab extends StatelessWidget {
  const EnvironmentalImpactTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          EnvironmentalImpactSavingCard(),
          const SizedBox(height: 16),
          EnvironmentalImpactInfoCard(),
        ],
      ),
    );
  }
}
