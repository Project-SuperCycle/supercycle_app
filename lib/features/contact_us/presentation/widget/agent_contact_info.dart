import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/features/contact_us/presentation/widget/contact_info_chip.dart';

class AgentContactInfo extends StatelessWidget {
  final bool isArabic;

  const AgentContactInfo({Key? key, required this.isArabic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(AppAssets.logoIcon, scale: 4.5),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppAssets.logoName, fit: BoxFit.contain, scale: 5.0),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ContactInfoChip(
                      icon: Icons.phone,
                      text: '+20 123 456 7890',
                    ),
                    SizedBox(height: 8),
                    ContactInfoChip(
                      icon: Icons.email,
                      text: 'agent@company.com',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}