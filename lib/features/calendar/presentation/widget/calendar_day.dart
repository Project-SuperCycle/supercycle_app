import 'package:flutter/material.dart';
import 'package:supercycle_app/core/services/shipment_data_service.dart';
import 'package:supercycle_app/core/utils/calendar_utils.dart';

class CalendarDay extends StatefulWidget {
  final DateTime date;
  final bool isToday;
  final bool isSelected;
  final VoidCallback onTap;

  const CalendarDay({
    super.key,
    required this.date,
    required this.isToday,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<CalendarDay> createState() => _CalendarDayState();
}

class _CalendarDayState extends State<CalendarDay> {
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
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: fillColor,
          shape: BoxShape.circle,
          boxShadow: widget.isSelected
              ? [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ]
              : [],
        ),
        alignment: Alignment.center,
        height: 40,
        width: 40,
        child: Text(
          '${widget.date.day}',
          style: TextStyle(
            color: isHighlight ? Colors.white : Colors.black87,
            fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
