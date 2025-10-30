import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle_app/core/helpers/custom_back_button.dart';

class BackAndDrawerBar extends StatelessWidget {
  const BackAndDrawerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: const Icon(
              Icons.menu,
              size: 25,
              color: Colors.white,
            ),
          ),
          CustomBackButton(
            size: 25,
            color: Colors.white,
            onPressed: () => GoRouter.of(context).pop(),
          ),
        ],
      ),
    );
  }
}