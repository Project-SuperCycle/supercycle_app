import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:supercycle/core/models/user_profile_model.dart';
import 'package:supercycle/features/trader_main_profile/presentation/widgets/trader_profile_view_body.dart';

class TraderProfileView extends StatelessWidget {
  final UserProfileModel userProfile;
  const TraderProfileView({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    Logger().d(userProfile.toString());
    return TraderProfileViewBody(userProfile: userProfile);
  }
}
