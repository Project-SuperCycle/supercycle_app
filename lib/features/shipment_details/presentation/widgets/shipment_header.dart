import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/sales_process/data/models/shipment_model.dart';

class ShipmentHeader extends StatelessWidget {
  const ShipmentHeader({super.key, required this.shipment});
  final ShipmentModel shipment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
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
                    shipment.shipmentNumber,
                    style: AppStyles.styleSemiBold18(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                shipment.status,
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
                    _formatDateTime(shipment.requestedPickupAt),
                    style: AppStyles.styleSemiBold14(
                      context,
                    ).copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
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
      ],
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '--/--/---- --:--';
    final DateTime adjustedDateTime = dateTime.subtract(Duration(hours: 2));
    return DateFormat('dd/MM/yyyy HH:mm').format(adjustedDateTime);
  }
}
