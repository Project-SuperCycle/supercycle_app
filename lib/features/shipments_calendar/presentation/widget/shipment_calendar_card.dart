import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/shipments_calendar/data/models/shipment.dart';

class ShipmentsCalendarCard extends StatelessWidget {
  final Shipment shipment;

  const ShipmentsCalendarCard({super.key, required this.shipment});

  void _showShipmentDetails(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            children: [
                              Text(
                                'رقم الشحنة: ',
                                style: AppStyles.styleSemiBold16(context),
                              ),
                              Text(
                                shipment.number,
                                style: AppStyles.styleMedium16(
                                  context,
                                ).copyWith(color: AppColors.greenColor),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            shipment.time,
                            style: AppStyles.styleRegular14(
                              context,
                            ).copyWith(color: AppColors.greenColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Divider(
                    radius: BorderRadius.circular(5),
                    color: Colors.grey.shade300,
                    thickness: 1.5,
                    indent: 10,
                    endIndent: 10,
                  ),
                  const SizedBox(height: 5),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        Text(
                          'الكمية: ',
                          style: AppStyles.styleSemiBold14(context),
                        ),
                        Text(
                          shipment.quantity,
                          style: AppStyles.styleMedium14(
                            context,
                          ).copyWith(color: AppColors.subTextColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        Text(
                          'العنوان: ',
                          style: AppStyles.styleSemiBold14(context),
                        ),
                        Text(
                          shipment.address,
                          style: AppStyles.styleMedium14(
                            context,
                          ).copyWith(color: AppColors.subTextColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        Text(
                          'الحالة: ',
                          style: AppStyles.styleSemiBold14(context),
                        ),
                        Text(
                          shipment.statusText,
                          style: AppStyles.styleMedium14(context).copyWith(
                            color: shipment.isDelivered
                                ? Colors.green[700]
                                : Colors.red[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _showShipmentDetails(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Text(
                    'إظهار التفاصيل',
                    style: AppStyles.styleSemiBold14(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
