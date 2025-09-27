import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle_app/core/helpers/custom_loading_indicator.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/shipment_details/data/cubits/notes_cubit/notes_cubit.dart';
import 'package:supercycle_app/features/shipment_details/data/cubits/notes_cubit/notes_state.dart';
import 'package:supercycle_app/features/shipment_details/presentation/widgets/shipment_add_note_model.dart';

class ShipmentDetailsNotes extends StatefulWidget {
  final String shipmentID;
  const ShipmentDetailsNotes({super.key, required this.shipmentID});

  @override
  State<ShipmentDetailsNotes> createState() => _ShipmentDetailsNotesState();
}

class _ShipmentDetailsNotesState extends State<ShipmentDetailsNotes> {
  List<String> notes = [];

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
        return ShipmentAddNoteModel(shipmentId: widget.shipmentID);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shadowColor: Colors.grey,
      margin: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        height: 200,
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
              child: BlocConsumer<NotesCubit, NotesState>(
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
                      child: notes.isEmpty
                          ? Center(
                              child: Text(
                                "لا توجد ملاحظات",
                                style: AppStyles.styleRegular16(
                                  context,
                                ).copyWith(color: Colors.grey.shade600),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: notes
                                    .map(
                                      (note) => Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                        ),
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
