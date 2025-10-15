import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
import 'package:supercycle_app/features/representative_main_profile/data/models/representative_profile_data.dart';
import 'package:supercycle_app/features/representative_main_profile/presentation/widgets/representative_profile_info_row.dart';

class RepresentativeProfileInfoCard1 extends StatelessWidget {
  const RepresentativeProfileInfoCard1({super.key, required this.profileData});

  final RepresentativeProfileData profileData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xE4DDFFE7).withAlpha(50),
        border: Border.all(color: Color(0xFF16A243).withAlpha(200)),
        borderRadius: BorderRadius.circular(ProfileConstants.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [..._buildProfileInfoRows()],
        ),
      ),
    );
  }

  List<Widget> _buildProfileInfoRows() {
    final profileInfo = [
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
            child: RepresentativeProfileInfoRow(
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
