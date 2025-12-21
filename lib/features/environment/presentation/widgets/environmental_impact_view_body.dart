import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle/core/helpers/custom_loading_indicator.dart';
import 'package:supercycle/features/environment/data/cubits/eco_cubit/eco_cubit.dart';
import 'package:supercycle/features/environment/data/cubits/requests_cubit/requests_cubit.dart';
import 'package:supercycle/features/environment/presentation/widgets/achievements_tab/environmental_achievements_tab.dart';
import 'package:supercycle/features/environment/presentation/widgets/environmental_impact_header.dart';
import 'package:supercycle/features/environment/presentation/widgets/environmental_impact_tab_bar.dart';
import 'package:supercycle/features/environment/presentation/widgets/impact_tab/environmental_impact_tab.dart';
import 'package:supercycle/features/environment/presentation/widgets/trees_tab/environmental_trees_tab.dart';
import 'package:supercycle/features/environment/presentation/widgets/transactions_tab/environmental_transactions_tab.dart';
import 'package:supercycle/features/environment/presentation/widgets/requests_tab/environmental_requests_tab.dart';

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
    _tabController = TabController(length: 5, vsync: this);
    BlocProvider.of<RequestsCubit>(context).getTraderEcoRequests();
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
                              : Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: CustomLoadingIndicator(),
                                  ),
                                ),
                          (state is GetEcoDataSuccess)
                              ? EnvironmentalAchievementsTab(
                                  ecoInfoModel: state.ecoInfoModel,
                                )
                              : Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: CustomLoadingIndicator(),
                                  ),
                                ),
                          // New Transactions Tab
                          (state is GetEcoDataSuccess)
                              ? EnvironmentalTransactionsTab(
                                  ecoInfoModel: state.ecoInfoModel,
                                )
                              : Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: CustomLoadingIndicator(),
                                  ),
                                ),
                          // New Requests Tab
                          (state is GetEcoDataSuccess)
                              ? EnvironmentalRequestsTab()
                              : Center(
                                  child: SizedBox(
                                    height: 200,
                                    child: CustomLoadingIndicator(),
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
