import 'package:flutter/material.dart';

class AdminContactTab extends StatelessWidget {
  final TextEditingController badgeController;
  final TextEditingController titleController;
  final TextEditingController subtitleController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController locationController;

  const AdminContactTab({
    super.key,
    required this.badgeController,
    required this.titleController,
    required this.subtitleController,
    required this.emailController,
    required this.phoneController,
    required this.locationController,
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
            'Contact Section Content',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Update contact heading, email, phone/WhatsApp, and location.',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 20),
          _field(badgeController, 'Section Badge', 'e.g. CONTACT ME'),
          const SizedBox(height: 16),
          _field(
            titleController,
            'Section Title',
            'e.g. Let’s Build Something Clean & Fast',
          ),
          const SizedBox(height: 16),
          _field(
            subtitleController,
            'Section Subtitle',
            'Short description...',
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          _field(emailController, 'Email Address', 'your@email.com'),
          const SizedBox(height: 16),
          _field(phoneController, 'Phone / WhatsApp', '+91 ...'),
          const SizedBox(height: 16),
          _field(locationController, 'Location', 'City, Region, Country'),
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
