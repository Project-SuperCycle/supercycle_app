import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle_app/core/helpers/custom_back_button.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/features/representative_main_profile/presentation/widgets/representative_profile_header/representative_profile_header_logo.dart';

class RepresentativeProfileHeaderNavigation extends StatelessWidget {
  const RepresentativeProfileHeaderNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu Button (Edit representative_main_profile)
          IconButton(
            onPressed: () {
              GoRouter.of(context).go(EndPoints.editTraderProfileView);
            },
            icon: const Icon(Icons.menu, color: Colors.white, size: 28),
          ),

          // Logo Section
          Expanded(child: Center(child: RepresentativeProfileHeaderLogo())),

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
