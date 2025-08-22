import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_styles.dart' show AppStyles;

class TypesFilterButton extends StatelessWidget {
  const TypesFilterButton({
    super.key,
    required this.title,
    required this.color,
  });
  final String title;
  final Color color;

  void handleFilter() {}

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: handleFilter,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        minimumSize: const Size(70, 30),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          title,
          style: AppStyles.styleSemiBold14(
            context,
          ).copyWith(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
