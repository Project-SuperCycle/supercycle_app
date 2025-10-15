import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
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
      body: Column(
        children: [
          RepresentativeProfileHeaderSection(
            representativeProfileData:
                ProfileConstants.sampleRepresentativeData,
          ),
          const SizedBox(height: 0),

          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: const SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 2),
                    RepresentativeProfileInfoCard(),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
