import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle_app/core/helpers/custom_back_button.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_header/profile_header_logo.dart';

class ProfileHeaderNavigation extends StatelessWidget {
  const ProfileHeaderNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu Button (Edit Profile)
          IconButton(
            onPressed: () {
              GoRouter.of(context).go(EndPoints.editprofileView);
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 28,
            ),
          ),

          // Logo Section
          Expanded(
            child: Center(
              child: ProfileHeaderLogo(),
            ),
          ),

          // Back Button (Home)
          CustomBackButton(
            color: Colors.white,
            size: 28,
            onPressed: () {
              GoRouter.of(context).go(EndPoints.homeView);
            },
          ),
        ],
      ),
    );
  }
}