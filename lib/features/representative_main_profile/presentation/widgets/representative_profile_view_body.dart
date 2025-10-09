import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
import 'package:supercycle_app/features/representative_main_profile/presentation/widgets/representative_profile_header/representative_profile_header_section.dart';
import 'package:supercycle_app/features/representative_main_profile/presentation/widgets/representative_profile_info_card1.dart';
import 'package:supercycle_app/features/representative_main_profile/presentation/widgets/representative_profile_info_card2.dart';
import 'package:supercycle_app/features/representative_main_profile/presentation/widgets/representative_profile_page_indicator.dart';

class RepresentativeProfileViewBody extends StatefulWidget {
  const RepresentativeProfileViewBody({super.key});

  @override
  State<RepresentativeProfileViewBody> createState() =>
      _RepresentativeProfileViewBodyState();
}

class _RepresentativeProfileViewBodyState
    extends State<RepresentativeProfileViewBody> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RepresentativeProfileHeaderSection(
            profileData: ProfileConstants.sampleRepresentativeData,
          ),
          const SizedBox(height: 30),
          // Page Indicators
          RepresentativeProfilePageIndicator(
            currentPage: currentPage,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
          ),

          const SizedBox(height: 10),

          // White Content Section with different cards based on currentPage
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    _buildCurrentPageContent(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPageContent() {
    switch (currentPage) {
      case 0:
        return RepresentativeProfileInfoCard1(
          profileData: ProfileConstants.sampleRepresentativeData,
        );
      case 1:
        return const RepresentativeProfileInfoCard2();

      default:
        return RepresentativeProfileInfoCard1(
          profileData: ProfileConstants.sampleRepresentativeData,
        );
    }
  }
}
