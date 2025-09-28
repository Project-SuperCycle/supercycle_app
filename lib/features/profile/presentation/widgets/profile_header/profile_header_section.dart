import 'package:flutter/material.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_data.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_header/profile_header_navigation.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_header/profile_stats_row.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({
    super.key,
    required this.profileData,
  });

  final ProfileData profileData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: const BoxDecoration(
        gradient: kGradientContainer,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Header Navigation
            const ProfileHeaderNavigation(),

            const SizedBox(height: 70),

            // Profile Name
            Text(
              profileData.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Stats Row with Profile Image
            Expanded(
              child: ProfileStatsRow(profileData: profileData),
            ),
          ],
        ),
      ),
    );
  }
}