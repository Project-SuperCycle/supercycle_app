import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/calendar_utils.dart';
import 'package:supercycle_app/features/calendar/presentation/widget/calendar_day.dart';

class CalendarGrid extends StatelessWidget {
  final DateTime currentDate;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const CalendarGrid({
    super.key,
    required this.currentDate,
    this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final calendarInfo = CalendarUtils.getCalendarInfo(currentDate);
    final List<Widget> dayWidgets = [];

    for (int i = 0; i < calendarInfo.firstWeekday; i++) {
      dayWidgets.add(Container());
    }

    for (int day = 1; day <= calendarInfo.daysInMonth; day++) {
      final date = DateTime(currentDate.year, currentDate.month, day);
      final isToday = CalendarUtils.isSameDate(date, DateTime.now());
      final isSelected = selectedDate != null &&
          CalendarUtils.isSameDate(date, selectedDate!);

      dayWidgets.add(
        CalendarDay(
          date: date,
          isToday: isToday,
          isSelected: isSelected,
          onTap: () => onDateSelected(date),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      children: dayWidgets,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}
