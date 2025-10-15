import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
import 'package:supercycle_app/features/sales_process/presentation/views/sales_process_view.dart';

class RepresentativeProfileInfoCard extends StatelessWidget {
  const RepresentativeProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'سجل المعاملات السابقة',
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
            borderRadius: BorderRadius.circular(
              ProfileConstants.cardBorderRadius,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildTransactionCard(
                  context,
                  shipmentNumber: 'رقم الشحنة: 001',
                  deliveryDate: 'تاريخ الاستلام: 15/11/2023',
                  quantity: 'الكمية: 25',
                  price: 'السعر: 1500 ريال',
                ),
                const SizedBox(height: 15),
                _buildTransactionCard(
                  context,
                  shipmentNumber: 'رقم الشحنة: 002',
                  deliveryDate: 'تاريخ الاستلام: 20/11/2023',
                  quantity: 'الكمية: 30',
                  price: 'السعر: 2000 ريال',
                ),
                const SizedBox(height: 15),
                _buildTransactionCard(
                  context,
                  shipmentNumber: 'رقم الشحنة: 003',
                  deliveryDate: 'تاريخ الاستلام: 25/11/2023',
                  quantity: 'الكمية: 40',
                  price: 'السعر: 2500 ريال',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionCard(
    BuildContext context, {
    required String shipmentNumber,
    required String deliveryDate,
    required String quantity,
    required String price,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(shipmentNumber),
            const SizedBox(height: 8),
            _buildDetailRow(deliveryDate),
            const SizedBox(height: 8),
            _buildDetailRow(quantity),
            const SizedBox(height: 8),
            _buildDetailRow(price),
            const SizedBox(height: 15),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SalesProcessView()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFF16A243),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'إظهار التفاصيل',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String text) {
    final parts = text.split(':');
    final hasLabel = parts.length > 1;

    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        children: [
          if (hasLabel)
            TextSpan(
              text: "${parts[0]}: ",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          TextSpan(
            text: hasLabel ? parts.sublist(1).join(':') : text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.normal,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
