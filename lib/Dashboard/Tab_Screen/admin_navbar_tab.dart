import 'dart:typed_data';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';

class AdminNavbarTab extends StatelessWidget {
  final TextEditingController logoController;
  final Uint8List? logoImageBytes;
  final String? imageName;
  final bool isDragging;
  final ValueChanged<bool> onDragStateChanged;
  final void Function(Uint8List bytes, String name) onImagePicked;
  final VoidCallback onImageCleared;

  const AdminNavbarTab({
    super.key,
    required this.logoController,
    required this.logoImageBytes,
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
            'Brand Identity',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Update the main brand title shown in your top navigation bar.',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 20),
          const Text(
            'Website Logo Text',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: logoController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'e.g. PORTFOLIO or RAHUL RAJ',
              hintStyle: const TextStyle(color: Colors.white30),
              prefixIcon: const Icon(Icons.title, color: Color(0xFFF59E0B)),
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
          const SizedBox(height: 28),
          const Text(
            'Upload Logo Image',
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
              child: logoImageBytes != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.memory(logoImageBytes!, fit: BoxFit.contain),
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
                                imageName ?? 'Logo Selected',
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
                            Icons.cloud_upload_outlined,
                            size: 38,
                            color: Color(0xFFF59E0B),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Drag & drop your logo image here',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Supports PNG, JPG (Recommended 120x120px)',
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 12,
                            ),
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
}
