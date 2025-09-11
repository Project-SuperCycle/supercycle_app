import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/contact_strings.dart';

class SubmitButton extends StatelessWidget {
  final bool isArabic;
  final bool isLoading;
  final VoidCallback onPressed;

  const SubmitButton({
    Key? key,
    required this.isArabic,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: isLoading
              ? [Colors.grey.shade400, Colors.grey.shade500]
              : [const Color(0xFF06C167), const Color(0xFF06C167)],
        ),
        boxShadow: isLoading
            ? null
            : [
          const BoxShadow(
            color: Color(0xFF2DA261),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              isArabic ? 'جاري الإرسال...' : 'Sending...',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              ContactStrings.get('sendMessage', isArabic),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}