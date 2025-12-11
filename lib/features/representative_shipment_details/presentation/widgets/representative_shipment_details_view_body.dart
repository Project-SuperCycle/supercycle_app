import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supercycle/core/constants.dart';
import 'package:supercycle/core/utils/app_assets.dart';
import 'package:supercycle/core/utils/app_colors.dart';
import 'package:supercycle/core/utils/app_styles.dart';
import 'package:supercycle/core/widgets/custom_text_field.dart';
import 'package:supercycle/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:supercycle/core/widgets/shipment/client_data_content.dart';
import 'package:supercycle/core/widgets/shipment/expandable_section.dart';
import 'package:supercycle/core/widgets/shipment/progress_widgets.dart';
import 'package:supercycle/core/widgets/shipment/shipment_logo.dart';
import 'package:supercycle/core/models/single_shipment_model.dart';
import 'package:supercycle/features/representative_shipment_details/presentation/widgets/representative_shipment_actions_row.dart';
import 'package:supercycle/features/representative_shipment_details/presentation/widgets/representative_shipment_details_content.dart';
import 'package:supercycle/features/representative_shipment_details/presentation/widgets/representative_shipment_details_header.dart';
import 'package:supercycle/features/representative_shipment_details/presentation/widgets/representative_shipment_details_notes.dart';
import 'package:supercycle/features/representative_shipment_details/presentation/widgets/representative_shipment_notes_content.dart';
import 'package:supercycle/features/representative_shipment_details/presentation/widgets/representative_shipment_review_button.dart';

class RepresentativeShipmentDetailsViewBody extends StatefulWidget {
  const RepresentativeShipmentDetailsViewBody({
    super.key,
    required this.shipment,
  });
  final SingleShipmentModel shipment;

  @override
  State<RepresentativeShipmentDetailsViewBody> createState() =>
      _RepresentativeShipmentDetailsViewBodyState();
}

class _RepresentativeShipmentDetailsViewBodyState
    extends State<RepresentativeShipmentDetailsViewBody> {
  bool isShipmentDetailsExpanded = false;
  bool isClientDataExpanded = false;
  bool isNotesDataExpanded = false;
  bool hasActionBeenTaken = false;

  int _page = 3;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Key for SharedPreferences
  String get _actionTakenKey => 'shipment_${widget.shipment.id}_action_taken';

  @override
  void initState() {
    super.initState();
    _loadActionState();
  }

  /// Load action state from SharedPreferences
  Future<void> _loadActionState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      hasActionBeenTaken = prefs.getBool(_actionTakenKey) ?? false;
    });
  }

  /// Save action state to SharedPreferences
  Future<void> _saveActionState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_actionTakenKey, value);
  }

  /// Mark action as taken
  void _markActionAsTaken() {
    setState(() {
      hasActionBeenTaken = true;
    });
    _saveActionState(true);
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: const ShipmentLogo(),
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
                        RepresentativeShipmentDetailsHeader(
                          shipment: widget.shipment,
                        ),
                        const SizedBox(height: 12),
                        ProgressBar(completedSteps: _getProgressSteps()),
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
                            content: RepresentativeShipmentDetailsContent(
                              items: widget.shipment.items,
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
                            content: ClientDataContent(
                              trader: widget.shipment.trader,
                            ),
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
                        const SizedBox(height: 25),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ExpandableSection(
                            title: 'ملاحظات من التاجر / الاداره',
                            iconPath: AppAssets.entityCard,
                            isExpanded: isNotesDataExpanded,
                            maxHeight: 200,
                            onTap: _toggleNotesData,
                            content: RepresentativeShipmentNotesContent(
                              notes: widget.shipment.mainNotes,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        RepresentativeShipmentDetailsNotes(
                          shipment: widget.shipment,
                        ),
                        const SizedBox(height: 25),
                        _buildShipmentActions(),
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

  int _getProgressSteps() {
    switch (widget.shipment.status) {
      case 'approved':
        return 1;
      case 'pending_admin_review':
        return 2;
      case 'routed':
        return 3;
      case 'delivery_in_transit':
        return 4;
      case 'delivered':
      case 'complete_weighted':
        return 5;
      default:
        return 0;
    }
  }

  Widget _buildShipmentActions() {
    final status = widget.shipment.status;

    // إذا تم اتخاذ إجراء من قبل، لا تعرض الأزرار
    if (hasActionBeenTaken && status == 'approved') {
      return Center(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green.shade300),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green.shade700),
              SizedBox(width: 8),
              Text(
                'تم اتخاذ إجراء على هذه الشحنة',
                style: AppStyles.styleSemiBold14(
                  context,
                ).copyWith(color: Colors.green.shade700),
              ),
            ],
          ),
        ),
      );
    }

    if (status == 'approved') {
      return RepresentativeShipmentActionsRow(
        shipment: widget.shipment,
        onActionTaken: _markActionAsTaken,
      );
    }

    const reviewStatuses = [
      'routed',
      'delivery_in_transit',
      'delivered',
      'partially_delivered',
      'complete_weighted',
    ];

    if (reviewStatuses.contains(status)) {
      return RepresentativeShipmentReviewButton(shipment: widget.shipment);
    }

    return const SizedBox.shrink();
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

  void _toggleNotesData() {
    setState(() {
      isNotesDataExpanded = !isNotesDataExpanded;
    });
  }
}
