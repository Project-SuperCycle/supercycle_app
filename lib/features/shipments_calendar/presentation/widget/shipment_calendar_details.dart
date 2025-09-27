import 'package:flutter/material.dart';
import 'package:supercycle_app/core/helpers/shipments_calender_helper.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/utils/calendar_utils.dart';
import 'package:supercycle_app/features/shipments_calendar/data/models/shipment_model.dart';
import 'package:supercycle_app/features/shipments_calendar/presentation/widget/shipment_calendar_card.dart';

class ShipmentsCalendarDetails extends StatelessWidget {
  final DateTime selectedDate;
  final String? imageUrl;
  final List<ShipmentModel> shipments;

  const ShipmentsCalendarDetails({
    super.key,
    required this.selectedDate,
    this.imageUrl,
    required this.shipments,
  });

  @override
  Widget build(BuildContext context) {
    final dateKey = CalendarUtils.formatDateKey(selectedDate);
    final shipmentsHelper = ShipmentsCalendarHelper(shipments: shipments);
    final shipmentsList = shipmentsHelper.getShipmentsForDate(dateKey);
    final isDelivered = shipmentsHelper.areAllShipmentsDeliveredWithTime(
      dateKey,
    );

    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDelivered ? Colors.green[300]! : Colors.red[300]!,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              isDelivered ? 'شحنات تم تسليمها' : 'شحنات سيتم تسليمها',
              style: AppStyles.styleSemiBold20(context),
            ),
          ),
          const SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              CalendarUtils.formatFullDate(selectedDate),
              style: AppStyles.styleMedium18(
                context,
              ).copyWith(color: AppColors.subTextColor),
            ),
          ),

          const SizedBox(height: 16),
          if (shipmentsList.isEmpty)
            Center(
              child: Text(
                'لا توجد شحنات لهذا اليوم',
                style: AppStyles.styleMedium16(
                  context,
                ).copyWith(color: AppColors.subTextColor),
              ),
            )
          else
            ...shipmentsList.map(
              (shipment) => ShipmentsCalendarCard(shipment: shipment),
            ),
          const SizedBox(height: 16),
          if (imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                height: 180,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: Icon(
                      Icons.image_not_supported,
                      size: 60,
                      color: Colors.grey[400],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
