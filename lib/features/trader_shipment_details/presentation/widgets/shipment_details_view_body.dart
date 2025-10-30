import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/helpers/custom_back_button.dart';
import 'package:supercycle_app/core/models/single_shipment_model.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/widgets/custom_text_field.dart';
import 'package:supercycle_app/core/widgets/shipment/back_and_drawer_bar.dart';
import 'package:supercycle_app/core/widgets/drawer/custom_drawer.dart';
import 'package:supercycle_app/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:supercycle_app/core/widgets/shipment/client_data_content.dart';
import 'package:supercycle_app/core/widgets/shipment/expandable_section.dart';
import 'package:supercycle_app/core/widgets/shipment/progress_widgets.dart';
import 'package:supercycle_app/core/widgets/shipment/shipment_logo.dart';
import 'package:supercycle_app/features/trader_shipment_details/presentation/widgets/shipment_details_notes.dart';
import 'package:supercycle_app/features/trader_shipment_details/presentation/widgets/shipment_details_settings_icon.dart';
import 'package:supercycle_app/features/trader_shipment_details/presentation/widgets/shipment_details_header.dart';
import 'package:supercycle_app/features/shipment_preview/presentation/widgets/shipment_review_content.dart';
import 'package:supercycle_app/features/trader_shipment_details/presentation/widgets/representative_card.dart';

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

  int _page = 3;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void _onNavigationTap(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      key: _scaffoldKey,
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
                    BackAndDrawerBar(),
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
                        (widget.shipment.status == 'pending')
                            ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ShipmentDetailsSettingsIcon(
                            shipment: widget.shipment,
                          ),
                        )
                            : const SizedBox.shrink(),
                        ShipmentDetailsHeader(shipment: widget.shipment),
                        const SizedBox(height: 16),
                        const ProgressBar(completedSteps: 1),
                        const SizedBox(height: 20),

                        // Representative Card
                       if (widget.shipment.representitive != null)
                          RepresentativeCard(
                            representativeName: widget.shipment.representitive!.name,
                            representativePhone: widget.shipment.representitive!.phone,
                            representativeImage: widget.shipment.representitive!.image,
                          ),

                        // // Representative Card (مؤقت للتعديل)
                        // RepresentativeCard(
                        //   representativeName: 'محمد أحمد السيد',
                        //   representativePhone: '01012345678',
                        //   representativeImage: 'https://via.placeholder.com/150',
                        // ),

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
                        ShipmentDetailsNotes(shipmentID: widget.shipment.id),
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
      bottomNavigationBar: CustomCurvedNavigationBar(
        currentIndex: _page,
        navigationKey: _bottomNavigationKey,
        onTap: _onNavigationTap,
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