import 'package:flutter/material.dart';
import 'package:supercycle_app/core/models/user_profile_model.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_uncontracted_message.dart';

class TraderProfileInfoCard3 extends StatelessWidget {
  final UserProfileModel user;
  const TraderProfileInfoCard3({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'بيانات التعاقد',
          style: AppStyles.styleSemiBold22(context),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        (user.role == "trader_uncontracted")
            ? TraderUncontractedMessage()
            : _buildContractInfo(context),
      ],
    );
  }

  Widget _buildContractInfo(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
              context: context,
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
              context: context,
            ),
            _divider(),
            _buildContractSection(
              icon: Icons.attach_money,
              title: 'السعر الكلي',
              content: ['السعر الكلي: 2 مليون جنيه مصري'],
              highlight: true,
              context: context,
            ),
            _divider(),
            _buildContractSection(
              icon: Icons.payment,
              title: 'طريقة الدفع',
              content: [
                'الدفعة الأولى: 700 ألف',
                'دفعتين إضافيتين حتى الدفعة الثالثة',
              ],
              context: context,
            ),
            _divider(),
            _buildContractSection(
              icon: Icons.local_shipping_outlined,
              title: 'شروط التسليم',
              content: ['المكان: فرع المعادي', 'الموعد: يوم 7 من كل شهر'],
              context: context,
            ),
            _divider(),
            _buildContractSection(
              icon: Icons.warning_amber_outlined,
              title: 'شروط خاصة',
              content: [
                'في حالة عدم الرضا عن الشحنة يتم رفضها',
                'التأخير في الشحن يترتب عليه غرامة',
              ],
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Divider(color: Colors.grey[300], thickness: 0.6),
  );

  Widget _buildContractSection({
    required String title,
    required List<String> content,
    required IconData icon,
    required BuildContext context,
    bool highlight = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withAlpha(25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFF10B981), size: 20),
            ),
            const SizedBox(width: 12),
            Text(title, style: AppStyles.styleBold16(context)),
          ],
        ),
        const SizedBox(height: 12),
        ...content.map((item) {
          final parts = item.split(':');
          final hasLabel = parts.length > 1;

          return Padding(
            padding: const EdgeInsets.only(bottom: 6, right: 48),
            child: RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                children: [
                  if (hasLabel)
                    TextSpan(
                      text: "${parts[0]}: ",
                      style: AppStyles.styleSemiBold12(context).copyWith(
                        color: highlight
                            ? const Color(0xFF059669)
                            : Colors.black,
                      ),
                    ),
                  TextSpan(
                    text: hasLabel ? parts.sublist(1).join(':') : item,
                    style: AppStyles.styleMedium12(
                      context,
                    ).copyWith(color: AppColors.subTextColor),
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
