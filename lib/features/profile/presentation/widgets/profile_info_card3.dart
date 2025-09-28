import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';

class ProfileInfoCard3 extends StatelessWidget {
  const ProfileInfoCard3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'بيانات التعاقد',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xE4DDFFE7),
            border: Border.all(color: Color(0xFF16A243)),
            borderRadius: BorderRadius.circular(ProfileConstants.cardBorderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildContractSection(
                  icon: Icons.calendar_today,
                  title: 'مدة التعاقد',
                  content: [
                    'تاريخ بدء التعاقد: 7 يوليو 2025',
                    'مدة التعاقد: 3 شهور',
                  ],
                ),
                _divider(),
                _buildContractSection(
                  icon: Icons.article_outlined,
                  title: 'الشروط العامة',
                  content: [
                    'الأنواع: كرتون بنى - ورق ابيض',
                    'الكمية الكلية: 70 (30 في الأسبوع الأول - 40 في التالي)',
                    'التسليم: 50 من الأول - 15 من التالي',
                    'بدء الشراء من الأسبوع الثالث',
                  ],
                ),
                _divider(),
                _buildContractSection(
                  icon: Icons.attach_money,
                  title: 'السعر الكلي',
                  content: [
                    'السعر الكلي: 2 مليون جنيه مصري',
                  ],
                  highlight: true,
                ),
                _divider(),
                _buildContractSection(
                  icon: Icons.payment,
                  title: 'طريقة الدفع',
                  content: [
                    'الدفعة الأولى: 700 ألف',
                    'دفعتين إضافيتين حتى الدفعة الثالثة',
                  ],
                ),
                _divider(),
                _buildContractSection(
                  icon: Icons.local_shipping_outlined,
                  title: 'شروط التسليم',
                  content: [
                    'المكان: فرع المعادي',
                    'الموعد: يوم 7 من كل شهر',
                  ],
                ),
                _divider(),
                _buildContractSection(
                  icon: Icons.warning_amber_outlined,
                  title: 'شروط خاصة',
                  content: [
                    'في حالة عدم الرضا عن الشحنة يتم رفضها',
                    'التأخير في الشحن يترتب عليه غرامة',
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _divider() => const Padding(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: Divider(
      color: Colors.grey,
      thickness: 0.6,
    ),
  );

  Widget _buildContractSection({
    required String title,
    required List<String> content,
    required IconData icon,
    bool highlight = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.green.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        ...content.map((item) {
          final parts = item.split(':');
          final hasLabel = parts.length > 1;

          return Padding(
            padding: const EdgeInsets.only(bottom: 6, right: 28),
            child: RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                children: [
                  if (hasLabel)
                    TextSpan(
                      text: "${parts[0]}: ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: highlight ? Colors.green.shade800 : Colors.black,
                      ),
                    ),
                  TextSpan(
                    text: hasLabel ? parts.sublist(1).join(':') : item,
                    style: TextStyle(
                      fontSize: 14,
                      color: highlight ? Colors.green.shade800 : Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
