import 'package:flutter/material.dart';
import 'package:supercycle_app/core/services/shipment_data_service.dart';
import 'package:supercycle_app/core/utils/calendar_utils.dart';
import 'package:supercycle_app/features/calendar/presentation/widget/shipment_card.dart';


class ShipmentDetails extends StatelessWidget {
  final DateTime selectedDate;
  final String? imageUrl;

  const ShipmentDetails({
    Key? key,
    required this.selectedDate,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateKey = CalendarUtils.formatDateKey(selectedDate);
    final shipments = ShipmentDataService.getShipmentsForDate(dateKey);

    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الشحنات ليوم ${CalendarUtils.formatFullDate(selectedDate)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          const SizedBox(height: 12),
          if (shipments == null || shipments.isEmpty)
            Center(
              child: Text(
                'لا توجد شحنات لهذا اليوم',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            )
          else
            ...shipments.map((shipment) => ShipmentCard(shipment: shipment)),
          const SizedBox(height: 12),
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