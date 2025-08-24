// widgets/notes_content.dart
import 'package:flutter/material.dart';

class NotesContent extends StatefulWidget {
  final List<String> notes;

  const NotesContent({
    super.key,
    required this.notes,
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
    // دمج الملاحظات الموجودة في نص واحد
    String initialNotes = widget.notes.join('\n');
    _notesController = TextEditingController(text: initialNotes);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.green.shade300,
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          // Main text area
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _notesController,
              maxLines: null,
              expands: true,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.5,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 40), // مساحة للهيدر
                hintText: 'اكتب ملاحظاتك هنا...',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              onTap: () {
                setState(() {
                  isEditing = true;
                });
              },
              onChanged: (value) {
                // يمكن إضافة منطق حفظ تلقائي هنا
              },
            ),
          ),

          // Header overlay
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                // Edit icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 16,
                    color: Colors.green.shade700,
                  ),
                ),
                const Spacer(),
                // Title and edit status
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ملاحظات :',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '-- --/--/----   تعديل مقبول',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}