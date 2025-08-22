import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_colors.dart' show AppColors;
import 'package:supercycle_app/features/home/presentation/widgets/home_header/home_header_logo.dart'
    show HomeHeaderLogo;
import 'package:supercycle_app/features/home/presentation/widgets/home_header/home_header_nav_actions.dart';
import 'package:supercycle_app/features/home/presentation/widgets/home_header/rounded_search_field.dart';
import 'package:supercycle_app/features/home/presentation/widgets/home_header/user_profile_welcome_card.dart';

class HomeViewHeader extends StatelessWidget {
  const HomeViewHeader({super.key});

  void _onNotificationPressed() {}

  void _onDrawerPressed() {}

  @override
  Widget build(BuildContext context) {
    // Status bar height (top)
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double statusBarHeight = mediaQuery.padding.top;

    return Container(
      padding: EdgeInsets.only(
        top: statusBarHeight,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(150),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          HomeHeaderLogo(),
          const SizedBox(height: 12),
          Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UserProfileWelcomeCard(),
              HomeHeaderNavActions(
                onDrawerPressed: _onDrawerPressed,
                onNotificationPressed: _onNotificationPressed,
              ),
            ],
          ),
          const SizedBox(height: 24),
          RoundedSearchField(onChange: (value) {}, showClearButton: true),
        ],
      ),
    );
  }
}
