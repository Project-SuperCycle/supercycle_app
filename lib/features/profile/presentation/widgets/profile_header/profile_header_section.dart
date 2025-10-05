import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_data.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_header/profile_header_navigation.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_image.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_header/profile_stats_row.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key, required this.profileData});
  final ProfileData profileData;

  @override
  Widget build(BuildContext context) {
    final double containerHeight = 260.0;
    final profileImageSize = 120.0;

    return SizedBox(
      width: double.infinity,
      height: containerHeight + (profileImageSize / 2),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            height: containerHeight,
            decoration: BoxDecoration(
              gradient: kGradientContainer,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(50),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                const ProfileHeaderNavigation(),
                const Spacer(flex: 1),
                // Profile Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    profileData.name,
                    style: AppStyles.styleSemiBold24(
                      context,
                    ).copyWith(color: Colors.white, fontSize: 32),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),

          // Profile Image and Stats Row
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ProfileStatsRow(
                profileData: profileData,
                profileImage: Container(
                  width: profileImageSize,
                  height: profileImageSize,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.white, Colors.white],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(50),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(
                        child: ProfileImage(logoPath: profileData.logoPath),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
