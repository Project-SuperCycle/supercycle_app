import 'package:flutter/material.dart';

class SettingsIcon extends StatelessWidget {
  const SettingsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: ClipRRect(
        child: Image.asset(
          'assets/images/settings icon.png',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.settings,
              color: Colors.grey,
              size: 24,
            );
          },
        ),
      ),
    );
  }
}