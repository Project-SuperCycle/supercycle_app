import 'package:flutter/material.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/utils/calendar_utils.dart';
import 'package:supercycle_app/core/widgets/shipment/back_and_info_bar.dart';
import 'package:supercycle_app/core/widgets/shipment/shipment_logo.dart';
import 'package:supercycle_app/features/calendar/presentation/widget/shipments_calendar_grid.dart';
import 'package:supercycle_app/features/calendar/presentation/widget/shipments_calendar_header.dart';
import 'package:supercycle_app/features/calendar/presentation/widget/shipment_calendar_details.dart';
import 'package:supercycle_app/features/calendar/presentation/widget/shipments_calender_title.dart';

class ShipmentsCalendarViewBody extends StatefulWidget {
  const ShipmentsCalendarViewBody({super.key});

  @override
  ShipmentsCalendarViewBodyState createState() =>
      ShipmentsCalendarViewBodyState();
}

class ShipmentsCalendarViewBodyState extends State<ShipmentsCalendarViewBody> {
  DateTime _currentDate = DateTime.now();
  DateTime? _selectedDate;

  static const String _imageUrl =
      "https://moe-ye.net/wp-content/uploads/2021/08/IMG-20210808-WA0001.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(gradient: kGradientBackground),
        child: SafeArea(
          child: Column(
            children: [
              // Fixed header section
              Column(
                children: [
                  const ShipmentLogo(),
                  const SizedBox(height: 20),
                  BackAndInfoBar(),
                ],
              ),
              // Scrollable main content
              Expanded(child: _buildMainContent()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(32), // Combined padding
          child: Column(
            children: [
              ShipmentsCalenderTitle(),
              const SizedBox(height: 20),
              ShipmentsCalendarHeader(
                currentDate: _currentDate,
                onPreviousMonth: _navigateToPreviousMonth,
                onNextMonth: _navigateToNextMonth,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(vertical: 5),
                height: 280,
                child: ShipmentsCalendarGrid(
                  currentDate: _currentDate,
                  selectedDate: _selectedDate,
                  onDateSelected: _onDateSelected,
                ),
              ),
              if (_selectedDate != null)
                ShipmentCalendarDetails(
                  selectedDate: _selectedDate!,
                  imageUrl: _imageUrl,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToPreviousMonth() {
    setState(() {
      _currentDate = CalendarUtils.getPreviousMonth(_currentDate);
      _selectedDate = null;
    });
  }

  void _navigateToNextMonth() {
    setState(() {
      _currentDate = CalendarUtils.getNextMonth(_currentDate);
      _selectedDate = null;
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }
}
