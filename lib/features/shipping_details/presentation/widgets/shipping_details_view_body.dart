import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/helpers/custom_back_button.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/widgets/custom_button.dart';
import 'package:supercycle_app/core/widgets/shipment/client_data_content.dart';
import 'package:supercycle_app/core/widgets/shipment/expandable_section.dart';
import 'package:supercycle_app/core/widgets/shipment/notes_content.dart';
import 'package:supercycle_app/core/widgets/shipment/progress_widgets.dart';
import 'package:supercycle_app/core/widgets/shipment/shipment_logo.dart';
import 'package:supercycle_app/features/shipping_details/data/models/product.dart';
import 'package:supercycle_app/core/services/data_service.dart';
import 'package:supercycle_app/features/shipping_details/presentation/widgets/settings_icon.dart';
import 'package:supercycle_app/features/shipping_details/presentation/widgets/shipment_details_content.dart';
import 'package:supercycle_app/features/shipping_details/presentation/widgets/shipment_header.dart';
import 'package:supercycle_app/generated/l10n.dart';

class ShippingDetalisViewBody extends StatefulWidget {
  const ShippingDetalisViewBody({super.key});

  @override
  State<ShippingDetalisViewBody> createState() =>
      _ShippingDetalisViewBodyState();
}

class _ShippingDetalisViewBodyState extends State<ShippingDetalisViewBody> {
  bool isShipmentDetailsExpanded = false;
  bool isClientDataExpanded = false;
  late List<Product> shipmentProducts;
  List<String> notes = [
    'تم فحص المنتجات والتأكد من جودتها',
    'العميل طلب تأجيل التسليم ليوم الأحد القادم',
    'يفضل التعامل مع هذا العميل نقداً فقط',
  ];

  @override
  void initState() {
    super.initState();
    shipmentProducts = DataService.getSampleProducts();
  }

  void _confirmProcess() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(gradient: kGradientBackground),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // Header Section (Fixed)
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const ShipmentLogo(),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            textDirection: TextDirection.ltr,
                            Icons.info_outline,
                            size: 25,
                            color: Colors.white,
                          ),
                          CustomBackButton(color: Colors.white, size: 25),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // White Container Content (Scrollable)
              SliverFillRemaining(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: const SettingsIcon(),
                        ),
                        const ShipmentHeader(),
                        const SizedBox(height: 16),
                        const ProgressBar(completedSteps: 1),
                        const SizedBox(height: 20),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ExpandableSection(
                            title: 'تفاصيل الشحنة',
                            iconPath: AppAssets.boxPerspective,
                            isExpanded: isShipmentDetailsExpanded,
                            maxHeight: 320,
                            onTap: _toggleShipmentDetails,
                            content: ShipmentDetailsContent(
                              products: shipmentProducts,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ExpandableSection(
                            title: 'بيانات جهة التعامل',
                            iconPath: AppAssets.entityCard,
                            isExpanded: isClientDataExpanded,
                            maxHeight: 320,
                            onTap: _toggleClientData,
                            content: const ClientDataContent(),
                          ),
                        ),
                        const SizedBox(height: 30),
                        NotesContent(notes: notes, shipmentID: ""),
                        const SizedBox(height: 20),
                        CustomButton(
                          onPress: _confirmProcess,
                          title: S.of(context).confirm_process,
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleShipmentDetails() {
    setState(() {
      isShipmentDetailsExpanded = !isShipmentDetailsExpanded;
    });
  }

  void _toggleClientData() {
    setState(() {
      isClientDataExpanded = !isClientDataExpanded;
    });
  }
}
