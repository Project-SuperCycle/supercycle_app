import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/representative_shipment_accepted/presentation/widgets/shipment_segments_parts/segment_products_details.dart';

class SegmentWeightInfo extends StatelessWidget {
  final String imagePath;
  final String weight;
  final String? unit;

  const SegmentWeightInfo({
    super.key,
    required this.imagePath,
    required this.weight,
    this.unit = 'طن',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Image Display
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[100],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.broken_image,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'الصورة غير متاحة',
                          style: AppStyles.styleMedium14(
                            context,
                          ).copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SegmentProductsDetails(quantity: 2000, productType: "ورق أبيض"),
        ],
      ),
    );
  }
}
