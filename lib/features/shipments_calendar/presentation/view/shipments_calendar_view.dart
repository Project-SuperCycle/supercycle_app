import 'package:flutter/material.dart';
import 'package:supercycle_app/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:supercycle_app/features/shipments_calendar/presentation/widget/shipments_calendar_view_body.dart';

class ShipmentsCalendarView extends StatelessWidget {
  const ShipmentsCalendarView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShipmentsCalendarViewBody(),
      bottomNavigationBar: CustomCurvedNavigationBar(
        currentIndex: 3,
      ),
    );
  }
}
