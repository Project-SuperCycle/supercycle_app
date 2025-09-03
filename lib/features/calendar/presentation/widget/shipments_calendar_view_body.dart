import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/helpers/custom_back_button.dart';
import 'package:supercycle_app/core/helpers/logo.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/calendar_utils.dart';
import 'package:supercycle_app/features/calendar/presentation/widget/calendar_grid.dart';
import 'package:supercycle_app/features/calendar/presentation/widget/calendar_header.dart';
import 'package:supercycle_app/features/calendar/presentation/widget/shipment_details.dart';

class ShipmentsCalendarViewBody extends StatelessWidget {
  const ShipmentsCalendarViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ShipmentsCalendarPage();
  }
}

class ShipmentsCalendarPage extends StatefulWidget {
  const ShipmentsCalendarPage({Key? key}) : super(key: key);

  @override
  _ShipmentsCalendarPageState createState() => _ShipmentsCalendarPageState();
}

class _ShipmentsCalendarPageState extends State<ShipmentsCalendarPage> {
  DateTime _currentDate = DateTime.now();
  DateTime? _selectedDate;

  static const String _imageUrl = "https://moe-ye.net/wp-content/uploads/2021/08/IMG-20210808-WA0001.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(gradient: kGradientBackground),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Logo(),
              const SizedBox(height: 20),
              _buildTopBar(context),
              Expanded(
                child: _buildMainContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.info_outline, color: Colors.black),
          CustomBackButton(
            color: Colors.black,
            size: 24,
            onPressed: () {
              GoRouter.of(context).pushReplacement(EndPoints.homeView);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _buildTitle(),
              const SizedBox(height: 16),
              CalendarHeader(
                currentDate: _currentDate,
                onPreviousMonth: _navigateToPreviousMonth,
                onNextMonth: _navigateToNextMonth,
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 300,
                child: CalendarGrid(
                  currentDate: _currentDate,
                  selectedDate: _selectedDate,
                  onDateSelected: _onDateSelected,
                ),
              ),
              if (_selectedDate != null)
                ShipmentDetails(
                  selectedDate: _selectedDate!,
                  imageUrl: _imageUrl,

                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        const Text(
          "جدول متابعه الشحنات",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'تابع مواعيد تسليم الشحنات وإجراءات التسليم',
          style: TextStyle(color: Colors.grey[700], fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
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