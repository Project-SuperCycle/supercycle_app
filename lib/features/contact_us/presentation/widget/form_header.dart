import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/contact_strings.dart';

class FormHeader extends StatelessWidget {
  final bool isArabic;

  const FormHeader({Key? key, required this.isArabic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.contact_support,
            size: 32,
            color: Color(0xFF3BC577),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          ContactStrings.get('headerTitle', isArabic),
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          ContactStrings.get('headerSubtitle', isArabic),
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 16,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}