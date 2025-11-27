import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supercycle/core/helpers/custom_loading_indicator.dart';
import 'package:supercycle/core/utils/app_assets.dart';
import 'package:supercycle/core/utils/app_colors.dart';
import 'package:supercycle/core/utils/app_styles.dart';
import 'package:supercycle/core/utils/profile_constants.dart';
import 'package:supercycle/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_cubit.dart';
import 'package:supercycle/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_state.dart';
import 'package:supercycle/features/shipments_calendar/data/models/shipment_model.dart';
import 'package:supercycle/features/shipments_calendar/presentation/widget/shipment_calendar_card.dart';

class TraderProfileInfoCard2 extends StatefulWidget {
  const TraderProfileInfoCard2({super.key});

  @override
  State<TraderProfileInfoCard2> createState() => _TraderProfileInfoCard2State();
}

class _TraderProfileInfoCard2State extends State<TraderProfileInfoCard2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'سجل المعاملات السابقة',
          style: AppStyles.styleSemiBold22(context),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withAlpha(25),
            border: Border.all(color: const Color(0xFF10B981)),
            borderRadius: BorderRadius.circular(
              ProfileConstants.cardBorderRadius,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(25),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocConsumer<ShipmentsCalendarCubit, ShipmentsCalendarState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is GetAllShipmentsFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                }
              },
              builder: (context, state) {
                if (state is GetAllShipmentsLoading) {
                  return Center(child: CustomLoadingIndicator());
                }
                if (state is GetAllShipmentsSuccess &&
                    state.shipments.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.shipments.length,
                    itemBuilder: (context, index) {
                      final transaction = state.shipments[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ShipmentsCalendarCard(shipment: transaction),
                      );
                    },
                  );
                }
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          AppAssets.boxIcon,
                          height: 100,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withAlpha(150),
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'لا يوجد معاملات',
                          style: AppStyles.styleSemiBold22(context),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
