import 'package:flutter/material.dart';
import 'package:supercycle_app/core/services/shipment_data_service.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/utils/calendar_utils.dart';

class ShipmentCalendarDay extends StatefulWidget {
  final DateTime date;
  final bool isToday;
  final bool isSelected;
  final VoidCallback onTap;

  const ShipmentCalendarDay({
    super.key,
    required this.date,
    required this.isToday,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<ShipmentCalendarDay> createState() => _ShipmentCalendarDayState();
}

class _ShipmentCalendarDayState extends State<ShipmentCalendarDay> {
  Color _determineFillColor() {
    final dateKey = CalendarUtils.formatDateKey(widget.date);

    if (widget.isToday) {
      return Colors.blueAccent;
    }
    if (ShipmentDataService.hasAnyPendingShipments(dateKey)) {
      return Color(0xffC70B0B);
    }
    if (ShipmentDataService.areAllShipmentsDelivered(dateKey)) {
      return Color(0xff3BC567);
    }
    return Colors.grey.shade200;
  }

  @override
  Widget build(BuildContext context) {
    final fillColor = _determineFillColor();
    final isHighlight = fillColor != Colors.grey.shade200;

    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Container(
          decoration: BoxDecoration(color: fillColor, shape: BoxShape.circle),
          alignment: Alignment.center,
          height: 40,
          width: 40,
          child: Text(
            '${widget.date.day}',
            style: AppStyles.styleRegular16(context).copyWith(
              color: isHighlight ? Colors.white : Colors.black,
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
