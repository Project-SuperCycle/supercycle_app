import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    super.key,
    this.onPressed,
    this.controller,
  });

  final VoidCallback? onPressed;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: const TextStyle(
            color: Color(0xFF002055),
          ),
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.search,
              color: Color(0xFF002055),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }
}
