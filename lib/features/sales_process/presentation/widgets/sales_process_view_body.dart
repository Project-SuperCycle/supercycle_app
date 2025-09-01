import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/helpers/client_data_content.dart';
import 'package:supercycle_app/core/helpers/custom_back_button.dart' show CustomBackButton;
import 'package:supercycle_app/core/helpers/expandable_section.dart';
import 'package:supercycle_app/core/helpers/logo.dart' show Logo;
import 'package:supercycle_app/core/helpers/notes_content.dart';
import 'package:supercycle_app/core/helpers/progress_widgets.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/widgets/custom_button.dart';
import 'package:supercycle_app/features/sales_process/presentation/widgets/entry_shipment_details_cotent.dart';
import 'package:supercycle_app/features/sales_process/presentation/widgets/sales_process_shipment_header.dart';
import 'package:supercycle_app/features/shipping_details/presentation/views/shipping_details_view.dart';

class SalesProcessViewBody extends StatefulWidget {
  const SalesProcessViewBody({Key? key}) : super(key: key);

  @override
  State<SalesProcessViewBody> createState() => _SalesProcessViewBodyState();
}

class _SalesProcessViewBodyState extends State<SalesProcessViewBody> {
  bool isClientDataExpanded = false;
  bool isShipmentDetailsExpanded = false;
  List<String> notes = [];
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
                       GoRouter.of(context).pushReplacement(EndPoints.homeView);
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
                         const SalesProcessShipmentHeader(),
                         const SizedBox(height: 20),
                         const ProgressBar(completedSteps: 0),
                         const SizedBox(height: 30),
                         ExpandableSection(
                           title: 'بيانات جهة التعامل',
                           iconPath: 'assets/images/Box-Perspective.png',
                           isExpanded: isClientDataExpanded,
                           maxHeight: 220,
                           onTap: _toggleClientData,
                           content: const ClientDataContent(),
                         ),
                         const SizedBox(height: 30),
                         ExpandableSection(
                           title: 'تفاصيل الشحنة',
                           iconPath: 'assets/images/Box-Perspective2.png',
                           isExpanded: isShipmentDetailsExpanded,
                           maxHeight: 220,
                           onTap: _toggleShipmentDetails,
                           content:EntryShipmentDetailsContent (products: const [] ),
                         ),
                         const SizedBox(height: 30),
                         NotesContent(notes: notes),
                         const SizedBox(height: 50),
                         TextButton(
                           onPressed: () {
                             GoRouter.of(context).pushReplacement(EndPoints.shippingDetailsView);
                           },
                           style: TextButton.styleFrom(
                             backgroundColor: Colors.green,
                             foregroundColor: Colors.white,
                             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(100),
                             ),
                           ),
                           child: const Text(
                             'مراجعه الشحنة',
                             style: TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.w900,
                             ),
                           ),
                         )
                       ]
                     )
                   ),
                 )
             )
           ]
         ),
       )
    )
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
}