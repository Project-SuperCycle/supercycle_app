import 'package:flutter/material.dart';
import 'package:supercycle/core/services/storage_services.dart';
import 'package:supercycle/features/home/presentation/widgets/home_chart/sales_chart_card.dart';
import 'package:supercycle/features/home/presentation/widgets/home_view_header.dart';
import 'package:supercycle/features/home/presentation/widgets/types_section/types_list_view.dart';
import 'package:supercycle/features/home/presentation/widgets/types_section/types_section_header.dart';
import 'package:supercycle/features/home/presentation/widgets/today_shipments_card.dart';
import 'package:supercycle/features/sign_in/data/models/logined_user_model.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key, required this.onDrawerPressed});
  final VoidCallback onDrawerPressed;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  bool isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    LoginedUserModel? loginedUser = await StorageServices.getUserData();
    setState(() {
      isUserLoggedIn = (loginedUser != null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeViewHeader(onDrawerPressed: widget.onDrawerPressed),
            const SizedBox(height: 10),
            // Today's Shipments Card
            (isUserLoggedIn == false)
                ? const SizedBox.shrink()
                : TodayShipmentsCard(),
            SalesChartCard(),
            const SizedBox(height: 20),
            TypesSectionHeader(),
            const SizedBox(height: 12),
            TypesListView(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
