import 'dart:io';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/modules/contact_page/presentation/controllers/contact_page_controller.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/constants/app_colors.dart';

class SignatureDialogWidget extends StatefulWidget {
  final String id;
  const SignatureDialogWidget({super.key, required this.id});

  @override
  State<SignatureDialogWidget> createState() => _SignatureDialogWidgetState();
}

class _SignatureDialogWidgetState extends State<SignatureDialogWidget> {
  int _selectedTab = 0;
  final SignaturePainter _signaturePainter = SignaturePainter();
  int _repaintKey = 0;
  File? selectedImageFile;

  final controller = Get.find<ContactPageController>();

  void _triggerRepaint() {
    setState(() {
      _repaintKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.primaryWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.primaryWhite,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: const Text(
                    'Create Your Signature',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlack,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryRed,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.primaryWhite,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Tab Bar
            Row(
              children: [
                _buildTab(0, Icons.draw, 'Draw'),
                _buildTab(1, Icons.upload, 'Upload'),
                _buildTab(2, Icons.save, 'Save'),
              ],
            ),
            const SizedBox(height: 20),

            // Content Area
            _buildContent(),

            const SizedBox(height: 20),

            // Action Button
            if (_selectedTab != 2)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.uploadSignatureLoading.value
                      ? null
                      : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryNavyBlue,
                    foregroundColor: AppColors.primaryWhite,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: controller.uploadSignatureLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Save & Submit"),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(int index, IconData icon, String label) {
    final isSelected = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? AppColors.primaryOrange
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected
                    ? AppColors.primaryOrange
                    : AppColors.primaryGray,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.primaryOrange
                      : AppColors.primaryGray,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_selectedTab == 0) {
      // Draw Tab
      return Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryBorderColor),
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primaryWhite,
            ),
            child: Stack(
              children: [
                GestureDetector(
                  onPanStart: (details) {
                    _signaturePainter.addPoint(details.localPosition);
                    _triggerRepaint();
                  },
                  onPanUpdate: (details) {
                    _signaturePainter.addPoint(details.localPosition);
                    _triggerRepaint();
                  },
                  onPanEnd: (details) {
                    _signaturePainter.endStroke();
                    _triggerRepaint();
                  },
                  child: CustomPaint(
                    key: ValueKey(_repaintKey),
                    painter: _signaturePainter,
                    size: Size.infinite,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Row(
                    children: [
                      _buildColorButton(AppColors.primaryBlack),
                      const SizedBox(width: 4),
                      _buildColorButton(AppColors.primaryGreen),
                      const SizedBox(width: 4),
                      _buildColorButton(AppColors.primaryRed),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (_selectedTab == 1) {
      // Upload Tab

      return Container(
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryBorderColor),
          borderRadius: BorderRadius.circular(8),
          color: AppColors.lightGrey,
        ),
        child: Center(
          child: selectedImageFile != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    selectedImageFile!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Upload a photo of your signature.',
                      style: TextStyle(color: AppColors.secondaryTextColor),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Max file size: 1MB',
                      style: TextStyle(
                        color: AppColors.secondaryTextColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'png, jpg, jpeg, bmp, gif',
                      style: TextStyle(
                        color: AppColors.secondaryTextColor,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.upload, size: 16),
                      label: const Text('Upload photo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryNavyBlue,
                        foregroundColor: AppColors.primaryWhite,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      );
    } else {
      // Save Tab - Show saved signatures
      return Column(
        children: [
          _buildSavedSignature(),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryNavyBlue,
                foregroundColor: AppColors.primaryWhite,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: AppColors.primaryWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildSavedSignature() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryBorderColor),
        borderRadius: BorderRadius.circular(8),
        color: AppColors.primaryWhite,
      ),
      child: Center(
        child: CustomPaint(
          key: ValueKey(_repaintKey),
          painter: _signaturePainter,
          size: const Size(double.infinity, 200),
        ),
      ),
    );
  }

  Widget _buildColorButton(Color color) {
    return GestureDetector(
      onTap: () {
        _signaturePainter.setColor(color);
        _triggerRepaint();
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: _signaturePainter.currentColor == color
                ? AppColors.primaryBlue
                : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        selectedImageFile = File(result.files.single.path!);
      });
    }
  }

  //   void _handleSubmit() {
  //     setState(() {
  //       _selectedTab = 2;
  //     });
  //   }
  // }

  Future<void> _handleSubmit() async {
    File? fileToUpload;

    if (_selectedTab == 0) {
      /// DRAW → IMAGE FILE
      final image = await _signaturePainter.exportAsImage();
      if (image == null) {
        Get.snackbar("Error", "Please draw a signature");
        return;
      }

      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      final dir = await getTemporaryDirectory();
      final file = File("${dir.path}/signature.png");
      await file.writeAsBytes(bytes!.buffer.asUint8List());
      fileToUpload = file;
    } else {
      /// UPLOAD TAB
      if (selectedImageFile == null) {
        Get.snackbar("Error", "Please select an image");
        return;
      }
      fileToUpload = selectedImageFile;
    }

    await controller.submitSignature(id: widget.id, file: fileToUpload!);

    Navigator.pop(context);
  }
}

class SignaturePainter extends CustomPainter {
  final List<List<Offset?>> _strokes = [];
  final List<Color> _strokeColors = [];
  Color currentColor = AppColors.primaryBlack;

  void addPoint(Offset point) {
    if (_strokes.isEmpty || _strokes.last.last == null) {
      _strokes.add([point]);
      _strokeColors.add(currentColor);
    } else {
      _strokes.last.add(point);
    }
  }

  void endStroke() {
    if (_strokes.isNotEmpty) {
      _strokes.last.add(null);
    }
  }

  void setColor(Color color) {
    currentColor = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < _strokes.length; i++) {
      paint.color = i < _strokeColors.length
          ? _strokeColors[i]
          : AppColors.primaryBlack;

      for (int j = 0; j < _strokes[i].length - 1; j++) {
        if (_strokes[i][j] != null && _strokes[i][j + 1] != null) {
          canvas.drawLine(_strokes[i][j]!, _strokes[i][j + 1]!, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  Future<ui.Image?> exportAsImage({
    double width = 500,
    double height = 200,
  }) async {
    if (_strokes.isEmpty) return null;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, width, height));

    paint(canvas, Size(width, height));

    final picture = recorder.endRecording();
    return picture.toImage(width.toInt(), height.toInt());
  }
}
