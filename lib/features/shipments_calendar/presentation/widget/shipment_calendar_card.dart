import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle/core/routes/end_points.dart';
import 'package:supercycle/core/services/storage_services.dart';
import 'package:supercycle/core/utils/app_colors.dart';
import 'package:supercycle/core/utils/app_styles.dart';
import 'package:supercycle/features/sign_in/data/models/logined_user_model.dart';
import 'package:supercycle/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_cubit.dart';
import 'package:supercycle/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_state.dart';
import 'package:supercycle/features/shipments_calendar/data/models/shipment_model.dart';

class ShipmentsCalendarCard extends StatefulWidget {
  final ShipmentModel shipment;
  const ShipmentsCalendarCard({super.key, required this.shipment});

  @override
  State<ShipmentsCalendarCard> createState() => _ShipmentsCalendarCardState();
}

class _ShipmentsCalendarCardState extends State<ShipmentsCalendarCard> {
  String userRole = "";
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  void dispose() {
    _hasNavigated = false;
    super.dispose();
  }

  void loadUserData() async {
    LoginedUserModel? user = await StorageServices.getUserData();
    if (user != null && mounted) {
      setState(() {
        userRole = user.role ?? "";
      });
    }
  }

  void _showShipmentDetails(BuildContext context) {
    _hasNavigated = false;
    BlocProvider.of<ShipmentsCalendarCubit>(
      context,
    ).getShipmentById(shipmentId: widget.shipment.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShipmentsCalendarCubit, ShipmentsCalendarState>(
      // ✅ استخدم listenWhen عشان نتحكم في متى الـ listener يتنفذ
      listenWhen: (previous, current) {
        // الـ listener يتنفذ بس لو الـ state اتغيرت فعلاً
        return previous != current;
      },
      listener: (context, state) {
        if (state is GetShipmentSuccess && !_hasNavigated) {
          // ✅ تأكد إن الـ navigation لسه ما حصلش
          _hasNavigated = true;

          final targetRoute = (userRole == 'representative')
              ? EndPoints.representativeShipmentDetailsView
              : EndPoints.traderShipmentDetailsView;

          // ✅ استخدم go بدل push عشان ما يعملش stack
          GoRouter.of(context).push(targetRoute, extra: state.shipment);
        }

        if (state is GetShipmentFailure && mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      child: Card(
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
                                  widget.shipment.shipmentNumber,
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
                              _formatTimeToArabic(
                                widget.shipment.requestedPickupAt,
                              ),
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
                            widget.shipment.totalQuantityKg.toString(),
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
                            widget.shipment.customPickupAddress,
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
                            widget.shipment.status.toUpperCase(),
                            style: AppStyles.styleMedium14(context).copyWith(
                              color: (widget.shipment.status == 'Delivered')
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
      ),
    );
  }

  String _formatTimeToArabic(DateTime dateTime) {
    int hour = dateTime.hour - 2;
    int displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    String period = hour < 12 ? "صباحا" : "مساءا";
    return "$displayHour $period";
  }
}
