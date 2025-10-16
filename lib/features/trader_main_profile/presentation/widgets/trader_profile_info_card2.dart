import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
import 'package:supercycle_app/features/sales_process/presentation/views/sales_process_view.dart';
import 'package:supercycle_app/features/shipments_calendar/data/models/shipment_model.dart';
import 'package:supercycle_app/features/shipments_calendar/presentation/widget/shipment_calendar_card.dart';

class TraderProfileInfoCard2 extends StatefulWidget {
  const TraderProfileInfoCard2({super.key});

  @override
  State<TraderProfileInfoCard2> createState() => _TraderProfileInfoCard2State();
}

class _TraderProfileInfoCard2State extends State<TraderProfileInfoCard2> {
  List<Map<String, String>> transactions = [
    {
      'shipmentNumber': 'رقم الشحنة: SN0001',
      'deliveryDate': 'تاريخ الاستلام: 15/11/2023',
      'quantity': 'الكمية: 1000 كجم',
      'price': 'السعر: 5000 جنيه',
    },
    {
      'shipmentNumber': 'رقم الشحنة: SN0002',
      'deliveryDate': 'تاريخ الاستلام: 20/11/2023',
      'quantity': 'الكمية: 2000 كجم',
      'price': 'السعر: 10000 جنيه',
    },
    {
      'shipmentNumber': 'رقم الشحنة: SN0003',
      'deliveryDate': 'تاريخ الاستلام: 25/11/2023',
      'quantity': 'الكمية: 3000 كجم',
      'price': 'السعر: 15000 جنيه',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'سجل المعاملات السابقة',
          style: AppStyles.styleSemiBold22(context),
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
              children: transactions.map((transaction) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: _buildTransactionCard(
                    context,
                    shipmentNumber: transaction['shipmentNumber']!,
                    deliveryDate: transaction['deliveryDate']!,
                    quantity: transaction['quantity']!,
                    price: transaction['price']!,
                  ),
                );
              }).toList(),
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
                  MaterialPageRoute(
                    builder: (context) => SalesProcessView(),
                  ),
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