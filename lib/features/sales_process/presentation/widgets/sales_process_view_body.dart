import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle/core/constants.dart';
import 'package:supercycle/core/routes/end_points.dart';
import 'package:supercycle/core/services/storage_services.dart';
import 'package:supercycle/core/utils/app_assets.dart';
import 'package:supercycle/core/utils/app_colors.dart';
import 'package:supercycle/core/utils/app_styles.dart';
import 'package:supercycle/core/widgets/custom_button.dart';
import 'package:supercycle/core/widgets/shipment/client_data_content.dart';
import 'package:supercycle/core/widgets/shipment/expandable_section.dart';
import 'package:supercycle/core/widgets/shipment/shipment_logo.dart';
import 'package:supercycle/core/widgets/shipment/notes_content.dart';
import 'package:supercycle/core/widgets/shipment/progress_widgets.dart';
import 'package:supercycle/core/widgets/custom_text_field.dart';
import 'package:supercycle/features/sales_process/data/models/dosh_item_model.dart';
import 'package:supercycle/features/sales_process/data/models/create_shipment_model.dart';
import 'package:supercycle/features/sales_process/presentation/widgets/entry_shipment_details_cotent.dart';
import 'package:supercycle/features/sales_process/presentation/widgets/sales_process_shipment_header.dart';
import 'package:supercycle/generated/l10n.dart';
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
  String userAddress = "";
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
    setState(() {
      userAddress = user.bussinessAdress ?? "";
      addressController.text = userAddress;
    });
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
                  children: [const ShipmentLogo(), const SizedBox(height: 20)],
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
                            title: 'بياناتي',
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

  Future<void> _handleSubmit() async {
    try {
      // إنشاء الـ shipment object
      CreateShipmentModel shipment = CreateShipmentModel(
        customPickupAddress: _handleAddress(),
        requestedPickupAt: selectedDateTime,
        images: selectedImages,
        items: products,
        userNotes: notes.isEmpty ? "" : notes.first,
      );

      // التحقق من صحة البيانات قبل الحفظ
      if (!_validateShipmentData(shipment)) {
        String error = "";
        if (shipment.requestedPickupAt == null || selectedDateTime == null) {
          error = "التاريخ مطلوب";
        } else if (shipment.customPickupAddress.isEmpty) {
          error = "العنوان مطلوب";
        } else if (shipment.items.isEmpty) {
          error = "المنتجات مطلوبة";
        } else if (shipment.images.isEmpty) {
          error = "الصور مطلوبة";
        }
        // إظهار رسالة خطأ
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
        return;
      }

      // إظهار loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // إخفاء الـ loading indicator
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // التنقل فقط إذا تم الحفظ بنجاح
      if (context.mounted) {
        GoRouter.of(
          context,
        ).push(EndPoints.traderShipmentPreviewView, extra: shipment);
      } else {
        // إظهار رسالة خطأ في حالة فشل الحفظ
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('حدث خطأ أثناء حفظ البيانات')),
          );
        }
      }
    } catch (e) {
      // إخفاء الـ loading indicator في حالة حدوث خطأ
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('حدث خطأ: ${e.toString()}')));
      }
    }
  }

  // دالة للتحقق من صحة البيانات
  bool _validateShipmentData(CreateShipmentModel shipment) {
    if (shipment.requestedPickupAt == null || selectedDateTime == null) {
      return false;
    }
    if (shipment.customPickupAddress.isEmpty) {
      return false;
    }
    if (shipment.items.isEmpty) {
      return false;
    }
    if (shipment.images.isEmpty) {
      return false;
    }
    return true;
  }

  String _handleAddress() {
    return (addressController.text.isNotEmpty)
        ? addressController.text
        : userAddress;
  }
}
