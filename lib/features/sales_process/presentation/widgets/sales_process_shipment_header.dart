import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'dart:io';
import 'image_picker.dart';
import 'package:intl/intl.dart'; // إضافة هذا للتعامل مع تنسيق التاريخ

class SalesProcessShipmentHeader extends StatefulWidget {
  const SalesProcessShipmentHeader({super.key});

  @override
  State<SalesProcessShipmentHeader> createState() =>
      _SalesProcessShipmentHeaderState();
}

class _SalesProcessShipmentHeaderState
    extends State<SalesProcessShipmentHeader> {
  DateTime? selectedDate;

  void _onImageChanged(File? image) {
    // يمكنك إضافة logic هنا للتعامل مع تغيير الصورة
    // مثل حفظ الصورة أو إرسالها للسيرفر
    print('تم تغيير الصورة: ${image?.path}');
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      locale: const Locale('en', 'SA'), // لعرض التقويم باللغة العربية
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.orange, // لون الهيدر
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '--/--/----';
    // تنسيق التاريخ بالشكل المطلوب (يوم/شهر/سنة)
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
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
              const SizedBox(height: 10),
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
                    const SizedBox(width: 2),
                    Text(
                      _formatDate(selectedDate),
                      style: AppStyles.styleMedium12(context).copyWith(
                        color: selectedDate != null
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.grey.shade100,
                      ),
                      onPressed: _selectDate,
                      icon: const Icon(
                        Icons.edit_calendar_sharp,
                        color: Colors.black54,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        ImagePicker(
          defaultImagePath: AppAssets.photoGallery,
          onImageChanged: _onImageChanged,
        ),
      ],
    );
  }
}
