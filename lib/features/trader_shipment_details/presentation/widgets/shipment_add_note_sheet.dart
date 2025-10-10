import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/trader_shipment_details/data/cubits/notes_cubit/notes_cubit.dart';
import 'package:supercycle_app/features/trader_shipment_details/data/models/create_notes_model.dart';

class ShipmentAddNoteSheet extends StatefulWidget {
  final String shipmentId;
  final TextEditingController noteController;
  const ShipmentAddNoteSheet({
    super.key,
    required this.shipmentId,
    required this.noteController,
  });

  @override
  State<ShipmentAddNoteSheet> createState() => _ShipmentAddNoteSheetState();
}

class _ShipmentAddNoteSheetState extends State<ShipmentAddNoteSheet> {
  @override
  void dispose() {
    super.dispose();
  }

  void _addNote({required CreateNotesModel note, required String shipmentId}) {
    BlocProvider.of<NotesCubit>(
      context,
    ).addNotes(notes: note, shipmentId: shipmentId);

    BlocProvider.of<NotesCubit>(context).getAllNotes(shipmentId: shipmentId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Title
              Text(
                'إضافة ملاحظة جديدة',
                style: AppStyles.styleSemiBold16(
                  context,
                ).copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // TextField
              TextField(
                controller: widget.noteController,
                maxLines: 4,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'اكتب الملاحظة هنا...',
                  hintStyle: AppStyles.styleRegular16(
                    context,
                  ).copyWith(color: Colors.grey.shade500),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  contentPadding: EdgeInsets.all(16),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                style: AppStyles.styleRegular16(context),
              ),
              SizedBox(height: 24),

              // Buttons Row
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'إلغاء',
                        style: AppStyles.styleSemiBold16(
                          context,
                        ).copyWith(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),

                  // Save Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget.noteController.text.trim().isNotEmpty) {
                          // TODO: Call the save note method from your cubit
                          _addNote(
                            note: CreateNotesModel(
                              content: widget.noteController.text.trim(),
                            ),
                            shipmentId: widget.shipmentId,
                          );
                          Navigator.pop(context);

                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('تم حفظ الملاحظة بنجاح'),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        } else {
                          // Show error for empty note
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('يرجى كتابة الملاحظة أولاً'),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'حفظ',
                        style: AppStyles.styleSemiBold16(
                          context,
                        ).copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
