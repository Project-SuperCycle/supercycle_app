import 'package:flutter/material.dart';
import 'package:supercycle/core/utils/app_styles.dart';

class RepresentativeShipmentNotesContent extends StatefulWidget {
  const RepresentativeShipmentNotesContent({super.key});

  @override
  State<RepresentativeShipmentNotesContent> createState() =>
      _RepresentativeShipmentNotesContentState();
}

class _RepresentativeShipmentNotesContentState
    extends State<RepresentativeShipmentNotesContent> {
  List<String> notes = [
    "شكرا جزيلا",
    "ارجو الرد سريعا",
    "شكرا جزيلا",
    "ارجو الرد سريعا",
    "شكرا جزيلا",
    "ارجو الرد سريعا",
    "شكرا جزيلا",
    "ارجو الرد سريعا",
    "شكرا جزيلا",
    "ارجو الرد سريعا",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: notes
            .map(
              (note) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "🟢 $note",
                  style: AppStyles.styleRegular16(
                    context,
                  ).copyWith(height: 1.5),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
