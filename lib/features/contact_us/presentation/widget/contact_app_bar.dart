import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/utils/contact_strings.dart';

class ContactAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isArabic;
  final bool isLoading;
  final VoidCallback onLanguageToggle;
  final VoidCallback onBack;

  const ContactAppBar({
    super.key,
    required this.isArabic,
    required this.isLoading,
    required this.onLanguageToggle,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: isLoading ? null : onBack,
      ),
      title: Text(
        ContactStrings.get('title', isArabic),
        style: AppStyles.styleSemiBold20(
          context,
        ).copyWith(fontWeight: FontWeight.bold, color: Colors.white),
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
