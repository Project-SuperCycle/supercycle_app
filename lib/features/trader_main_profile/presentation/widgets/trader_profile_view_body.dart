import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle/core/models/user_profile_model.dart';
import 'package:supercycle/core/widgets/drawer/custom_drawer.dart';
import 'package:supercycle/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_cubit.dart';
import 'package:supercycle/features/trader_main_profile/presentation/widgets/trader_profile_header/trader_profile_header_section.dart';
import 'package:supercycle/features/trader_main_profile/presentation/widgets/trader_profile_info_card1.dart';
import 'package:supercycle/features/trader_main_profile/presentation/widgets/trader_profile_info_card2.dart';
import 'package:supercycle/features/trader_main_profile/presentation/widgets/trader_profile_info_card3.dart';
import 'package:supercycle/features/trader_main_profile/presentation/widgets/trader_profile_page_indicator.dart';

class TraderProfileViewBody extends StatefulWidget {
  final UserProfileModel userProfile;
  const TraderProfileViewBody({super.key, required this.userProfile});

  @override
  State<TraderProfileViewBody> createState() => _TraderProfileViewBodyState();
}

class _TraderProfileViewBodyState extends State<TraderProfileViewBody> {
  int currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    BlocProvider.of<ShipmentsCalendarCubit>(
      context,
    ).getShipmentsHistory(page: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> _getPages() {
    return [
      TraderProfileInfoCard1(userProfile: widget.userProfile),
      TraderProfileInfoCard2(),
      TraderProfileInfoCard3(user: widget.userProfile),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      drawer: CustomDrawer(isInProfilePage: true),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: TraderProfileHeaderSection(userProfile: widget.userProfile),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Page Indicators
                TraderProfilePageIndicator(
                  currentPage: currentPage,
                  onPageChanged: (index) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height *
                  0.6, // ارتفاع مناسب للمحتوى
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                children: _getPages().map((page) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: page,
                  );
                }).toList(),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}
