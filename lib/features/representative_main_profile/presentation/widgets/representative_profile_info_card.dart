import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supercycle/core/helpers/custom_loading_indicator.dart';
import 'package:supercycle/core/utils/app_assets.dart';
import 'package:supercycle/core/utils/app_styles.dart';
import 'package:supercycle/core/utils/profile_constants.dart';
import 'package:supercycle/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_cubit.dart';
import 'package:supercycle/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_state.dart';
import 'package:supercycle/features/shipments_calendar/presentation/widget/shipment_calendar_card.dart';

class RepresentativeProfileInfoCard extends StatefulWidget {
  const RepresentativeProfileInfoCard({super.key});

  @override
  State<RepresentativeProfileInfoCard> createState() =>
      _RepresentativeProfileInfoCardState();
}

class _RepresentativeProfileInfoCardState
    extends State<RepresentativeProfileInfoCard> {
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
                color: Colors.grey.withAlpha(25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
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
                  ),
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
            buildWhen: (previous, current) =>
                current is GetAllShipmentsLoading ||
                current is GetAllShipmentsSuccess ||
                current is GetAllShipmentsFailure,
          ),
        ),
      ],
    );
  }
}
