import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart'
    show ProfileConstants;
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_branches_section.dart';
import 'package:supercycle_app/features/trader_main_profile/data/models/trader_profile_data.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_profile_info_row.dart';

class TraderProfileInfoCard1 extends StatelessWidget {
  const TraderProfileInfoCard1({super.key, required this.profileData});

  final TraderProfileData profileData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xE4DDFFE7),
        border: Border.all(color: Color(0xFF16A243)),
        borderRadius: BorderRadius.circular(ProfileConstants.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ..._buildProfileInfoRows(),
            const SizedBox(height: 30),
            TraderBranchesSection(branchCount: profileData.branchCount),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildProfileInfoRows() {
    final profileInfo = [
      ProfileInfoItem(
        label: "نوع النشاط",
        value: profileData.activityType,
        icon: Icons.business,
      ),
      ProfileInfoItem(
        label: "العنوان",
        value: profileData.address,
        icon: Icons.location_on,
      ),
      ProfileInfoItem(
        label: "اسم المسئول",
        value: profileData.responsiblePerson,
        icon: Icons.person,
      ),
      ProfileInfoItem(
        label: "رقم الهاتف",
        value: profileData.phoneNumber,
        icon: Icons.phone,
      ),
      ProfileInfoItem(
        label: "الايميل",
        value: profileData.email,
        icon: Icons.email,
      ),
    ];

    return profileInfo
        .map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: ProfileConstants.spacing),
            child: TraderProfileInfoRow(
              label: item.label,
              value: item.value,
              icon: item.icon,
            ),
          ),
        )
        .toList();
  }
}

class ProfileInfoItem {
  final String label;
  final String value;
  final IconData icon;

  ProfileInfoItem({
    required this.label,
    required this.value,
    required this.icon,
  });
}
