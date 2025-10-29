import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
import 'package:supercycle_app/core/widgets/drawer/custom_drawer.dart';
import 'package:supercycle_app/features/representative_main_profile/presentation/widgets/representative_profile_header/representative_profile_header_section.dart';
import 'package:supercycle_app/features/representative_main_profile/presentation/widgets/representative_profile_info_card.dart';

class RepresentativeProfileViewBody extends StatefulWidget {
  const RepresentativeProfileViewBody({super.key});

  @override
  State<RepresentativeProfileViewBody> createState() =>
      _RepresentativeProfileViewBodyState();
}

class _RepresentativeProfileViewBodyState
    extends State<RepresentativeProfileViewBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      drawer:CustomDrawer(isInProfilePage: true),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: RepresentativeProfileHeaderSection(
              representativeProfileData:
              ProfileConstants.sampleRepresentativeData,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: const [
                  RepresentativeProfileInfoCard(),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}