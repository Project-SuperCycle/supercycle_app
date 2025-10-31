import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supercycle_app/core/helpers/custom_loading_indicator.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
import 'package:supercycle_app/features/sales_process/presentation/views/sales_process_view.dart';
import 'package:supercycle_app/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_cubit.dart';
import 'package:supercycle_app/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_state.dart';
import 'package:supercycle_app/features/shipments_calendar/presentation/widget/shipment_calendar_card.dart';

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
    BlocProvider.of<ShipmentsCalendarCubit>(context).getAllRepShipments();
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
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionCard(
    BuildContext context, {
    required String shipmentNumber,
    required String deliveryDate,
    required String quantity,
    required String price,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF10B981).withAlpha(50)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(15),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(shipmentNumber),
            const SizedBox(height: 8),
            _buildDetailRow(deliveryDate),
            const SizedBox(height: 8),
            _buildDetailRow(quantity),
            const SizedBox(height: 8),
            _buildDetailRow(price),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SalesProcessView()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF10B981).withAlpha(50),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Text(
                  'إظهار التفاصيل',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String text) {
    final parts = text.split(':');
    final hasLabel = parts.length > 1;

    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        children: [
          if (hasLabel)
            TextSpan(
              text: "${parts[0]}: ",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          TextSpan(
            text: hasLabel ? parts.sublist(1).join(':') : text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.normal,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
