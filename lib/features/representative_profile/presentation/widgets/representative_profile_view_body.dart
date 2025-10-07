import 'package:flutter/material.dart';
import 'package:supercycle_app/features/representative_profile/presentation/widgets/representativ_profile_constants.dart';
import 'package:supercycle_app/features/representative_profile/presentation/widgets/representative_profile_card.dart';
import 'package:supercycle_app/features/representative_profile/presentation/widgets/representative_profile_header/representativ_profile_header_section.dart';

class RepresentativeProfileViewBody extends StatefulWidget {
  const RepresentativeProfileViewBody({super.key});

  @override
  State<RepresentativeProfileViewBody> createState() => _RepresentativeProfileViewBodyState();
}

class _RepresentativeProfileViewBodyState extends State<RepresentativeProfileViewBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RepresentativProfileHeaderSection(
            representativeProfileData: ProfileConstants.sampleRepresentativeProfileData,
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
                    RepresentativeProfileCard(),
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