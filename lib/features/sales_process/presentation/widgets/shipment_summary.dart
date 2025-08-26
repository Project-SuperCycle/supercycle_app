import 'package:flutter/material.dart';
import 'package:supercycle_app/features/sales_process/data/models/product.dart';

class ShipmentSummary extends StatelessWidget {
  final List<Product> products;

  const ShipmentSummary({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    int totalQuantity = 0;
    double totalValue = 0;

    for (var product in products) {
      String qtyStr = product.quantity.replaceAll(RegExp(r'[^0-9]'), '');
      String priceStr = product.averagePrice.replaceAll(RegExp(r'[^0-9]'), '');

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
                Icons.calculate,
                color: Colors.green.shade600,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'إجمالي الشحنة',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'إجمالي الكمية',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${totalQuantity.toString()} كجم',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'إجمالي القيمة التقديرية',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${totalValue.toStringAsFixed(0)} جنيه',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}