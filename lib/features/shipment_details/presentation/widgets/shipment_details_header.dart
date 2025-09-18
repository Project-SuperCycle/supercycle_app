import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/shipment_details/data/models/shipment_model.dart';
import 'package:supercycle_app/features/shipment_details/presentation/widgets/network_images_preview_dialog.dart';

class ShipmentDetailsHeader extends StatelessWidget {
  const ShipmentDetailsHeader({super.key, required this.shipment});
  final ShipmentModel shipment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    child: Image.asset(
                      AppAssets.boxPerspective,
                      width: 25,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.inventory_2_outlined,
                          color: Colors.orange,
                          size: 20,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'رقم الشحنة: ',
                    style: AppStyles.styleSemiBold18(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "لم يحدد بعد",
                    style: AppStyles.styleSemiBold18(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "لم تحدد بعد",
                style: AppStyles.styleSemiBold16(
                  context,
                ).copyWith(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'تاريخ الاستلام: ',
                    style: AppStyles.styleSemiBold14(context),
                  ),
                  Text(
                    _formatDateTime(shipment.requestedPickupAt),
                    style: AppStyles.styleSemiBold14(
                      context,
                    ).copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () =>
              _showImagesPreview(context, images: shipment.uploadedImages),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.asset(
                    AppAssets.photoGallery,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(color: Colors.grey.shade200),
                        child: const Icon(
                          Icons.image_outlined,
                          size: 40,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                  if (shipment.images.isNotEmpty)
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(350),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${shipment.images.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showImagesPreview(
    BuildContext context, {
    required List<String> images,
  }) {
    if (images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا توجد صور للعرض'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black26,
      builder: (BuildContext context) {
        return NetworkImagesPreviewDialog(images: images);
      },
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '--/--/---- --:--';
    final DateTime adjustedDateTime = dateTime.subtract(Duration(hours: 2));
    return DateFormat('dd/MM/yyyy HH:mm').format(adjustedDateTime);
  }
}
