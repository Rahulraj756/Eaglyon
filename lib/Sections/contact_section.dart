import 'package:flutter/material.dart';
import 'package:my_practice_app/Data_Model/site_data.dart';

class ContactSection extends StatefulWidget {
  final String? prefilledNote;

  const ContactSection({super.key, this.prefilledNote});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _messageCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.prefilledNote != null &&
        widget.prefilledNote!.trim().isNotEmpty) {
      _messageCtrl.text = 'Interested in: ${widget.prefilledNote!.trim()}\n';
    }
  }

  @override
  void didUpdateWidget(covariant ContactSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.prefilledNote != null &&
        widget.prefilledNote!.trim().isNotEmpty &&
        widget.prefilledNote != oldWidget.prefilledNote) {
      _messageCtrl.text = 'Interested in: ${widget.prefilledNote!.trim()}\n';
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  void _submitInquiry() {
    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final msg = _messageCtrl.text.trim();

    if (name.isEmpty || email.isEmpty || msg.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFF1F2937),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Please fill in your name, email, and message.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF1F2937),
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Color(0xFFF59E0B)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Thank you, $name! Your inquiry is ready to send to ${SiteData.contactEmail}.',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );

    _nameCtrl.clear();
    _emailCtrl.clear();
    _messageCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      width: double.infinity,
      color: const Color(0xFF0B0F19),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 24.0,
        vertical: isDesktop ? 76.0 : 48.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFF59E0B), width: 0.6),
            ),
            child: Text(
              '⚡ ${SiteData.contactBadge}',
              style: const TextStyle(
                color: Color(0xFFF59E0B),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Heading & Subtitle
          Text(
            SiteData.contactTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              height: 1.2,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            SiteData.contactSubtitle,
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 16,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 36),

          // Two-Column Desktop / Single-Column Mobile
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 4, child: _buildContactInfoCards()),
                    const SizedBox(width: 28),
                    Expanded(flex: 6, child: _buildInquiryFormCard()),
                  ],
                )
              : Column(
                  children: [
                    _buildContactInfoCards(),
                    const SizedBox(height: 24),
                    _buildInquiryFormCard(),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildContactInfoCards() {
    return Column(
      children: [
        _infoTile(
          icon: Icons.email_outlined,
          label: 'Email',
          value: SiteData.contactEmail,
        ),
        const SizedBox(height: 14),
        _infoTile(
          icon: Icons.phone_outlined,
          label: 'Phone / WhatsApp',
          value: SiteData.contactPhone,
        ),
        const SizedBox(height: 14),
        _infoTile(
          icon: Icons.location_on_outlined,
          label: 'Location',
          value: SiteData.contactLocation,
        ),
      ],
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFFF59E0B), size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInquiryFormCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Send a Quick Message',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          _inputField(_nameCtrl, 'Your Name', 'Enter your name'),
          const SizedBox(height: 14),
          _inputField(_emailCtrl, 'Your Email', 'Enter your email address'),
          const SizedBox(height: 14),
          _inputField(
            _messageCtrl,
            'Project Details',
            'Tell me about your spreadsheet, rows, dashboard, or app requirement...',
            maxLines: 4,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF59E0B),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 13),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _submitInquiry,
              icon: const Icon(Icons.send_outlined, size: 18),
              label: const Text(
                'Send Message',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField(
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
