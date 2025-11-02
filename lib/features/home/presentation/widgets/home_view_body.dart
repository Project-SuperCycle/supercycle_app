import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle_app/features/home/presentation/widgets/home_chart/sales_chart_card.dart';
import 'package:supercycle_app/features/home/presentation/widgets/home_view_header.dart';
import 'package:supercycle_app/features/home/presentation/widgets/types_section/types_list_view.dart';
import 'package:supercycle_app/features/home/presentation/widgets/types_section/types_section_header.dart';
import 'package:supercycle_app/features/home/presentation/widgets/today_shipments_card.dart';
import 'package:supercycle_app/features/shipments_calendar/data/cubits/shipments_calendar_cubit/shipments_calendar_cubit.dart';
import 'package:supercycle_app/features/trader_shipment_details/data/cubits/notes_cubit/notes_cubit.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, required this.onDrawerPressed});
  final VoidCallback onDrawerPressed;

  @override
  Widget build(BuildContext context) {
    final todayShipments = _getTodayShipments();
    return Container(
      color: Colors.grey[50],
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeViewHeader(onDrawerPressed: onDrawerPressed),
            const SizedBox(height: 24),

            // Today's Shipments Card
            if (todayShipments.isNotEmpty) ...[
              TodayShipmentsCard(
                shipments: todayShipments,
                onShipmentTap: (shipmentId) {
                  _navigateToShipmentDetails(context, shipmentId);
                },
              ),
              const SizedBox(height: 24),
            ],

            SalesChartCard(),
            const SizedBox(height: 32),
            TypesSectionHeader(),
            const SizedBox(height: 16),
            TypesListView(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // بيانات تجريبية - استبدلها لما الـ API يبقى جاهز
  List<TodayShipment> _getTodayShipments() {
    // TODO: استبدل بالبيانات الحقيقية من API
    // مثال:
    // final provider = context.read<ShipmentsCalendarCubit>();
    // return provider.getTodayShipments();

    // بيانات تجريبية:
    return [
      TodayShipment(
        id: '12345',
        time: '10:00 صباحاً',
        location: 'القاهرة - المعادي',
      ),
      TodayShipment(
        id: '12346',
        time: '02:30 مساءً',
        location: 'الجيزة - الدقي',
      ),
      TodayShipment(
        id: '12347',
        time: '05:00 مساءً',
        location: 'الإسكندرية - سموحة',
      ),
    ];
  }

  void _navigateToShipmentDetails(BuildContext context, String shipmentId) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ),
    );

    try {
      await context.read<ShipmentsCalendarCubit>().getShipmentById(
        shipmentId: shipmentId,
      );

      await context.read<NotesCubit>().getAllNotes(
        shipmentId: shipmentId,
      );

      if (context.mounted) {
        Navigator.pop(context);

        context.pushNamed(
          'ShipmentDetails',
          extra: shipmentId,
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ: ${e.toString()}'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}