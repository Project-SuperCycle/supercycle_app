import 'package:flutter/material.dart';
import 'package:supercycle_app/features/home/presentation/widgets/home_chart/sales_chart_card.dart'
    show SalesChartCard;
import 'package:supercycle_app/features/home/presentation/widgets/home_view_header.dart';
import 'package:supercycle_app/features/home/presentation/widgets/types_section/types_list_view.dart'
    show TypesListView;
import 'package:supercycle_app/features/home/presentation/widgets/types_section/types_section_header.dart'
    show TypesSectionHeader;

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  late PageController pageController;
  int currentPageIndex = 0;

  @override
  void initState() {
    pageController = PageController();

    pageController.addListener(() {
      currentPageIndex = pageController.page!.round();
      setState(() {});
    });
    super.initState();
  }

  final items = List.generate(10, (index) => index);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeViewHeader(),
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
