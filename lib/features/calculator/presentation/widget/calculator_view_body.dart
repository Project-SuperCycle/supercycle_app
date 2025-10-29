import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/helpers/custom_back_button.dart';
import 'package:supercycle_app/core/helpers/custom_dropdown.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/widgets/drawer/custom_drawer.dart';
import 'package:supercycle_app/core/widgets/shipment/back_and_drawer_bar.dart';

class CalculatorViewBody extends StatefulWidget {
  const CalculatorViewBody({super.key});

  @override
  State<CalculatorViewBody> createState() => _CalculatorViewBodyState();
}

class _CalculatorViewBodyState extends State<CalculatorViewBody> {
  String? selectedType;
  final TextEditingController quantityController = TextEditingController();

  final Map<String, double> productTypes = {
    'Premium Coffee': 25.99,
    'Organic Rice': 8.50,
    'Fresh Salmon': 32.75,
    'Imported Cheese': 45.20,
    'Exotic Fruits': 18.90,
    'Organic Nuts': 28.40,
  };

  double get pricePerKg =>
      selectedType != null ? productTypes[selectedType]! : 0.0;

  double get totalPrice {
    if (quantityController.text.isEmpty) return 0.0;
    final quantity = double.tryParse(quantityController.text) ?? 0.0;
    return quantity * pricePerKg;
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      body: Container(
        decoration: const BoxDecoration(gradient: kGradientBackground),
        child: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                // ======= Header & Back Button =======
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppAssets.logoName,
                          fit: BoxFit.contain,
                          scale: 6.0,
                        ),
                        const SizedBox(width: 5),
                        Image.asset(
                          AppAssets.logoIcon,
                          fit: BoxFit.contain,
                          scale: 7.5,
                        ),
                      ],
                    ),
                  ),
                ),

                BackAndDrawerBar(),

                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Card(
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 500),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // ======= Card Header =======
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF059669),
                                      Color(0xFF10B981)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.calculate,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          'إجمالي الشحنة',
                                          style: AppStyles.styleBold24(context)
                                              .copyWith(
                                            color: Colors.white,
                                            fontSize: 28,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'احسب تكلفة منتجك على الفور',
                                      style: AppStyles.styleSemiBold14(context)
                                          .copyWith(
                                        color: Colors.white.withAlpha(200),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // ======= Card Body =======
                              Padding(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // --- Dropdown ---
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.inventory_2,
                                          color: AppColors.primaryColor,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'نوع الدشت',
                                          style:
                                          AppStyles.styleSemiBold14(context),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    CustomDropdown(
                                      options:
                                      productTypes.keys.map((e) => e).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          selectedType = val;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 25),

                                    // --- Quantity Input ---
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.scale,
                                          color: AppColors.primaryColor,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'الكمية (كجم)',
                                          style:
                                          AppStyles.styleSemiBold14(context),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.grey.withAlpha(200),
                                          width: 1,
                                        ),
                                      ),
                                      child: TextField(
                                        controller: quantityController,
                                        keyboardType:
                                        const TextInputType.numberWithOptions(
                                          decimal: true,
                                        ),
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 16,
                                          ),
                                          border: InputBorder.none,
                                          hintText: 'ادخل الكمية ...',
                                        ),
                                        style:
                                        AppStyles.styleMedium14(context),
                                        onChanged: (value) => setState(() {}),
                                      ),
                                    ),

                                    const SizedBox(height: 30),

                                    // --- Price Display Area ---
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD1FAE5)
                                            .withAlpha(100),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: const Color(0xFF6EE7B7),
                                          width: 1.5,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(25),
                                      child: Column(
                                        children: [
                                          // Price per kg
                                          Text(
                                            'سعر الكجم',
                                            style: AppStyles.styleSemiBold16(
                                                context),
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              ShaderMask(
                                                shaderCallback: (bounds) =>
                                                    const LinearGradient(
                                                      colors: [
                                                        Color(0xFF059669),
                                                        Color(0xFF10B981),
                                                      ],
                                                    ).createShader(bounds),
                                                child: Text(
                                                  pricePerKg.toStringAsFixed(2),
                                                  style: AppStyles.styleBold24(
                                                      context)
                                                      .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 36,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                '/كجم',
                                                style: AppStyles.styleSemiBold20(
                                                  context,
                                                ).copyWith(
                                                  color: AppColors.subTextColor,
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 20),

                                          // Divider
                                          Container(
                                            height: 2,
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFF059669),
                                                  Color(0xFF10B981),
                                                ],
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(1),
                                            ),
                                          ),

                                          const SizedBox(height: 20),

                                          // Total Price
                                          Text(
                                            'السعر الإجمالي',
                                            style: AppStyles.styleSemiBold16(
                                                context),
                                          ),
                                          const SizedBox(height: 12),
                                          Container(
                                            decoration: BoxDecoration(
                                              gradient: kGradientContainer,
                                              borderRadius:
                                              BorderRadius.circular(15),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 30,
                                              vertical: 10,
                                            ),
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                totalPrice.toStringAsFixed(2),
                                                style: AppStyles.styleBold24(
                                                    context)
                                                    .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
