import 'package:flutter/material.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/features/home/presentation/widgets/home_header/home_header_logo.dart'
    show HomeHeaderLogo;
import 'package:supercycle_app/features/home/presentation/widgets/home_header/home_header_nav_actions.dart';
import 'package:supercycle_app/features/home/presentation/widgets/home_header/rounded_search_field.dart';
import 'package:supercycle_app/features/home/presentation/widgets/home_header/user_profile_welcome_card.dart';

class HomeViewHeader extends StatelessWidget {
  const HomeViewHeader({super.key, required this.onDrawerPressed});

  final VoidCallback onDrawerPressed;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double statusBarHeight = mediaQuery.padding.top;

    return Container(
      padding: EdgeInsets.only(
        top: statusBarHeight + 10,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        gradient: kGradientContainer,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          HomeHeaderLogo(),
          const SizedBox(height: 16),
          Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeHeaderNavActions(onDrawerPressed: onDrawerPressed),
              UserProfileWelcomeCard(),
            ],
          ),
          const SizedBox(height: 20),
          RoundedSearchField(onChange: (value) {}, showClearButton: true),
        ],
      ),
    );
  }
}