import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/functions/shipment_manager.dart';
import 'package:supercycle_app/core/helpers/custom_back_button.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/widgets/custom_text_field.dart';
import 'package:supercycle_app/core/widgets/shipment/client_data_content.dart';
import 'package:supercycle_app/core/widgets/shipment/expandable_section.dart';
import 'package:supercycle_app/core/widgets/shipment/notes_content.dart';
import 'package:supercycle_app/core/widgets/shipment/progress_widgets.dart';
import 'package:supercycle_app/core/widgets/shipment/shipment_logo.dart';
import 'package:supercycle_app/features/shipment_details/data/models/single_shipment_model.dart';
import 'package:supercycle_app/features/shipment_details/presentation/widgets/shipment_details_settings_icon.dart';
import 'package:supercycle_app/features/shipment_details/presentation/widgets/shipment_details_header.dart';
import 'package:supercycle_app/features/shipment_preview/data/cubits/create_shipment_cubit/create_shipment_cubit.dart';
import 'package:supercycle_app/features/shipment_preview/presentation/widgets/shipment_review_content.dart';

class ShipmentDetailsViewBody extends StatefulWidget {
  const ShipmentDetailsViewBody({super.key, required this.shipment});
  final SingleShipmentModel shipment;

  @override
  State<ShipmentDetailsViewBody> createState() =>
      _ShipmentDetailsViewBodyState();
}

class _ShipmentDetailsViewBodyState extends State<ShipmentDetailsViewBody> {
  bool isShipmentDetailsExpanded = false;
  bool isClientDataExpanded = false;
  List<String> notes = [];

  @override
  void initState() {
    super.initState();
    notes.add(widget.shipment.userNotes);
  }

  Future<FormData> createFormData() async {
    List<File> images = widget.shipment.images;
    List<MultipartFile> imagesFiles =
        await ShipmentManager.createMultipartImages(images: images);
    // Create FormData
    final formData = FormData.fromMap({
      ...widget.shipment.toMap(),
      'uploadedImages': imagesFiles, // Add the converted MultipartFiles
    });
    return formData;
  }

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
                          child: const ShipmentDetailsSettingsIcon(),
                        ),
                        ShipmentDetailsHeader(shipment: widget.shipment),
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
                            content: ShipmentReviewContent(
                              items: widget.shipment.items,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
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
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomTextField(
                              label: "العنوان",
                              hint: widget.shipment.customPickupAddress,
                              keyboardType: TextInputType.text,
                              icon: Icons.location_on_rounded,
                              isArabic: true,
                              enabled: false,
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
                        const SizedBox(height: 20),
                        NotesContent(
                          notes: notes,
                          shipmentID: widget.shipment.id,
                          onNotesChanged: (notes) {},
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
