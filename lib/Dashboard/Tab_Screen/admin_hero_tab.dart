import 'dart:typed_data';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';

class AdminHeroTab extends StatelessWidget {
  final TextEditingController badgeController;
  final TextEditingController titleWhiteController;
  final TextEditingController titleGoldController;
  final TextEditingController descController;
  final Uint8List? imageBytes;
  final String? imageName;
  final bool isDragging;
  final ValueChanged<bool> onDragStateChanged;
  final void Function(Uint8List bytes, String name) onImagePicked;
  final VoidCallback onImageCleared;

  const AdminHeroTab({
    super.key,
    required this.badgeController,
    required this.titleWhiteController,
    required this.titleGoldController,
    required this.descController,
    required this.imageBytes,
    required this.imageName,
    required this.isDragging,
    required this.onDragStateChanged,
    required this.onImagePicked,
    required this.onImageCleared,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hero Section Content',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Customize the top hero banner text and featured image.',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 20),
          _field(
            controller: badgeController,
            label: 'Badge Text',
            hint: 'e.g. SHARP & FOCUSED',
          ),
          const SizedBox(height: 16),
          _field(
            controller: titleWhiteController,
            label: 'Main Heading (White Part)',
            hint: 'e.g. Transforming Data\nDriving ',
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          _field(
            controller: titleGoldController,
            label: 'Highlighted Heading (Gold Part)',
            hint: 'e.g. Decisions.',
          ),
          const SizedBox(height: 16),
          _field(
            controller: descController,
            label: 'Description',
            hint: 'Write your hero description...',
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          const Text(
            'Hero Image (Drag & Drop)',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          DropTarget(
            onDragEntered: (_) => onDragStateChanged(true),
            onDragExited: (_) => onDragStateChanged(false),
            onDragDone: (detail) async {
              onDragStateChanged(false);
              if (detail.files.isNotEmpty) {
                final file = detail.files.first;
                final bytes = await file.readAsBytes();
                onImagePicked(bytes, file.name);
              }
            },
            child: Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDragging
                    ? const Color(0xFFF59E0B).withValues(alpha: 0.1)
                    : const Color(0xFF0B0F19),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDragging ? const Color(0xFFF59E0B) : Colors.white24,
                  width: 1.5,
                ),
              ),
              child: imageBytes != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.memory(imageBytes!, fit: BoxFit.contain),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.black87,
                              ),
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 18,
                              ),
                              onPressed: onImageCleared,
                            ),
                          ),
                          if (imageName != null)
                            Positioned(
                              bottom: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  imageName!,
                                  style: const TextStyle(
                                    color: Color(0xFFF59E0B),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_outlined,
                            size: 36,
                            color: Color(0xFFF59E0B),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Drag & drop hero image here',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white30),
            filled: true,
            fillColor: const Color(0xFF0B0F19),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFF59E0B)),
            ),
          ),
        ),
      ],
    );
  }
}
