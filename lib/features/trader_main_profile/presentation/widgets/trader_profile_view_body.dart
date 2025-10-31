import 'package:flutter/material.dart';
import 'package:supercycle_app/core/models/user_profile_model.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
import 'package:supercycle_app/core/widgets/drawer/custom_drawer.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_profile_header/trader_profile_header_section.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_profile_info_card1.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_profile_info_card2.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_profile_info_card3.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_profile_page_indicator.dart';

class TraderProfileViewBody extends StatefulWidget {
  final UserProfileModel userProfile;
  const TraderProfileViewBody({super.key, required this.userProfile});

  @override
  State<TraderProfileViewBody> createState() => _TraderProfileViewBodyState();
}

class _TraderProfileViewBodyState extends State<TraderProfileViewBody> {
  int currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
              height: MediaQuery.of(context).size.height * 0.65,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                children: [
                  _buildPageContent(
                    TraderProfileInfoCard1(userProfile: widget.userProfile),
                  ),
                  _buildPageContent(const TraderProfileInfoCard2()),
                  _buildPageContent(const TraderProfileInfoCard3()),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildPageContent(Widget card) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [card, const SizedBox(height: 20)]),
    );
  }
}
