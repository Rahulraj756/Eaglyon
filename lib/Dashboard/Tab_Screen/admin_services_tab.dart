import 'package:flutter/material.dart';

class AdminServicesTab extends StatelessWidget {
  final TextEditingController badgeController;
  final TextEditingController titleController;
  final TextEditingController subtitleController;
  final TextEditingController s1TitleController;
  final TextEditingController s1DescController;
  final TextEditingController s2TitleController;
  final TextEditingController s2DescController;
  final TextEditingController s3TitleController;
  final TextEditingController s3DescController;

  const AdminServicesTab({
    super.key,
    required this.badgeController,
    required this.titleController,
    required this.subtitleController,
    required this.s1TitleController,
    required this.s1DescController,
    required this.s2TitleController,
    required this.s2DescController,
    required this.s3TitleController,
    required this.s3DescController,
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
            'Services Section Content',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Edit section heading and all three service cards.',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 20),
          _field(badgeController, 'Section Badge', 'e.g. SERVICES'),
          const SizedBox(height: 16),
          _field(
            titleController,
            'Section Title',
            'e.g. Solutions Built For Speed & Accuracy',
          ),
          const SizedBox(height: 16),
          _field(
            subtitleController,
            'Section Subtitle',
            'Short overview of your services...',
            maxLines: 2,
          ),
          const SizedBox(height: 24),
          const Divider(color: Colors.white10),
          const SizedBox(height: 16),
          const Text(
            'Service Card 1',
            style: TextStyle(
              color: Color(0xFFF59E0B),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _field(s1TitleController, 'Card 1 Title', 'Service 1 title'),
          const SizedBox(height: 12),
          _field(
            s1DescController,
            'Card 1 Description',
            'Service 1 description...',
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          const Divider(color: Colors.white10),
          const SizedBox(height: 16),
          const Text(
            'Service Card 2',
            style: TextStyle(
              color: Color(0xFFF59E0B),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _field(s2TitleController, 'Card 2 Title', 'Service 2 title'),
          const SizedBox(height: 12),
          _field(
            s2DescController,
            'Card 2 Description',
            'Service 2 description...',
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          const Divider(color: Colors.white10),
          const SizedBox(height: 16),
          const Text(
            'Service Card 3',
            style: TextStyle(
              color: Color(0xFFF59E0B),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _field(s3TitleController, 'Card 3 Title', 'Service 3 title'),
          const SizedBox(height: 12),
          _field(
            s3DescController,
            'Card 3 Description',
            'Service 3 description...',
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label,
    String hint, {
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
