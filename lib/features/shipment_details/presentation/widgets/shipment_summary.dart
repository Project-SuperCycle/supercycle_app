import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/sales_process/data/models/dosh_item_model.dart';

class ShipmentSummary extends StatelessWidget {
  final List<DoshItemModel> items;

  const ShipmentSummary({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    int totalQuantity = 0;
    double totalValue = 0;

    for (var product in items) {
      String qtyStr = product.quantity.toString().replaceAll(
        RegExp(r'[^0-9]'),
        '',
      );
      // String priceStr = product.averagePrice.replaceAll(RegExp(r'[^0-9]'), '');
      String priceStr = "20000";

      int qty = int.tryParse(qtyStr) ?? 0;
      double price = double.tryParse(priceStr) ?? 0;

      totalQuantity += qty;
      totalValue += qty * price;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.green.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.calculate_rounded,
                color: Colors.green.shade600,
                size: 25,
              ),
              const SizedBox(width: 8),
              Text(
                'إجمالي الشحنة',
                style: AppStyles.styleSemiBold14(
                  context,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'إجمالي الكمية',
                      style: AppStyles.styleSemiBold14(
                        context,
                      ).copyWith(color: Colors.green.shade600),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${totalQuantity.toString()} كجم',
                      style: AppStyles.styleSemiBold14(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'إجمالي القيمة التقديرية',
                        style: AppStyles.styleSemiBold14(
                          context,
                        ).copyWith(color: Colors.green.shade600),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${totalValue.toStringAsFixed(0)} جنيه',
                      style: AppStyles.styleSemiBold14(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
