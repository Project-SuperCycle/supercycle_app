import 'package:flutter/material.dart';
import 'package:supercycle_app/features/sales_process/data/models/unit.dart';
import 'package:supercycle_app/features/sales_process/data/models/product.dart';
import 'package:supercycle_app/features/shipping_details/presentation/widgets/shipment_summary.dart';

class EntryShipmentDetailsContent extends StatefulWidget {
  final List<Product> products;
  final List<String> availableProductTypes;
  const EntryShipmentDetailsContent({
    Key? key,
    required this.products,
    this.availableProductTypes = const [ 'كرتون درجه تانيه', 'كرتون درجه اولى', 'كرتون بني', 'ورق أبيض' ],
  }) : super(key: key);

  @override
  State<EntryShipmentDetailsContent> createState() => _EntryShipmentDetailsContentState();
}

class _EntryShipmentDetailsContentState extends State<EntryShipmentDetailsContent> {
  late List<Product> editableProducts;

  @override
  void initState() {
    super.initState();
    editableProducts = List.from(widget.products);

    if (editableProducts.isEmpty) {
      editableProducts.add(
        Product(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: widget.availableProductTypes.first,
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
          type: widget.availableProductTypes.first,
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
                  final index = editableProducts.indexWhere((p) => p.id == updatedProduct.id);
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
          }).toList(),

          const SizedBox(height: 16),

          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _addProduct,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(18),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  elevation: 4,
                ),
                child: const Icon(Icons.add, size: 28),
              ),
            ),
          )
          //ShipmentSummary(products: editableProducts),
        ],
      ),
    );
  }
}

// هنا المفروض تعملي الكارد فيه Dropdown و TextField
class EditableProductCard extends StatelessWidget {
  final Product product;
  final Function(Product updatedProduct) onProductUpdated;
  final VoidCallback onProductDeleted;

  const EditableProductCard({
    Key? key,
    required this.product,
    required this.onProductUpdated,
    required this.onProductDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.green,
          width: 1
        )
      ),
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "تفاصيل المنتج",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black38),
                  onPressed: onProductDeleted,
                ),
              ],
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: product.type,
              decoration: const InputDecoration(
                labelText: "نوع المنتج",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: ['كرتون درجه تانيه', 'كرتون درجه اولى', 'كرتون بني', 'ورق أبيض']
                  .map((type) => DropdownMenuItem(
                value: type,
                child: Text(type),
              ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  onProductUpdated(product.copyWith(type: value));
                }
              },
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    initialValue: product.quantity.toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "الكمية",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    onChanged: (value) {
                      final qty = int.tryParse(value) ?? 0;
                      onProductUpdated(product.copyWith(quantity: qty));
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    value: product.unit,
                    decoration: const InputDecoration(
                      labelText: "الوحدة",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    items: [Unit.kg.abbreviation, Unit.ton.abbreviation]
                        .map((unit) => DropdownMenuItem(
                      value: unit,
                      child: Text(unit),
                    ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        onProductUpdated(product.copyWith(unit: value));
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
