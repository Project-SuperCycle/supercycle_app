import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/contact_strings.dart';

class ContactAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isArabic;
  final bool isLoading;
  final VoidCallback onLanguageToggle;
  final VoidCallback onBack;

  const ContactAppBar({
    Key? key,
    required this.isArabic,
    required this.isLoading,
    required this.onLanguageToggle,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF3BC577),
      foregroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: isLoading ? null : onBack,
      ),
      title: Text(
        ContactStrings.get('title', isArabic),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            Icons.translate,
            color: isLoading ? Colors.white60 : Colors.white,
          ),
          onPressed: isLoading ? null : onLanguageToggle,
          tooltip: ContactStrings.get('switchToEnglish', isArabic),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}