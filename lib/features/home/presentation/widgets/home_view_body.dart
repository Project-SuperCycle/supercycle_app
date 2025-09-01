import 'package:flutter/material.dart';
import 'package:supercycle_app/features/home/presentation/widgets/home_chart/sales_chart_card.dart'
    show SalesChartCard;
import 'package:supercycle_app/features/home/presentation/widgets/home_view_header.dart';
import 'package:supercycle_app/features/home/presentation/widgets/types_section/types_list_view.dart'
    show TypesListView;
import 'package:supercycle_app/features/home/presentation/widgets/types_section/types_section_header.dart'
    show TypesSectionHeader;

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, required this.onDrawerPressed});
  final VoidCallback onDrawerPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeViewHeader(onDrawerPressed: onDrawerPressed),
          SizedBox(height: 20),
          SalesChartCard(),
          SizedBox(height: 30),
          TypesSectionHeader(),
          SizedBox(height: 10),
          TypesListView(),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
