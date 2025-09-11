import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/contact_strings.dart';

class MerchantQuestionWidget extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?> onChanged;
  final bool isArabic;
  final bool enabled;

  const MerchantQuestionWidget({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.isArabic,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: enabled ? Color(0xFF3BC577) : Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ContactStrings.get('merchantQuestion', isArabic),
            style: TextStyle(
              color: enabled ? Color(0xFF3BC577): Colors.grey.shade500,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: RadioListTile<bool>(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    ContactStrings.get('yes', isArabic),
                    style: TextStyle(
                      fontSize: 16,
                      color: enabled ? Colors.black87 : Colors.grey.shade500,
                    ),
                  ),
                  value: true,
                  groupValue: value,
                  activeColor: Color(0xFF3BC577),
                  onChanged: enabled ? onChanged : null,
                ),
              ),
              Expanded(
                child: RadioListTile<bool>(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    ContactStrings.get('no', isArabic),
                    style: TextStyle(
                      fontSize: 16,
                      color: enabled ? Colors.black87 : Colors.grey.shade500,
                    ),
                  ),
                  value: false,
                  groupValue: value,
                  activeColor: Color(0xFF3BC577),
                  onChanged: enabled ? onChanged : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}