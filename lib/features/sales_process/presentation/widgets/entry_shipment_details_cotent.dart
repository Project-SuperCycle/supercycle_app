import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';

import 'package:supercycle_app/features/sales_process/data/models/unit.dart';
import 'package:supercycle_app/features/sales_process/data/models/product.dart';
import 'package:supercycle_app/features/sales_process/presentation/widgets/editable_product_card.dart';

class EntryShipmentDetailsContent extends StatefulWidget {
  final List<Product> products;
  const EntryShipmentDetailsContent({super.key, required this.products});

  @override
  State<EntryShipmentDetailsContent> createState() =>
      _EntryShipmentDetailsContentState();
}

class _EntryShipmentDetailsContentState
    extends State<EntryShipmentDetailsContent> {
  late List<Product> editableProducts;
  final List<String> availableProductTypes = [
    'كرتون درجه تانيه',
    'كرتون درجه اولى',
    'كرتون بني',
    'ورق أبيض',
  ];

  @override
  void initState() {
    super.initState();
    editableProducts = List.from(widget.products);

    if (editableProducts.isEmpty) {
      editableProducts.add(
        Product(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: availableProductTypes.first,
          quantity: 0,
          unit: Unit.kg.abbreviation,
          description: '',
        ),
      );
    }
  }

  void _addProduct() {
    setState(() {
      editableProducts.add(
        Product(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: availableProductTypes.first,
          quantity: 0,
          unit: Unit.kg.abbreviation,
          description: '',
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...editableProducts.map((product) {
            return EditableProductCard(
              product: product,
              onProductUpdated: (updatedProduct) {
                setState(() {
                  final index = editableProducts.indexWhere(
                    (p) => p.id == updatedProduct.id,
                  );
                  if (index != -1) {
                    editableProducts[index] = updatedProduct;
                  }
                });
              },
              onProductDeleted: () {
                setState(() {
                  editableProducts.remove(product);
                  if (editableProducts.isEmpty) {
                    _addProduct();
                  }
                });
              },
            );
          }),
          // const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: ElevatedButton(
                onPressed: _addProduct,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryColor,
                  elevation: 4,
                ),
                child: const Icon(Icons.add, size: 30),
              ),
            ),
          ),
          //ShipmentSummary(products: editableProducts),
        ],
      ),
    );
  }
}
