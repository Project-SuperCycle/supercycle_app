import 'package:flutter/material.dart';
import 'package:supercycle_app/core/helpers/custom_back_button.dart';

class BackAndInfoBar extends StatelessWidget {
  const BackAndInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.info_outline, size: 25, color: Colors.white),
          CustomBackButton(size: 25, color: Colors.white),
        ],
      ),
    );
  }
}
