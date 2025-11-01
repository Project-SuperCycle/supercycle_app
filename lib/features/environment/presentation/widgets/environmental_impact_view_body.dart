import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle_app/core/helpers/custom_loading_indicator.dart';
import 'package:supercycle_app/features/environment/data/cubits/eco_cubit/eco_cubit.dart';
import 'package:supercycle_app/features/environment/presentation/widgets/achievements_tab/environmental_achievements_tab.dart';
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
    BlocProvider.of<EcoCubit>(context).getTraderEcoInfo();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<EcoCubit, EcoState>(
        listener: (context, state) {
          // TODO: implement listener

          if (state is GetEcoDataFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              (state is GetEcoDataSuccess)
                  ? EnvironmentalImpactHeader(ecoInfoModel: state.ecoInfoModel)
                  : SliverToBoxAdapter(
                      child: Center(
                        child: SizedBox(
                          height: 200,
                          child: CustomLoadingIndicator(),
                        ),
                      ),
                    ),
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
                          (state is GetEcoDataSuccess)
                              ? EnvironmentalTreesTab(
                                  ecoInfoModel: state.ecoInfoModel,
                                )
                              : SliverToBoxAdapter(
                                  child: Center(
                                    child: SizedBox(
                                      height: 200,
                                      child: CustomLoadingIndicator(),
                                    ),
                                  ),
                                ),
                          (state is GetEcoDataSuccess)
                              ? EnvironmentalAchievementsTab(
                                  ecoInfoModel: state.ecoInfoModel,
                                )
                              : SliverToBoxAdapter(
                                  child: Center(
                                    child: SizedBox(
                                      height: 200,
                                      child: CustomLoadingIndicator(),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
