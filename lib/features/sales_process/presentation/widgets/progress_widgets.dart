import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          ProgressPoint(isCompleted: true),
          ProgressLine(isCompleted: true),
          ProgressPoint(isCompleted: true),
          ProgressLine(isCompleted: false),
          ProgressPoint(isCompleted: false),
          ProgressLine(isCompleted: false),
          ProgressPoint(isCompleted: false),
        ],
      ),
    );
  }
}

class ProgressPoint extends StatelessWidget {
  final bool isCompleted;

  const ProgressPoint({
    super.key,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: isCompleted ? const Color(0xFF3BC577) : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: isCompleted ? const Color(0xFFAAEBBF) : Colors.grey.shade400,
          width: 2,
        ),
      ),
      child: isCompleted
          ? const Icon(
        Icons.check,
        color: Colors.white,
        size: 15,
      )
          : null,
    );
  }
}

class ProgressLine extends StatelessWidget {
  final bool isCompleted;

  const ProgressLine({
    super.key,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 5,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isCompleted ? const Color(0xFF4CAF50) : Colors.grey.shade300,
          border: Border.all(
            color: isCompleted ? const Color(0xFFAAEBBF) : Colors.grey.shade400,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(1.5),
        ),
      ),
    );
  }
}