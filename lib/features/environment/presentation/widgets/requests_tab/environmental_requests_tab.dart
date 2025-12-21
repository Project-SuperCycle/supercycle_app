import 'package:flutter/material.dart';
import 'package:supercycle/core/utils/app_colors.dart';
import 'package:supercycle/core/utils/app_styles.dart';
// Import your EcoInfoModel here
// import 'package:supercycle/features/environment/data/models/eco_info_model.dart';

class EnvironmentalRequestsTab extends StatelessWidget {
  final dynamic ecoInfoModel; // Replace with your actual model type

  const EnvironmentalRequestsTab({super.key, required this.ecoInfoModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('الطلبات البيئية', style: AppStyles.styleSemiBold16(context)),
          const SizedBox(height: 20),

          // Example requests list - Replace with your actual data
          _buildRequestsList(),
        ],
      ),
    );
  }

  Widget _buildRequestsList() {
    // TODO: Replace with actual requests from ecoInfoModel
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5, // Replace with actual count
      itemBuilder: (context, index) {
        return _buildRequestItem(
          title: 'طلب ${index + 1}',
          date: '2024-01-${index + 1}',
          status: index % 2 == 0 ? 'مكتمل' : 'قيد المراجعة',
        );
      },
    );
  }

  Widget _buildRequestItem({
    required String title,
    required String date,
    required String status,
  }) {
    final bool isCompleted = status == 'مكتمل';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(fontSize: 12, color: AppColors.subTextColor),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isCompleted
                  ? const Color(0xFF10B981).withOpacity(0.1)
                  : Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isCompleted ? const Color(0xFF10B981) : Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
