import 'package:flutter/material.dart';
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
          width: 100,
          height: 100,
          defaultImagePath: 'assets/images/photo gallery.png',
          onImageChanged: _onImageChanged,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/images/Box-Perspective-Big.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.inventory_2_outlined,
                            color: Colors.orange,
                            size: 20,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'رقم الشحنة: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Text(
                    'لم يحدد بعد ',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        'تاريخ الاستلام: ',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: 2),
                      Text(
                        '--/--/----',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.edit_calendar_sharp,
                        color: Colors.black38 ,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}