import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle_app/core/models/user_profile_model.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/services/api_endpoints.dart';
import 'package:supercycle_app/core/services/api_services.dart';

Future<void> navigateToProfile(BuildContext context) async {
  try {
    final data = await ApiServices().get(endPoint: ApiEndpoints.getProfileInfo);
    final fetchedUser = UserProfileModel.fromJson(data['data']);

    final route = switch (fetchedUser.role) {
      'trader_uncontracted' => EndPoints.traderProfileView,
      'representative' => EndPoints.representativeProfileView,
      _ => null,
    };

    if (route != null && context.mounted) {
      GoRouter.of(context).push(route, extra: fetchedUser);
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load profile: ${e.toString()}')),
      );
    }
  }
}
