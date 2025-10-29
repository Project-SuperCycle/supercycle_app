import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/helpers/custom_loading_indicator.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/utils/calendar_utils.dart';
import 'package:supercycle_app/core/widgets/drawer/custom_drawer.dart';
import 'package:supercycle_app/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:supercycle_app/core/widgets/shipment/shipment_logo.dart';
import 'package:supercycle_app/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_cubit.dart';
import 'package:supercycle_app/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_state.dart';
import 'package:supercycle_app/features/shipments_calendar/data/models/shipment_model.dart';
import 'package:supercycle_app/features/shipments_calendar/presentation/widget/shipment_calendar_details.dart';
import 'package:supercycle_app/features/shipments_calendar/presentation/widget/shipments_calendar_grid.dart';
import 'package:supercycle_app/features/shipments_calendar/presentation/widget/shipments_calendar_header.dart';
import 'package:supercycle_app/features/shipments_calendar/presentation/widget/shipments_calender_title.dart';

class ShipmentsCalendarViewBody extends StatefulWidget {
  const ShipmentsCalendarViewBody({super.key});

  @override
  ShipmentsCalendarViewBodyState createState() =>
      ShipmentsCalendarViewBodyState();
}

class ShipmentsCalendarViewBodyState extends State<ShipmentsCalendarViewBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime _currentDate = DateTime.now();
  DateTime? _selectedDate;

  List<ShipmentModel> shipments = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShipmentsCalendarCubit>(context).getAllShipments();
  }



  static const String _imageUrl =
      "https://moe-ye.net/wp-content/uploads/2021/08/IMG-20210808-WA0001.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      key: _scaffoldKey,
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(gradient: kGradientBackground),
        child: SafeArea(
          child: Column(
            children: [
              Column(
                children: [
                  const ShipmentLogo(),
                  const SizedBox(height: 20),
                ],
              ),
              Expanded(
                child:
                    BlocConsumer<
                      ShipmentsCalendarCubit,
                      ShipmentsCalendarState
                    >(
                      listener: (context, state) {
                        // TODO: implement listener
                        if (state is GetAllShipmentsSuccess) {
                          setState(() {
                            shipments = state.shipments;
                          });
                        }
                        if (state is GetAllShipmentsFailure) {
                          shipments = [];
                          Logger().e(state.errorMessage);
                        }
                      },
                      builder: (context, state) {
                        if (state is GetAllShipmentsLoading) {
                          return const Center(
                            child: CustomLoadingIndicator(color: Colors.white),
                          );
                        }
                        if (state is GetAllShipmentsFailure) {
                          return Center(
                            child: Text(
                              state.errorMessage,
                              style: AppStyles.styleMedium18(
                                context,
                              ).copyWith(color: Colors.red),
                            ),
                          );
                        }
                        return _buildMainContent(shipments: shipments);
                      },
                      buildWhen: (previous, current) =>
                          current is GetAllShipmentsSuccess ||
                          current is GetAllShipmentsFailure ||
                          current is GetAllShipmentsLoading,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent({required List<ShipmentModel> shipments}) {
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
                height: 320,
                child: ShipmentsCalendarGrid(
                  shipments: shipments,
                  currentDate: _currentDate,
                  selectedDate: _selectedDate,
                  onDateSelected: _onDateSelected,
                ),
              ),
              if (_selectedDate != null)
                ShipmentsCalendarDetails(
                  shipments: shipments,
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
