import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle_app/core/helpers/custom_dropdown.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/widgets/custom_text_form_field.dart';
import 'package:supercycle_app/features/home/data/managers/home_cubit/home_cubit.dart';
import 'package:supercycle_app/features/home/data/models/dosh_data_model.dart';
import 'package:supercycle_app/features/sales_process/data/models/dosh_item_model.dart';
import 'package:supercycle_app/features/sales_process/data/models/unit.dart';
import 'package:supercycle_app/generated/l10n.dart';

class EditableProductCard extends StatefulWidget {
  final DoshItemModel product;
  final Function(DoshItemModel updatedProduct) onProductUpdated;
  final VoidCallback onProductDeleted;

  const EditableProductCard({
    super.key,
    required this.product,
    required this.onProductUpdated,
    required this.onProductDeleted,
  });

  @override
  State<EditableProductCard> createState() => _EditableProductCardState();
}

class _EditableProductCardState extends State<EditableProductCard> {
  String? selectedTypeId;
  List<DoshDataModel> doshData = [];
  String? selectedTypeName;
  bool isInitialized = false;
  late TextEditingController quantityController;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the current product quantity
    quantityController = TextEditingController(
      text: widget.product.quantity.toString() ?? '',
    );
  }

  @override
  void dispose() {
    // Properly dispose of the controller to prevent memory leaks
    quantityController.dispose();
    super.dispose();
  }

  void _onDropdownChanged(String? value) {
    if (value != null && mounted) {
      widget.onProductUpdated(widget.product.copyWith(name: value));
    }
  }

  String _getAveragePrice() {
    // Add null safety check for the controller
    if (!mounted) return '0.00';

    double quantity = quantityController.text.isNotEmpty
        ? double.tryParse(quantityController.text) ?? 0.0
        : 0.0;
    double price = quantity * 14.0;
    return price.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("نوع المنتج:", style: AppStyles.styleMedium14(context)),
                const SizedBox(width: 20),
                Expanded(
                  child: BlocConsumer<HomeCubit, HomeState>(
                    listener: (context, state) {
                      if (!mounted) return;

                      if (state is FetchTypesDataSuccess) {
                        setState(() {
                          doshData = state.doshData;
                          // Set initial selection if not already set
                          if (!isInitialized && doshData.isNotEmpty) {
                            selectedTypeId = doshData.first.id;
                            selectedTypeName = doshData.first.name;
                            isInitialized = true;
                          }
                        });
                      }
                      if (state is FetchTypesDataFailure) {
                        setState(() {
                          doshData = [];
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is FetchTypesDataLoading) {
                        return Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.withAlpha(100),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        );
                      }
                      if (state is FetchTypesDataSuccess &&
                          doshData.isNotEmpty) {
                        return CustomDropdown(
                          showBorder: false,
                          options: doshData.map((e) => e.name).toList(),
                          onChanged: _onDropdownChanged,
                          hintText: S.of(context).select_type,
                          initialValue: selectedTypeName,
                        );
                      }
                      // Fallback dropdown with default options
                      return CustomDropdown(
                        showBorder: false,
                        options: const ["ورق", "كرتون"],
                        onChanged: _onDropdownChanged,
                        hintText: S.of(context).select_type,
                        initialValue: selectedTypeName,
                      );
                    },
                    buildWhen: (previous, current) =>
                        current is FetchTypesDataSuccess ||
                        current is FetchTypesDataFailure ||
                        current is FetchTypesDataLoading,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextFormField(
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    labelText: "الكمية",
                    controller: quantityController,
                    onChanged: (value) {
                      if (!mounted) return null;

                      final qty = int.tryParse(value ?? '') ?? 0;
                      widget.onProductUpdated(
                        widget.product.copyWith(quantity: qty),
                      );

                      // Trigger rebuild to update average price
                      setState(() {});

                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: CustomDropdown(
                    showBorder: false,
                    initialValue: widget.product.unit,
                    options: [Unit.kg.abbreviation, Unit.ton.abbreviation],
                    onChanged: (value) {
                      if (value != null && mounted) {
                        widget.onProductUpdated(
                          widget.product.copyWith(
                            unit: value,
                          ), // Fixed: should be unit, not type
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text("متوسط السعر:", style: AppStyles.styleMedium14(context)),
                const SizedBox(width: 12),
                Text(
                  _getAveragePrice(),
                  style: AppStyles.styleMedium14(context),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              indent: 5,
              endIndent: 5,
              thickness: 2,
              radius: BorderRadiusGeometry.circular(10),
              color: Colors.grey.withAlpha(100),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => widget.onProductDeleted(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(100),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.close_rounded,
                              size: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          S.of(context).close,
                          style: AppStyles.styleMedium12(context),
                        ),
                      ],
                    ),
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
