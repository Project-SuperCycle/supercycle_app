import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:supercycle/core/constants.dart';
import 'package:supercycle/core/helpers/custom_loading_indicator.dart';
import 'package:supercycle/core/services/storage_services.dart';
import 'package:supercycle/core/utils/app_styles.dart';
import 'package:supercycle/core/utils/calendar_utils.dart';
import 'package:supercycle/core/widgets/drawer/custom_drawer.dart';
import 'package:supercycle/core/widgets/shipment/shipment_logo.dart';
import 'package:supercycle/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_cubit.dart';
import 'package:supercycle/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_state.dart';
import 'package:supercycle/features/shipments_calendar/data/models/shipment_model.dart';
import 'package:supercycle/features/shipments_calendar/presentation/widget/shipment_calendar_details.dart';
import 'package:supercycle/features/shipments_calendar/presentation/widget/shipments_calendar_grid.dart';
import 'package:supercycle/features/shipments_calendar/presentation/widget/shipments_calendar_header.dart';
import 'package:supercycle/features/shipments_calendar/presentation/widget/shipments_calender_title.dart';
import 'package:supercycle/features/sign_in/data/models/logined_user_model.dart';

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
  List<ShipmentModel> allShipments = [];
  int currentPage = 1;
  bool hasMoreData = true;
  bool isLoadingMore = false;
  String? userRole;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadUserCalender();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!isLoadingMore && hasMoreData) {
        _loadMoreShipments();
      }
    }
  }

  void loadUserCalender() async {
    LoginedUserModel? user = await StorageServices.getUserData();
    Logger().d("USER: $user");
    if (user != null) {
      setState(() {
        userRole = user.role;
      });
      _fetchShipments(currentPage);
    }
  }

  void _fetchShipments(int page) {
    if (userRole == "representative") {
      BlocProvider.of<ShipmentsCalendarCubit>(
        context,
      ).getAllRepShipments(query: {"page": page.toString()});
    } else {
      BlocProvider.of<ShipmentsCalendarCubit>(
        context,
      ).getAllShipments(query: {"page": page.toString()});
    }
  }

  void _loadMoreShipments() {
    if (!isLoadingMore && hasMoreData) {
      setState(() {
        isLoadingMore = true;
        currentPage++;
      });
      _fetchShipments(currentPage);
    }
  }

  void _refreshShipments() {
    setState(() {
      currentPage = 1;
      allShipments = [];
      shipments = [];
      hasMoreData = true;
      isLoadingMore = false;
    });
    _fetchShipments(currentPage);
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
                children: [const ShipmentLogo(), const SizedBox(height: 20)],
              ),
              Expanded(
                child:
                    BlocConsumer<
                      ShipmentsCalendarCubit,
                      ShipmentsCalendarState
                    >(
                      listener: (context, state) {
                        if (state is GetAllShipmentsSuccess) {
                          setState(() {
                            if (currentPage == 1) {
                              allShipments = state.shipments;
                            } else {
                              allShipments.addAll(state.shipments);
                            }
                            shipments = allShipments;
                            isLoadingMore = false;
                            hasMoreData = state.shipments.length >= 10;
                          });
                        }
                        if (state is GetAllShipmentsFailure) {
                          setState(() {
                            isLoadingMore = false;
                            if (currentPage == 1) {
                              shipments = [];
                              allShipments = [];
                            }
                          });
                          Logger().e(state.errorMessage);
                        }
                      },
                      builder: (context, state) {
                        if (state is GetAllShipmentsLoading &&
                            shipments.isEmpty) {
                          return const Center(
                            child: CustomLoadingIndicator(color: Colors.white),
                          );
                        }
                        if (state is GetAllShipmentsFailure &&
                            shipments.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.errorMessage,
                                  style: AppStyles.styleMedium18(
                                    context,
                                  ).copyWith(color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton.icon(
                                  onPressed: _refreshShipments,
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('إعادة المحاولة'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF10B981),
                                  ),
                                ),
                              ],
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
        child: RefreshIndicator(
          onRefresh: () async {
            _refreshShipments();
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(32),
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
                const SizedBox(height: 20),
                _buildPaginationInfo(),
                if (isLoadingMore)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CustomLoadingIndicator(),
                  ),
                if (!hasMoreData && shipments.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green[600],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'تم تحميل جميع الشحنات',
                          style: AppStyles.styleMedium14(
                            context,
                          ).copyWith(color: Colors.green[600]),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaginationInfo() {
    if (shipments.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withAlpha(25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF10B981).withAlpha(100)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.inventory_2, color: const Color(0xFF10B981), size: 20),
              const SizedBox(width: 8),
              Text(
                'إجمالي الشحنات: ${shipments.length}',
                style: AppStyles.styleSemiBold14(context),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.pages, color: const Color(0xFF10B981), size: 20),
              const SizedBox(width: 8),
              Text(
                'صفحة $currentPage',
                style: AppStyles.styleSemiBold14(context),
              ),
            ],
          ),
        ],
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
