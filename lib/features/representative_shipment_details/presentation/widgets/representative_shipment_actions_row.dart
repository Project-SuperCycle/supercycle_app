import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/core/models/single_shipment_model.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/representative_shipment_details/presentation/widgets/rep_shipment_action_modal/representative_shipment_modal.dart';

class RepresentativeShipmentActionsRow extends StatelessWidget {
  final SingleShipmentModel shipment;
  const RepresentativeShipmentActionsRow({super.key, required this.shipment});

  void _showConfirmModal(BuildContext context) {
    RepresentativeShipmentModal.show(
      context,
      actionType: ShipmentActionType.confirm,
      shipment: shipment,
      onSubmit: (File? image, String notes, double rating) {
        Logger().i('✅ Confirm Shipment');
        Logger().w("SHIPMENT ID: ${shipment.id}");
        Logger().w("IMAGE: $image");
        Logger().w("NOTES: $notes");
        Logger().w("RATING: $rating");

        // هنا أضف منطق إرسال البيانات للـ API
        // BlocProvider.of<ShipmentBloc>(context).add(
        //   ConfirmShipmentEvent(
        //     shipmentId: shipment.id,
        //     image: image!,
        //     notes: notes,
        //     rating: rating,
        //   ),
        // );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('تم تأكيد الشحنة بنجاح'),
              ],
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }

  void _showRejectModal(BuildContext context) {
    RepresentativeShipmentModal.show(
      context,
      actionType: ShipmentActionType.reject,
      shipment: shipment,
      onSubmit: (File? image, String reason, double rating) {
        Logger().i('❌ Reject Shipment');
        Logger().w("SHIPMENT ID: ${shipment.id}");
        Logger().w("IMAGE: $image");
        Logger().w("REJECTION REASON: $reason");
        Logger().w("RATING: $rating");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.cancel, color: Colors.white),
                SizedBox(width: 8),
                Text('تم رفض الشحنة'),
              ],
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => _showConfirmModal(context),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'تأكيد الشحنة',
                  style: AppStyles.styleBold14(
                    context,
                  ).copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                GoRouter.of(context).push(
                  EndPoints.representativeShipmentEditView,
                  extra: shipment,
                );
              },
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'تعديل',
                  style: AppStyles.styleBold14(
                    context,
                  ).copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.failureColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => _showRejectModal(context),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'رفض الشحنة',
                  style: AppStyles.styleBold14(
                    context,
                  ).copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
