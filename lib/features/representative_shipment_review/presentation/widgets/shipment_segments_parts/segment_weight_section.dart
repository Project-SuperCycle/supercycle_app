import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'dart:io';
import 'package:supercycle_app/core/utils/app_styles.dart';

class SegmentWeightSection extends StatefulWidget {
  final VoidCallback? onUploadTap;
  final Function(File?)? onImageSelected;
  const SegmentWeightSection({
    super.key,
    this.onUploadTap,
    this.onImageSelected,
  });
  @override
  State<SegmentWeightSection> createState() => _SegmentWeightSectionState();
}

class _SegmentWeightSectionState extends State<SegmentWeightSection> {
  final TextEditingController _weightController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    // Listen to text changes to update button state
    _weightController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _weightController.removeListener(_updateButtonState);
    _weightController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    final newState =
        _selectedImage != null && _weightController.text.trim().isNotEmpty;
    if (_isButtonEnabled != newState) {
      setState(() {
        _isButtonEnabled = newState;
      });
    }
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.photo_camera,
                      color: Color(0xFF3F51B5),
                    ),
                    title: const Text(
                      'التقاط صورة',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () async {
                      Navigator.pop(context);
                      await _getImage(ImageSource.camera);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.photo_library,
                      color: Color(0xFF3F51B5),
                    ),
                    title: const Text(
                      'اختيار من المعرض',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () async {
                      Navigator.pop(context);
                      await _getImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
        widget.onImageSelected?.call(_selectedImage);
        _updateButtonState();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء اختيار الصورة: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
    widget.onImageSelected?.call(null);
    _updateButtonState();
  }

  String get weightValue => _weightController.text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EAF6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: CustomPaint(
        painter: DashedBorderPainter(
          color: const Color(0xFF5C6BC0),
          strokeWidth: 1.5,
          dashWidth: 6,
          dashSpace: 6,
          borderRadius: 16,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title with camera icon
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'صورة الوزنة',
                      style: AppStyles.styleSemiBold16(context),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.photo_camera_outlined,
                      color: const Color(0xFF3F51B5),
                      size: 25,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Image upload area
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _selectedImage == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo_camera_outlined,
                              size: 60,
                              color: const Color(0xFF5C6BC0),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'اضغط لإضافة صورة الوزنة',
                              style: AppStyles.styleMedium14(
                                context,
                              ).copyWith(color: AppColors.subTextColor),
                            ),
                          ],
                        )
                      : Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _selectedImage!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              left: 8,
                              child: GestureDetector(
                                onTap: _removeImage,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withAlpha(250),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 24),
              // Actual weight label
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'الوزن الفعلي',
                  style: AppStyles.styleSemiBold14(context),
                ),
              ),
              const SizedBox(height: 12),
              // Weight input field
              Row(
                children: [
                  Text('طن', style: AppStyles.styleSemiBold16(context)),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: _weightController,
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      style: AppStyles.styleMedium14(context),
                      decoration: InputDecoration(
                        hintText: 'أدخل الوزن',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Upload button
              SizedBox(
                width: double.infinity,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: ElevatedButton(
                    onPressed: _isButtonEnabled
                        ? () {
                            widget.onUploadTap?.call();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isButtonEnabled
                          ? AppColors.primaryColor
                          : const Color(0xFFBDBDBD),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      disabledBackgroundColor: const Color(0xFFBDBDBD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'رفع بيانات الوزنة',
                      style: AppStyles.styleBold14(context).copyWith(
                        color: _isButtonEnabled
                            ? Colors.white
                            : AppColors.mainTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom painter for dashed border
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            strokeWidth / 2,
            strokeWidth / 2,
            size.width - strokeWidth,
            size.height - strokeWidth,
          ),
          Radius.circular(borderRadius),
        ),
      );

    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final dashPath = Path();
    final pathMetrics = path.computeMetrics();

    for (final metric in pathMetrics) {
      double distance = 0.0;
      bool draw = true;

      while (distance < metric.length) {
        final length = draw ? dashWidth : dashSpace;
        final endDistance = distance + length;

        if (endDistance > metric.length) {
          if (draw) {
            dashPath.addPath(
              metric.extractPath(distance, metric.length),
              Offset.zero,
            );
          }
          break;
        }

        if (draw) {
          dashPath.addPath(
            metric.extractPath(distance, endDistance),
            Offset.zero,
          );
        }

        distance = endDistance;
        draw = !draw;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
