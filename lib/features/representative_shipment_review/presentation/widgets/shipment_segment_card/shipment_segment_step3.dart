import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/widgets/shipment/expandable_section.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/models/deliver_segment_model.dart';
import 'package:supercycle_app/features/representative_shipment_review/data/models/shipment_segment_model.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/segment_deliver_modal/segment_deliver_modal.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_action_button.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_card_progress.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_deliverd_section.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_destination_section.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_truck_info.dart';
import 'package:supercycle_app/features/representative_shipment_review/presentation/widgets/shipment_segments_parts/segment_weight_info.dart';

class ShipmentSegmentStep3 extends StatefulWidget {
  final ShipmentSegmentModel segment;
  final bool isDelivered;
  final VoidCallback onDeliveredPressed;
  final Function(List<File>?)? onImagesSelected;
  final String shipmentID;
  final String segmentID;
  final int maxImages;
  const ShipmentSegmentStep3({
    super.key,
    required this.segment,
    required this.isDelivered,
    required this.onDeliveredPressed,
    required this.onImagesSelected,
    required this.shipmentID,
    required this.segmentID,
    this.maxImages = 5,
  });

  @override
  State<ShipmentSegmentStep3> createState() => _ShipmentSegmentStep3State();
}

class _ShipmentSegmentStep3State extends State<ShipmentSegmentStep3> {
  bool isWeightDataExpanded = false;
  int currentStep = 2;
  final TextEditingController _weightController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final List<File> _selectedImages = [];
  bool _isButtonEnabled = false;

  void _toggleWeightData() {
    setState(() {
      isWeightDataExpanded = !isWeightDataExpanded;
    });
  }

  @override
  void initState() {
    super.initState();
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
        _selectedImages.isNotEmpty && _weightController.text.trim().isNotEmpty;
    if (_isButtonEnabled != newState) {
      setState(() {
        _isButtonEnabled = newState;
      });
    }
  }

  void _showDeliverModal(BuildContext context) {
    SegmentDeliverModal.show(
      context,
      shipmentID: widget.shipmentID,
      onSubmit: (List<File> images, String name) {
        Logger().i('✅ Deliver Shipment Segment');
        DeliverSegmentModel deliverSegmentModel = DeliverSegmentModel(
          shipmentID: widget.shipmentID,
          segmentID: widget.segmentID,
          receivedByName: name,
          images: images,
        );

        Logger().w("DELIVER SEGMENT MODEL: $deliverSegmentModel");

        // هنا أضف منطق إرسال البيانات للـ API
        // BlocProvider.of<AcceptShipmentCubit>(
        //   context,
        // ).acceptShipment(acceptModel: acceptShipmentModel);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('تم تأكيد الشحنة بنجاح'),
              ],
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  }

  Future<void> _pickImage() async {
    if (_selectedImages.length >= widget.maxImages) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('لا يمكن إضافة أكثر من ${widget.maxImages} صور'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildImageSourceOption(
                        icon: Icons.photo_camera_rounded,
                        title: 'التقاط صورة',
                        subtitle: 'استخدم الكاميرا',
                        onTap: () async {
                          Navigator.pop(context);
                          await _getImage(ImageSource.camera);
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildImageSourceOption(
                        icon: Icons.photo_library_rounded,
                        title: 'اختيار من المعرض',
                        subtitle:
                            'اختر صور موجودة (حد أقصى ${5 - _selectedImages.length})',
                        onTap: () async {
                          Navigator.pop(context);
                          await _getMultipleImages();
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primaryColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_back_ios_rounded,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
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
          _selectedImages.add(File(pickedFile.path));
        });
        widget.onImagesSelected?.call(_selectedImages);
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

  Future<void> _getMultipleImages() async {
    try {
      final remainingSlots = widget.maxImages - _selectedImages.length;
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (pickedFiles.isNotEmpty) {
        final imagesToAdd = pickedFiles.take(remainingSlots).toList();
        setState(() {
          _selectedImages.addAll(imagesToAdd.map((xFile) => File(xFile.path)));
        });

        if (pickedFiles.length > remainingSlots) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'تم إضافة $remainingSlots صور فقط. الحد الأقصى ${widget.maxImages} صور',
              ),
              backgroundColor: Colors.orange,
            ),
          );
        }

        widget.onImagesSelected?.call(_selectedImages);
        _updateButtonState();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء اختيار الصور: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String get weightValue => _weightController.text;
  List<File> get selectedImages => _selectedImages;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: SegmentCardProgress(currentStep: currentStep),
        ),
        SegmentTruckInfo(truckNumber: widget.segment.vehicleNumber!),
        SizedBox(height: 4),
        SegmentDestinationSection(
          destinationTitle: widget.segment.destName!,
          destinationAddress: widget.segment.destAddress!,
        ),
        SizedBox(height: 20),
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: ExpandableSection(
            title: 'بيانات الوزنة',
            iconPath: AppAssets.boxPerspective,
            isExpanded: isWeightDataExpanded,
            maxHeight: 280,
            onTap: _toggleWeightData,
            content: SegmentWeightInfo(
              imagePath: AppAssets.miniature,
              segment: widget.segment,
            ),
          ),
        ),
        const SizedBox(height: 20),
        widget.isDelivered
            ? SegmentDeliverdSection()
            : Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SegmentActionButton(
                      title: "تم التوصيل",
                      onPressed: () {
                        _showDeliverModal(context);
                        setState(() {
                          currentStep = 3;
                        });
                      },
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
