import 'package:flutter/material.dart';
import 'package:supercycle_app/features/home/presentation/widgets/home_chart/sales_chart_card.dart';
import 'package:supercycle_app/features/home/presentation/widgets/home_view_header.dart';
import 'package:supercycle_app/features/home/presentation/widgets/types_section/types_list_view.dart';
import 'package:supercycle_app/features/home/presentation/widgets/types_section/types_section_header.dart';
import 'package:supercycle_app/features/home/presentation/widgets/today_shipments_card.dart';

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

            // Today's Shipments Card
            TodayShipmentsCard(),
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
