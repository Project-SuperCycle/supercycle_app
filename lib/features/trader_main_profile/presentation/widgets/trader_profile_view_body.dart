import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_profile_header/trader_profile_header_section.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_profile_info_card1.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_profile_info_card2.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_profile_info_card3.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_profile_page_indicator.dart';

class TraderProfileViewBody extends StatefulWidget {
  const TraderProfileViewBody({super.key});

  @override
  State<TraderProfileViewBody> createState() => _TraderProfileViewBodyState();
}

class _TraderProfileViewBodyState extends State<TraderProfileViewBody> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              // Profile Header Section
              ProfileHeaderSection(
                profileData: ProfileConstants.sampleProfileData,
              ),
              const SizedBox(height: 20),

              // Page Indicators
              TraderProfilePageIndicator(
                currentPage: currentPage,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        SliverFillRemaining(
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 2),
                  _buildCurrentPageContent(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentPageContent() {
    switch (currentPage) {
      case 0:
        return TraderProfileInfoCard1(
          profileData: ProfileConstants.sampleProfileData,
        );
      case 1:
        return const TraderProfileInfoCard2();
      case 2:
        return const TraderProfileInfoCard3();
      default:
        return TraderProfileInfoCard1(
          profileData: ProfileConstants.sampleProfileData,
        );
    }
  }
}
