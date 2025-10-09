import 'package:flutter/material.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/representative_main_profile/data/models/representative_profile_data.dart';
import 'package:supercycle_app/features/representative_main_profile/presentation/widgets/representative_profile_header/representative_profile_header_navigation.dart';
import 'package:supercycle_app/features/representative_main_profile/presentation/widgets/representative_profile_header/representative_profile_stats_row.dart';
import 'package:supercycle_app/features/representative_main_profile/presentation/widgets/representative_profile_image.dart';

class RepresentativeProfileHeaderSection extends StatelessWidget {
  const RepresentativeProfileHeaderSection({
    super.key,
    required this.profileData,
  });
  final RepresentativeProfileData profileData;

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
                const RepresentativeProfileHeaderNavigation(),
                const Spacer(flex: 1),
                // representative_main_profile Name
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

          // representative_main_profile Image and Stats Row
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RepresentativeProfileStatsRow(
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
                        child: RepresentativeProfileImage(
                          logoPath: profileData.logoPath,
                        ),
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
