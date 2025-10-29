import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/services/storage_services.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/widgets/custom_button.dart';
import 'package:supercycle_app/core/widgets/drawer/custom_drawer.dart';
import 'package:supercycle_app/core/widgets/shipment/back_and_drawer_bar.dart';
import 'package:supercycle_app/core/widgets/shipment/client_data_content.dart';
import 'package:supercycle_app/core/widgets/shipment/expandable_section.dart';
import 'package:supercycle_app/core/widgets/shipment/shipment_logo.dart';
import 'package:supercycle_app/core/widgets/shipment/notes_content.dart';
import 'package:supercycle_app/core/widgets/shipment/progress_widgets.dart';
import 'package:supercycle_app/core/widgets/custom_text_field.dart';
import 'package:supercycle_app/features/sales_process/data/models/dosh_item_model.dart';
import 'package:supercycle_app/features/sales_process/data/models/create_shipment_model.dart';
import 'package:supercycle_app/features/sales_process/presentation/widgets/entry_shipment_details_cotent.dart';
import 'package:supercycle_app/features/sales_process/presentation/widgets/sales_process_shipment_header.dart';
import 'package:supercycle_app/generated/l10n.dart';
import 'dart:io';

class SalesProcessViewBody extends StatefulWidget {
  const SalesProcessViewBody({super.key});

  @override
  State<SalesProcessViewBody> createState() => _SalesProcessViewBodyState();
}

class _SalesProcessViewBodyState extends State<SalesProcessViewBody> {
  bool isClientDataExpanded = false;
  bool isShipmentDetailsExpanded = false;
  List<String> notes = [];
  List<DoshItemModel> products = [];
  List<File> selectedImages = [];
  DateTime? selectedDateTime;
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserAddress();
  }

  void _getUserAddress() async {
    var user = await StorageServices.getUserData();
    if (user == null) {
      return;
    }
    addressController.text = user.bussinessAdress;
  }

  void _onImagesChanged(List<File> images) {
    setState(() {
      selectedImages = images;
    });
  }

  void _onDateTimeChanged(DateTime? dateTime) {
    setState(() {
      selectedDateTime = dateTime;
    });
  }

  void _onNotesChanged(List<String> notes) {
    setState(() {
      this.notes = notes;
    });
  }

  void _onProductsChanged(List<DoshItemModel> products) {
    setState(() {
      this.products = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: kGradientBackground),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Header Section (Fixed)
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const ShipmentLogo(),
                    const SizedBox(height: 15),
                    BackAndDrawerBar(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              // White Container Content (Scrollable)
              SliverFillRemaining(
                child: Container(
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
                        // تمرير قائمة الصور ودالة التحديث للـ Header
                        SalesProcessShipmentHeader(
                          selectedImages: selectedImages,
                          onImagesChanged: _onImagesChanged,
                          onDateTimeChanged: _onDateTimeChanged,
                        ),
                        const SizedBox(height: 20),
                        const ProgressBar(completedSteps: 0),
                        const SizedBox(height: 30),
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
                        const SizedBox(height: 25),
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
                            content: EntryShipmentDetailsContent(
                              products: products,
                              onProductsChanged: _onProductsChanged,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomTextField(
                              label: "العنوان",
                              hint: "عنوان الاستلام",
                              controller: addressController,
                              keyboardType: TextInputType.text,
                              icon: Icons.location_on_rounded,
                              isArabic: true,
                              enabled: true,
                              borderColor: Colors.green.shade300,
                            ),
                            const SizedBox(height: 6),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: Text(
                                "سيتم استلام الشحنة منه",
                                style: AppStyles.styleSemiBold12(
                                  context,
                                ).copyWith(color: AppColors.subTextColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        NotesContent(
                          notes: notes,
                          shipmentID: "",
                          onNotesChanged: _onNotesChanged,
                        ),
                        const SizedBox(height: 30),
                        CustomButton(
                          onPress: () {
                            _handleSubmit();
                          },
                          title: S.of(context).shipment_review,
                        ),
                        // مساحة إضافية في النهاية
                        const SizedBox(height: 40),
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

  void _toggleClientData() {
    setState(() {
      isClientDataExpanded = !isClientDataExpanded;
    });
  }

  void _toggleShipmentDetails() {
    setState(() {
      isShipmentDetailsExpanded = !isShipmentDetailsExpanded;
    });
  }

  // دالة للتعامل مع إرسال البيانات
  void _handleSubmit() {
    CreateShipmentModel shipment = CreateShipmentModel(
      customPickupAddress: addressController.text,
      requestedPickupAt: selectedDateTime ?? DateTime.now(),
      images: selectedImages,
      items: products,
      userNotes: notes.isEmpty ? "" : notes.first,
    );
    GoRouter.of(context).push(EndPoints.shipmentPreviewView, extra: shipment);
  }
}
