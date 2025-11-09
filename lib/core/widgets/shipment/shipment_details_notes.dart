import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle_app/core/cubits/all_notes_cubit/all_notes_cubit.dart';
import 'package:supercycle_app/core/cubits/all_notes_cubit/all_notes_state.dart';
import 'package:supercycle_app/core/helpers/custom_loading_indicator.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/widgets/notes/shipment_notes_card.dart';
import 'package:supercycle_app/core/widgets/shipment_add_note_sheet.dart';
import 'package:supercycle_app/features/representative_shipment_details/data/models/rep_note_model.dart';

class ShipmentDetailsNotes extends StatefulWidget {
  final String shipmentID;
  const ShipmentDetailsNotes({super.key, required this.shipmentID});

  @override
  State<ShipmentDetailsNotes> createState() => _ShipmentDetailsNotesState();
}

class _ShipmentDetailsNotesState extends State<ShipmentDetailsNotes> {
  List<String> notes = [];
  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _editNotes() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ShipmentAddNoteSheet(
          shipmentId: widget.shipmentID,
          noteController: noteController,
        );
      },
    );
    (noteController.text.isNotEmpty)
        ? setState(() {
            notes.add(noteController.text);
          })
        : null;
    noteController.clear();
  }

  final List<ShipmentNoteModel> mainNotes = [
    ShipmentNoteModel(
      authorRole: 'Admin',
      content:
          'Shipment #SH2024-1547 has been cleared by customs. Documents are ready for pickup at warehouse B.',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    ShipmentNoteModel(
      authorRole: 'Trader',
      content:
          'Thank you for the update. Can you confirm the estimated delivery date? Our client is requesting an update.',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    ShipmentNoteModel(
      authorRole: 'Admin',
      content:
          'Estimated delivery: November 11, 2025. The carrier will contact the recipient 24 hours before delivery.',
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    ShipmentNoteModel(
      authorRole: 'Trader',
      content:
          'Perfect! I\'ve informed the client. Please ensure the delivery requires a signature upon receipt.',
      createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shadowColor: Colors.grey,
      margin: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        height: 240,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.shade300, width: 1.5),
        ),
        child: Stack(
          children: [
            // Content area positioned below the header
            Positioned(
              top: 60, // Increased to accommodate header
              left: 0,
              right: 0,
              bottom: 0,
              child: BlocConsumer<AllNotesCubit, AllNotesState>(
                listener: (context, state) {
                  if (state is GetAllNotesSuccess) {
                    setState(() {
                      notes = state.notes;
                    });
                  }
                  if (state is GetAllNotesFailure) {
                    setState(() {
                      notes = [];
                    });
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                  }
                },
                builder: (context, state) {
                  if (state is GetAllNotesSuccess) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: mainNotes.isEmpty
                          ? Center(
                              child: Text(
                                "لا توجد ملاحظات",
                                style: AppStyles.styleRegular16(
                                  context,
                                ).copyWith(color: Colors.grey.shade600),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                itemCount: mainNotes.length,
                                itemBuilder: (context, index) {
                                  return ShipmentNoteCard(
                                    note: mainNotes[index],
                                  );
                                },
                              ),
                            ),
                    );
                  }
                  if (state is GetAllNotesFailure) {
                    return Center(
                      child: Text(
                        "حدث خطأ في تحميل الملاحظات",
                        style: AppStyles.styleRegular16(
                          context,
                        ).copyWith(color: Colors.red.shade600),
                      ),
                    );
                  }
                  return const Center(child: CustomLoadingIndicator());
                },
                buildWhen: (prev, current) =>
                    current is GetAllNotesSuccess ||
                    current is GetAllNotesFailure ||
                    current is GetAllNotesLoading,
              ),
            ),
            // Header overlay
            Positioned(
              top: 10,
              left: 15,
              right: 20,
              child: Row(
                textDirection: TextDirection.ltr,
                children: [
                  // Edit icon
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primaryColor,
                    ),
                    icon: Icon(Icons.mode_edit_outline_rounded, size: 25),
                    onPressed: _editNotes,
                  ),
                  const Spacer(),
                  Text(
                    'ملاحظات :',
                    style: AppStyles.styleSemiBold16(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
