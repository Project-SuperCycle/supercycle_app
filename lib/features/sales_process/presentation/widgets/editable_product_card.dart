import 'package:flutter/material.dart';
import 'package:supercycle_app/core/helpers/custom_dropdown.dart';
import 'package:supercycle_app/core/services/dosh_types_manager.dart';
import 'package:supercycle_app/core/services/services_locator.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/widgets/custom_text_form_field.dart';
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
  late TextEditingController quantityController;
  String? selectedTypeName;
  String averagePrice = '0.00';
  bool _isInitializing = true;
  bool _isUpdating = false;

  static const EdgeInsets _cardPadding = EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 8.0,
  );
  static const EdgeInsets _cardMargin = EdgeInsets.only(bottom: 12);

  @override
  void initState() {
    super.initState();
    _initializeController();
    _setInitialTypeName();

    // Defer the initial price calculation to avoid calling callbacks during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _calculateAndUpdateAveragePrice();
        _isInitializing = false;
      }
    });
  }

  void _initializeController() {
    quantityController = TextEditingController(
      text: widget.product.quantity == 0
          ? ''
          : widget.product.quantity.toString(),
    );
    quantityController.addListener(_onQuantityChanged);
  }

  void _setInitialTypeName() {
    // Get available type options
    final typeOptions = _getTypeOptions();

    // Set initial type name if product has a name and it exists in options
    if (widget.product.name.isNotEmpty &&
        typeOptions.contains(widget.product.name)) {
      selectedTypeName = widget.product.name;
    } else if (typeOptions.isNotEmpty && widget.product.name.isNotEmpty) {
      // If the product name doesn't exist in options, try to find a similar one
      final similarType = typeOptions.firstWhere(
        (type) =>
            type.toLowerCase().contains(widget.product.name.toLowerCase()),
        orElse: () => typeOptions.first,
      );
      selectedTypeName = similarType;
    } else {
      selectedTypeName = null;
    }
  }

  @override
  void dispose() {
    quantityController.removeListener(_onQuantityChanged);
    quantityController.dispose();
    super.dispose();
  }

  void _onQuantityChanged() {
    if (_isInitializing || _isUpdating || !mounted) return;
    _calculateAndUpdateAveragePrice();
  }

  void _onTypeChanged(String? value) {
    if (value == null || !mounted || _isUpdating) return;

    setState(() {
      selectedTypeName = value;
    });

    _calculateAndUpdateAveragePrice();
    _safeUpdateProduct(widget.product.copyWith(name: value));
  }

  void _onUnitChanged(String? value) {
    if (value == null || !mounted || _isUpdating) return;
    _safeUpdateProduct(widget.product.copyWith(unit: value));
  }

  void _calculateAndUpdateAveragePrice() {
    if (!mounted || _isUpdating) return;

    final quantityText = quantityController.text;
    if (quantityText.isEmpty || selectedTypeName == null) {
      if (mounted) {
        setState(() {
          averagePrice = '0.00';
        });
      }
      return;
    }

    final quantity = double.tryParse(quantityText) ?? 0.0;
    final unitPrice = _getPrice(selectedTypeName!);
    final totalPrice = quantity * unitPrice;

    if (mounted) {
      setState(() {
        averagePrice = totalPrice.toStringAsFixed(2);
      });
    }

    // Only update if not initializing and quantity actually changed
    if (!_isInitializing && quantity != widget.product.quantity) {
      _safeUpdateProduct(widget.product.copyWith(quantity: quantity));
    }
  }

  void _safeUpdateProduct(DoshItemModel updatedProduct) {
    if (_isUpdating || _isInitializing || !mounted) return;

    _isUpdating = true;
    // Use Future.microtask to defer the callback
    Future.microtask(() {
      if (mounted) {
        widget.onProductUpdated(updatedProduct);
      }
      _isUpdating = false;
    });
  }

  void _safeDeleteProduct() {
    if (_isUpdating || !mounted) return;

    _isUpdating = true;
    // Use Future.microtask to defer the callback
    Future.microtask(() {
      if (mounted) {
        widget.onProductDeleted();
      }
      _isUpdating = false;
    });
  }

  List<String> _getTypeOptions() {
    try {
      var typesList = getIt<DoshTypesManager>().typesList
          .map((type) => type.name)
          .where((name) => name.isNotEmpty) // Filter out empty names
          .toSet() // Remove duplicates
          .toList();

      // Sort the list for consistency
      typesList.sort();
      return typesList;
    } catch (e) {
      print('Error getting type options: $e');
      return [];
    }
  }

  num _getPrice(String name) {
    try {
      var price = getIt<DoshTypesManager>().typesList
          .firstWhere((type) => type.name == name)
          .price;
      return price;
    } catch (e) {
      print('Error getting price for $name: $e');
      return 0;
    }
  }

  List<String> _getUnitOptions() {
    return [Unit.kg.abbreviation, Unit.ton.abbreviation];
  }

  // Helper method to get valid initial value for type dropdown
  String? _getValidTypeInitialValue() {
    final options = _getTypeOptions();
    if (options.isEmpty) return null;

    // Return selectedTypeName only if it exists in options
    if (selectedTypeName != null && options.contains(selectedTypeName)) {
      return selectedTypeName;
    }

    return null;
  }

  // Helper method to get valid initial value for unit dropdown
  String _getValidUnitInitialValue() {
    final options = _getUnitOptions();

    // Return widget.product.unit only if it exists in options
    if (options.contains(widget.product.unit)) {
      return widget.product.unit ?? "";
    }

    // Default to first unit if current unit is invalid
    return options.first;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: _cardMargin,
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: _cardPadding,
        child: Column(
          children: [
            _buildTypeSelection(context),
            const SizedBox(height: 16),
            _buildQuantityAndUnitRow(context),
            const SizedBox(height: 16),
            _buildAveragePriceRow(context),
            const SizedBox(height: 10),
            _buildDivider(),
            _buildDeleteButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeSelection(BuildContext context) {
    return Row(
      children: [
        Text("نوع المنتج:", style: AppStyles.styleMedium14(context)),
        const SizedBox(width: 20),
        Expanded(
          child: CustomDropdown(
            showBorder: false,
            options: _getTypeOptions(),
            onChanged: _onTypeChanged,
            hintText: S.of(context).select_type,
            initialValue:
                _getValidTypeInitialValue(), // Use validated initial value
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityAndUnitRow(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: _buildQuantityField(context)),
        const SizedBox(width: 12),
        Expanded(flex: 2, child: _buildUnitDropdown(context)),
      ],
    );
  }

  Widget _buildQuantityField(BuildContext context) {
    return CustomTextFormField(
      keyboardType: const TextInputType.numberWithOptions(
        signed: false,
        decimal: true,
      ),
      labelText: "الكمية",
      controller: quantityController,
    );
  }

  Widget _buildUnitDropdown(BuildContext context) {
    return CustomDropdown(
      showBorder: false,
      initialValue: _getValidUnitInitialValue(), // Use validated initial value
      options: _getUnitOptions(),
      onChanged: _onUnitChanged,
    );
  }

  Widget _buildAveragePriceRow(BuildContext context) {
    return Row(
      children: [
        Text("متوسط السعر:", style: AppStyles.styleMedium14(context)),
        const SizedBox(width: 12),
        Text(
          averagePrice,
          style: AppStyles.styleMedium14(context).copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          "جنيه",
          style: AppStyles.styleMedium12(
            context,
          ).copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(
      indent: 5,
      endIndent: 5,
      thickness: 2,
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: _safeDeleteProduct,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDeleteIcon(),
                const SizedBox(width: 5),
                Text(
                  S.of(context).close,
                  style: AppStyles.styleMedium12(
                    context,
                  ).copyWith(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeleteIcon() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.red.withAlpha(50),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.red.withAlpha(150), width: 1),
      ),
      child: const Icon(Icons.close_rounded, size: 16, color: Colors.red),
    );
  }
}
