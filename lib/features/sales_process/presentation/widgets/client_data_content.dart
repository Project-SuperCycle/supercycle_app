// widgets/client_data_content.dart
import 'package:flutter/material.dart';

class ClientDataContent extends StatelessWidget {
  const ClientDataContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DataRow(label: 'اسم العميل:', value: 'شركة المستقبل للتجارة والتوريدات'),
        const SizedBox(height: 12),
        DataRow(label: 'رقم الهاتف:', value: '01234567890'),
        const SizedBox(height: 12),
        DataRow(label: 'البريد الإلكتروني:', value: 'info@future-trading.com'),
        const SizedBox(height: 12),
        DataRow(label: 'العنوان:', value: 'القاهرة - مصر الجديدة - شارع الحرية 123'),
        const SizedBox(height: 12),
        DataRow(label: 'الرقم الضريبي:', value: '123-456-789'),
        const SizedBox(height: 16),
        Divider(color: Colors.grey.shade300),
        const SizedBox(height: 16),
        DataRow(label: 'تاريخ بداية التعامل:', value: '2020/03/15'),
        const SizedBox(height: 12),
        DataRow(label: 'عدد الصفقات السابقة:', value: '47 صفقة'),
        const SizedBox(height: 12),
        DataRow(label: 'إجمالي قيمة التعاملات:', value: '2,750,000 جنيه'),
        const SizedBox(height: 12),
        DataRow(label: 'تقييم العميل:', value: '⭐⭐⭐⭐⭐ (ممتاز)'),
        const SizedBox(height: 12),
        DataRow(label: 'مدة السداد المعتادة:', value: '30 يوم'),
        const SizedBox(height: 12),
        DataRow(label: 'طريقة السداد المفضلة:', value: 'تحويل بنكي'),
        const SizedBox(height: 12),
        DataRow(label: 'اسم البنك:', value: 'البنك الأهلي المصري'),
        const SizedBox(height: 12),
        DataRow(label: 'رقم الحساب:', value: '1234567890123'),
        const SizedBox(height: 12),
        DataRow(label: 'اسم مندوب المبيعات:', value: 'أحمد محمد علي'),
        const SizedBox(height: 12),
        DataRow(label: 'رقم هاتف المندوب:', value: '01098765432'),
        const SizedBox(height: 16),
        Divider(color: Colors.grey.shade300),
        const SizedBox(height: 16),
        DataRow(label: 'ملاحظات خاصة:', value: 'عميل مميز - أولوية في التعامل'),
        const SizedBox(height: 12),
        DataRow(label: 'حالة الائتمان:', value: 'ممتازة'),
        const SizedBox(height: 12),
        DataRow(label: 'الحد الائتماني:', value: '500,000 جنيه'),
        const SizedBox(height: 20),
        // زر إلغاء
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.red.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'إلغاء',
                    style: TextStyle(
                      color: Colors.red.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DataRow extends StatelessWidget {
  final String label;
  final String value;

  const DataRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      textDirection: TextDirection.ltr,
      children: [
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}