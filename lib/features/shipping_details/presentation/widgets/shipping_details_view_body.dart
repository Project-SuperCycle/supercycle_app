import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show GoRouter;
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/routes/end_points.dart' show EndPoints;
import 'package:supercycle_app/core/helpers/logo.dart';
import '../widgets/settings_icon.dart';
import '../widgets/shipment_header.dart';
import '../../../../core/helpers/notes_content.dart';
import '../../../../core/helpers/progress_widgets.dart';
import '../../../../core/helpers/expandable_section.dart';
import '../widgets/shipment_details_content.dart';
import '../../../../core/helpers/client_data_content.dart';
import 'package:supercycle_app/core/helpers/custom_back_button.dart' show CustomBackButton;
import 'package:supercycle_app/features/shipping_details/data/models/product.dart';
import 'package:supercycle_app/core/services/data_service.dart';

class ShippingDetalisViewBody extends StatefulWidget {
  const ShippingDetalisViewBody({super.key});

  @override
  State<ShippingDetalisViewBody> createState() => _ShippingDetalisViewBodyState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(gradient: kGradientBackground),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Logo(),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      textDirection: TextDirection.ltr,
                      Icons.info_outline,
                      color: Colors.black,
                    ),
                     CustomBackButton(
                      color: Colors.black,
                      size: 24,
                      onPressed: () {
                        GoRouter.of(context).pushReplacement(EndPoints.salesProcessView);
                      },
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 40),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
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
                        const SizedBox(height: 20),

                        const ProgressBar(completedSteps: 1),
                        const SizedBox(height: 30),

                        ExpandableSection(
                          title: 'تفاصيل الشحنة',
                          iconPath: 'assets/images/Box-Perspective2.png',
                          isExpanded: isShipmentDetailsExpanded,
                          maxHeight: 220,
                          onTap: _toggleShipmentDetails,
                          content: ShipmentDetailsContent(products: shipmentProducts),
                        ),
                        const SizedBox(height: 20),

                        ExpandableSection(
                          title: 'بيانات جهة التعامل',
                          iconPath: 'assets/images/Box-Perspective.png',
                          isExpanded: isClientDataExpanded,
                          maxHeight: 220,
                          onTap: _toggleClientData,
                          content: const ClientDataContent(),
                        ),

                        const SizedBox(height: 30),
                        NotesContent(notes: notes),

                        const SizedBox(height: 50),
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