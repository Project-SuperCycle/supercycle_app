import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final bool isArabic;
  final VoidCallback onPressed;

  const FloatingButton({
    Key? key,
    required this.isArabic,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Color(0xFF3BC577),
      child: Icon(
          Icons.chat,
          textDirection: TextDirection.ltr,
          color: Colors.white,
      ),
      tooltip: isArabic ? "إرسال" : "Submit",
    );
  }
}
