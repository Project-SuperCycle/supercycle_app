import 'package:flutter/material.dart';
import 'package:supercycle_app/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:supercycle_app/features/sales_process/presentation/widgets/sales_process_view_body.dart';

class SalesProcessView extends StatelessWidget {
  const SalesProcessView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SalesProcessViewBody(),
      bottomNavigationBar: CustomCurvedNavigationBar(
        currentIndex: 1,
      ),
    );
  }

}