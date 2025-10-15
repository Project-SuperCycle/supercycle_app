import 'package:flutter/material.dart';

class RepresentativeProfilePageIndicator extends StatelessWidget {
  const RepresentativeProfilePageIndicator({
    super.key,
    required this.currentPage,
    this.totalPages = 2,
    this.onPageChanged,
  });

  final int currentPage;
  final int totalPages;
  final Function(int)? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => GestureDetector(
          onTap: () {
            onPageChanged?.call(index);
          },
          child: _buildIndicatorDot(index == currentPage),
        ),
      ),
    );
  }

  Widget _buildIndicatorDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.grey.withAlpha(150),
        shape: BoxShape.circle,
      ),
    );
  }
}
