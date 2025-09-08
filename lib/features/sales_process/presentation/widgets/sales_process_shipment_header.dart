import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'dart:io';
import 'image_picker.dart';

class SalesProcessShipmentHeader extends StatelessWidget {
  const SalesProcessShipmentHeader({super.key});

  void _onImageChanged(File? image) {
    // يمكنك إضافة logic هنا للتعامل مع تغيير الصورة
    // مثل حفظ الصورة أو إرسالها للسيرفر
    print('تم تغيير الصورة: ${image?.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        ImagePicker(
          defaultImagePath: AppAssets.photoGallery,
          onImageChanged: _onImageChanged,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: ClipRRect(
                        child: Image.asset(
                          AppAssets.boxPerspective,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.inventory_2_outlined,
                              color: Colors.orange,
                              size: 25,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'رقم الشحنة: ',
                      style: AppStyles.styleSemiBold18(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'لم يحدد بعد ',
                      style: AppStyles.styleSemiBold12(
                        context,
                      ).copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  children: [
                    Text(
                      'تاريخ الاستلام:',
                      style: AppStyles.styleMedium12(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 2),
                    Text(
                      '--/--/----',
                      style: AppStyles.styleMedium12(
                        context,
                      ).copyWith(color: Colors.grey),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.edit_calendar_sharp, color: Colors.black38),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
