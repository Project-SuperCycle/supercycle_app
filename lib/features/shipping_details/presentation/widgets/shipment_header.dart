import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';

class ShipmentHeader extends StatelessWidget {
  const ShipmentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: ClipRRect(
            child: Image.asset(
              AppAssets.photoGallery,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(color: Colors.grey.shade200),
                  child: const Icon(
                    Icons.image_outlined,
                    size: 40,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    child: Image.asset(
                      AppAssets.boxPerspective,
                      width: 25,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.inventory_2_outlined,
                          color: Colors.orange,
                          size: 20,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'رقم الشحنة: ',
                    style: AppStyles.styleSemiBold18(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'U22bB',
                    style: AppStyles.styleSemiBold18(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'يتم المراجعة',
                style: AppStyles.styleSemiBold16(
                  context,
                ).copyWith(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'تاريخ الاستلام: ',
                    style: AppStyles.styleSemiBold14(context),
                  ),
                  Text(
                    '--/--/----',
                    style: AppStyles.styleSemiBold14(
                      context,
                    ).copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
