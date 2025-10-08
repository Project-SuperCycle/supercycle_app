import 'package:flutter/material.dart';
import 'package:supercycle_app/features/environment/presentation/widgets/achievements_tab/badges_card.dart';
import 'package:supercycle_app/features/environment/presentation/widgets/achievements_tab/challenge_card.dart';
import 'package:supercycle_app/features/environment/presentation/widgets/achievements_tab/environmental_achievements_tab.dart';
import 'package:supercycle_app/features/environment/presentation/widgets/achievements_tab/leader_boards_card.dart';
import 'package:supercycle_app/features/environment/presentation/widgets/environmental_impact_header.dart';
import 'package:supercycle_app/features/environment/presentation/widgets/environmental_impact_tab_bar.dart';
import 'package:supercycle_app/features/environment/presentation/widgets/impact_tab/environmental_impact_tab.dart';
import 'package:supercycle_app/features/environment/presentation/widgets/trees_tab/environmental_trees_tab.dart';

class EnvironmentalImpactViewBody extends StatefulWidget {
  const EnvironmentalImpactViewBody({super.key});

  @override
  State<EnvironmentalImpactViewBody> createState() =>
      _EnvironmentalImpactViewBodyState();
}

class _EnvironmentalImpactViewBodyState
    extends State<EnvironmentalImpactViewBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          EnvironmentalImpactHeader(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                EnvironmentalImpactTabBar(tabController: _tabController),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      EnvironmentalImpactTab(),
                      EnvironmentalTreesTab(),
                      EnvironmentalAchievementsTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
