import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/helpers/custom_back_button.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/widgets/custom_text_field.dart';
import 'package:supercycle_app/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:supercycle_app/core/widgets/shipment/client_data_content.dart';
import 'package:supercycle_app/core/widgets/shipment/expandable_section.dart';
import 'package:supercycle_app/core/widgets/shipment/progress_widgets.dart';
import 'package:supercycle_app/core/widgets/shipment/shipment_logo.dart';
import 'package:supercycle_app/core/models/single_shipment_model.dart';
import 'package:supercycle_app/features/representative_shipment_details/presentation/widgets/representative_shipment_actions_row.dart';
import 'package:supercycle_app/features/representative_shipment_details/presentation/widgets/representative_shipment_details_content.dart';
import 'package:supercycle_app/features/representative_shipment_details/presentation/widgets/representative_shipment_details_header.dart';
import 'package:supercycle_app/features/representative_shipment_details/presentation/widgets/representative_shipment_details_notes.dart';
import 'package:supercycle_app/features/representative_shipment_details/presentation/widgets/representative_shipment_notes_content.dart';

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
                        RepresentativeShipmentDetailsHeader(
                          shipment: widget.shipment,
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            ignoreGestures: true,
                            unratedColor: Color(0xFFBDBDBD),
                            itemSize: 25,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 6.0),
                            itemBuilder: (context, _) => Icon(
                              FontAwesomeIcons.solidStar,
                              color: Color(0xFFF9B023),
                            ),
                            onRatingUpdate: (rating) {
                              debugPrint(rating.toString());
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
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
                            content: RepresentativeShipmentDetailsContent(
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
                            content: const RepresentativeShipmentNotesContent(),
                          ),
                        ),
                        const SizedBox(height: 25),
                        RepresentativeShipmentDetailsNotes(
                          shipmentID: widget.shipment.id,
                        ),
                        const SizedBox(height: 25),
                        RepresentativeShipmentActionsRow(
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
