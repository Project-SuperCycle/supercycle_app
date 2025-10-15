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
    return Container(
      color: Colors.grey[50],
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeViewHeader(onDrawerPressed: onDrawerPressed),
            const SizedBox(height: 24),
            SalesChartCard(),
            const SizedBox(height: 32),
            TypesSectionHeader(),
            const SizedBox(height: 16),
            TypesListView(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}