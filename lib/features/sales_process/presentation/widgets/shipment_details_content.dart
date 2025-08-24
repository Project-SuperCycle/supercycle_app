// widgets/shipment_details_content.dart
import 'package:flutter/material.dart';
import 'package:supercycle_app/features/sales_process/data/models/product.dart';
import 'product_widgets.dart';
import 'shipment_summary.dart';

class ShipmentDetailsContent extends StatelessWidget {
  final List<Product> products;

  const ShipmentDetailsContent({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // عنوان قائمة المنتجات
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Icon(
                Icons.inventory_2,
                color: Colors.blue.shade600,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'منتجات الشحنة (${products.length} أصناف)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // قائمة المنتجات
        ...products.asMap().entries.map((entry) {
          int index = entry.key;
          Product product = entry.value;
          return ProductCard(product: product, index: index + 1);
        }).toList(),

        const SizedBox(height: 16),
        Divider(color: Colors.grey.shade300),
        const SizedBox(height: 16),

        // إجمالي الشحنة
        ShipmentSummary(products: products),

        const SizedBox(height: 16),
        Divider(color: Colors.grey.shade300),
      ],
    );
  }
}