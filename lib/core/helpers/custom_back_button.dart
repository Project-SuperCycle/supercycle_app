import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final double size;
  final EdgeInsetsGeometry? padding;

  const CustomBackButton({
    super.key,
    required this.onPressed,
    this.color = Colors.black,
    this.size = 24.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.of(context).pop(),
      child: Container(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: Icon(
          textDirection: TextDirection.ltr,
          Icons.arrow_back_ios_new,
          color: color,
          size: size,
        ),
      ),
    );
  }
}