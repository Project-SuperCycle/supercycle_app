import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';

class NotesContent extends StatefulWidget {
  final List<String> notes;
  final String shipmentID;

  const NotesContent({
    super.key,
    required this.notes,
    required this.shipmentID,
  });

  @override
  State<NotesContent> createState() => _NotesContentState();
}

class _NotesContentState extends State<NotesContent> {
  late TextEditingController _notesController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    String initialNotes = widget.notes.join('\n');
    _notesController = TextEditingController(text: initialNotes);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _editNotes() {}

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shadowColor: Colors.grey,
      margin: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.shade300, width: 1.5),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _notesController,
                maxLines: null,
                expands: true,
                textAlign: TextAlign.right,
                style: AppStyles.styleRegular14(context),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 70),
                  hintText: 'اكتب ملاحظاتك هنا...',
                  hintStyle: AppStyles.styleRegular14(
                    context,
                  ).copyWith(color: Colors.grey),
                ),
                onTap: () {
                  setState(() {
                    isEditing = true;
                  });
                },
                onChanged: (value) {},
              ),
            ),

            // Header overlay
            Positioned(
              top: 16,
              left: 10,
              right: 16,
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
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ملاحظات :',
                          style: AppStyles.styleSemiBold14(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '----/--/----   تعديل مقبول',
                          style: AppStyles.styleSemiBold12(
                            context,
                          ).copyWith(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
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
