// views/sales_process_view_body.dart
import 'package:flutter/material.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/features/sales_process/presentation/widgets/header/sales_process_logo.dart';

// Import all the separated widgets
import '../widgets/settings_icon.dart';
import '../widgets/shipment_header.dart';
import '../widgets/notes_content.dart';
import '../widgets/progress_widgets.dart';
import '../widgets/expandable_section.dart';
import '../widgets/shipment_details_content.dart';
import '../widgets/client_data_content.dart';
import 'package:supercycle_app/features/sales_process/data/models/product.dart';
import 'package:supercycle_app/core/services/data_service.dart';

class SalesProcessViewBody extends StatefulWidget {
  const SalesProcessViewBody({super.key});

  @override
  State<SalesProcessViewBody> createState() => _SalesProcessViewBodyState();
}

class _SalesProcessViewBodyState extends State<SalesProcessViewBody> {
  // حالة توسع أقسام مختلفة
  bool isShipmentDetailsExpanded = false;
  bool isClientDataExpanded = false;

  // قائمة المنتجات في الشحنة
  late List<Product> shipmentProducts;
  List<String> notes = [
    '\n'
    'تم فحص المنتجات والتأكد من جودتها',
    'العميل طلب تأجيل التسليم ليوم الأحد القادم',
    'يفضل التعامل مع هذا العميل نقداً فقط',
  ];
  @override
  void initState() {
    super.initState();
    // تحميل البيانات من الخدمة
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

              // شعار العملية التجارية
              const SalesProcessLogo(),

              // المحتوى الرئيسي
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 60),
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
                        const SizedBox(height: 3),

                        // أيقونة الإعدادات
                        const SettingsIcon(),
                        const SizedBox(height: 5),

                        // رأس الشحنة
                        const ShipmentHeader(),
                        const SizedBox(height: 20),

                        // شريط التقدم
                        const ProgressBar(),
                        const SizedBox(height: 30),

                        // قسم تفاصيل الشحنة
                        ExpandableSection(
                          title: 'تفاصيل الشحنة',
                          iconPath: 'assets/images/Box-Perspective2.png',
                          isExpanded: isShipmentDetailsExpanded,
                          maxHeight: 220,
                          onTap: _toggleShipmentDetails,
                          content: ShipmentDetailsContent(products: shipmentProducts),
                        ),
                        const SizedBox(height: 20),

                        // قسم بيانات العميل
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

  // دالة تبديل حالة توسع تفاصيل الشحنة
  void _toggleShipmentDetails() {
    setState(() {
      isShipmentDetailsExpanded = !isShipmentDetailsExpanded;
    });
  }

  // دالة تبديل حالة توسع بيانات العميل
  void _toggleClientData() {
    setState(() {
      isClientDataExpanded = !isClientDataExpanded;
    });
  }
}