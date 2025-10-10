import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/helpers/custom_back_button.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/widgets/navbar/custom_curved_navigation_bar.dart';
import 'package:supercycle_app/core/widgets/shipment/shipment_logo.dart';
import 'package:supercycle_app/core/models/single_shipment_model.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/models/shipment_segment_data.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/representative_shipment_review_header.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segment_card/shipment_segment_card.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_states_row/representative_shipment_states.dart';

class RepresentativeShipmentReviewBody extends StatefulWidget {
  const RepresentativeShipmentReviewBody({super.key, required this.shipment});
  final SingleShipmentModel shipment;

  @override
  State<RepresentativeShipmentReviewBody> createState() =>
      _RepresentativeShipmentReviewBodyState();
}

class _RepresentativeShipmentReviewBodyState
    extends State<RepresentativeShipmentReviewBody> {
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
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: const BoxDecoration(gradient: kGradientBackground),
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
                      RepresentativeShipmentReviewHeader(
                        shipment: widget.shipment,
                      ),
                      const SizedBox(height: 6),
                      RepresentativeShipmentStates(),
                      const SizedBox(height: 16),
                      Center(
                        child: ShipmentSegmentCard(
                          segment: ShipmentSegmentData(
                            driverName: 'محمد أيمن',
                            phoneNumber: '0105325656',
                            truckNumber: '328 ص ي م',
                            destinationTitle: 'وجهه السيارة 1 :',
                            destinationAddress:
                                'مصنع أكتوبر 15 شارع الجمهورية، المبنى الثالث',
                            productType: 'ورق ابيض',
                            quantity: '2 طن',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomCurvedNavigationBar(
        currentIndex: _page,
        navigationKey: _bottomNavigationKey,
        onTap: _onNavigationTap,
      ),
    );
  }
}
