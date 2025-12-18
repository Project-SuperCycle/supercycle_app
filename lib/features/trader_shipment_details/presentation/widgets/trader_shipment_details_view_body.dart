import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:supercycle/core/constants.dart';
import 'package:supercycle/core/models/single_shipment_model.dart';
import 'package:supercycle/core/utils/app_assets.dart';
import 'package:supercycle/core/utils/app_colors.dart';
import 'package:supercycle/core/utils/app_styles.dart';
import 'package:supercycle/core/widgets/custom_text_field.dart';
import 'package:supercycle/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:supercycle/core/widgets/shipment/client_data_content.dart';
import 'package:supercycle/core/widgets/shipment/expandable_section.dart';
import 'package:supercycle/core/widgets/shipment/progress_widgets.dart';
import 'package:supercycle/core/widgets/shipment/shipment_logo.dart';
import 'package:supercycle/core/widgets/shipment/shipment_details_notes.dart';
import 'package:supercycle/features/trader_shipment_details/presentation/widgets/shipment_weight_reports_section.dart';
import 'package:supercycle/features/trader_shipment_details/presentation/widgets/trader_shipment_details_content.dart';
import 'package:supercycle/features/trader_shipment_details/presentation/widgets/trader_shipment_details_header.dart';
import 'package:supercycle/features/trader_shipment_details/presentation/widgets/trader_shipment_details_settings_icon.dart';
import 'package:supercycle/features/trader_shipment_details/presentation/widgets/trader_shipment_representative_card.dart';

class TraderShipmentDetailsViewBody extends StatefulWidget {
  const TraderShipmentDetailsViewBody({super.key, required this.shipment});
  final SingleShipmentModel shipment;

  @override
  State<TraderShipmentDetailsViewBody> createState() =>
      _TraderShipmentDetailsViewBodyState();
}

class _TraderShipmentDetailsViewBodyState
    extends State<TraderShipmentDetailsViewBody> {
  bool isShipmentDetailsExpanded = false;
  bool isInspectedItemsExpanded = false;
  bool isClientDataExpanded = false;
  bool isWeightReportsExpanded = false;

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
                  children: [const ShipmentLogo(), const SizedBox(height: 15)],
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
                                child: TraderShipmentDetailsSettingsIcon(
                                  shipment: widget.shipment,
                                ),
                              )
                            : const SizedBox.shrink(),
                        TraderShipmentDetailsHeader(shipment: widget.shipment),
                        const SizedBox(height: 16),
                        ProgressBar(completedSteps: _getProgressSteps()),
                        const SizedBox(height: 20),

                        // Representative Card
                        (widget.shipment.representitive != null)
                            ? TraderShipmentRepresentativeCard(
                                representitive: widget.shipment.representitive!,
                              )
                            : SizedBox.shrink(),

                        const SizedBox(height: 20),

                        // Column(
                        //   children: [
                        //     Container(
                        //       clipBehavior: Clip.antiAliasWithSaveLayer,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(8),
                        //       ),
                        //       child: ExpandableSection(
                        //         title: 'بياناتي',
                        //         iconPath: AppAssets.entityCard,
                        //         isExpanded: isClientDataExpanded,
                        //         maxHeight: 320,
                        //         onTap: _toggleClientData,
                        //         content: ClientDataContent(
                        //           trader: widget.shipment.trader!,
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(height: 20),
                        //   ],
                        // ),
                        Column(
                          children: [
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
                                content: TraderShipmentDetailsContent(
                                  items: widget.shipment.items,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                        widget.shipment.inspectedItems.isNotEmpty
                            ? Column(
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ExpandableSection(
                                      title: 'الشحنة بعد المعاينة',
                                      iconPath: AppAssets.boxPerspective,
                                      isExpanded: isInspectedItemsExpanded,
                                      maxHeight: 320,
                                      onTap: _toggleInspectedItems,
                                      content: TraderShipmentDetailsContent(
                                        items: widget.shipment.inspectedItems,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              )
                            : SizedBox.shrink(),
                        (widget.shipment.status == "delivered" ||
                                widget.shipment.status == "complete_weighted")
                            ? Column(
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ExpandableSection(
                                      title: 'تقارير الوزنة',
                                      iconPath: AppAssets.boxPerspective,
                                      isExpanded: isWeightReportsExpanded,
                                      maxHeight: 320,
                                      onTap: _toggleWeightReports,
                                      content: ShipmentWeightReportsSection(
                                        segments: widget.shipment.segments,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              )
                            : SizedBox.shrink(),
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
                        ShipmentDetailsNotes(
                          notes: widget.shipment.mainNotes,
                          shipmentID: widget.shipment.id,
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

  void _toggleInspectedItems() {
    setState(() {
      isInspectedItemsExpanded = !isInspectedItemsExpanded;
    });
  }

  void _toggleClientData() {
    setState(() {
      isClientDataExpanded = !isClientDataExpanded;
    });
  }

  void _toggleWeightReports() {
    setState(() {
      isWeightReportsExpanded = !isWeightReportsExpanded;
    });
  }

  int _getProgressSteps() {
    switch (widget.shipment.status) {
      case 'pending':
        return 1;
      case 'approved':
        return 2;
      case 'pending_admin_review':
      case 'delivery_in_transit':
        return 3;
      case 'routed':
        return 4;
      case 'delivered':
      case 'complete_weighted':
        return 5;
      default:
        return 0;
    }
  }
}
