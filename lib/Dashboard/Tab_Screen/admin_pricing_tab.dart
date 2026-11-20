import 'package:flutter/material.dart';

class AdminPricingTab extends StatelessWidget {
  final TextEditingController badgeController;
  final TextEditingController titleController;
  final TextEditingController subtitleController;
  final int popularPlanIndex;
  final ValueChanged<int> onPopularChanged;

  final TextEditingController p1NameController;
  final TextEditingController p1OneTimeController;
  final TextEditingController p1MonthlyController;
  final TextEditingController p1DescController;
  final TextEditingController p1FeaturesController;

  final TextEditingController p2NameController;
  final TextEditingController p2OneTimeController;
  final TextEditingController p2MonthlyController;
  final TextEditingController p2DescController;
  final TextEditingController p2FeaturesController;

  final TextEditingController p3NameController;
  final TextEditingController p3OneTimeController;
  final TextEditingController p3MonthlyController;
  final TextEditingController p3DescController;
  final TextEditingController p3FeaturesController;

  const AdminPricingTab({
    super.key,
    required this.badgeController,
    required this.titleController,
    required this.subtitleController,
    required this.popularPlanIndex,
    required this.onPopularChanged,
    required this.p1NameController,
    required this.p1OneTimeController,
    required this.p1MonthlyController,
    required this.p1DescController,
    required this.p1FeaturesController,
    required this.p2NameController,
    required this.p2OneTimeController,
    required this.p2MonthlyController,
    required this.p2DescController,
    required this.p2FeaturesController,
    required this.p3NameController,
    required this.p3OneTimeController,
    required this.p3MonthlyController,
    required this.p3DescController,
    required this.p3FeaturesController,
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
            'Pricing Section Content',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Configure plans, one-time/monthly prices, popular badge, and feature bullets (one per line).',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 20),
          _field(badgeController, 'Section Badge', 'e.g. PRICING & PLANS'),
          const SizedBox(height: 16),
          _field(
            titleController,
            'Section Title',
            'e.g. Transparent Pricing For Every Stage',
          ),
          const SizedBox(height: 16),
          _field(
            subtitleController,
            'Section Subtitle',
            'Short pricing overview...',
            maxLines: 2,
          ),
          const SizedBox(height: 16),

          // Popular Plan Selector
          const Text(
            'Highlighted Popular Plan',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF0B0F19),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white12),
            ),
            child: DropdownButton<int>(
              value: popularPlanIndex,
              dropdownColor: const Color(0xFF111827),
              style: const TextStyle(color: Colors.white),
              isExpanded: true,
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(value: 0, child: Text('Plan 1 (Left)')),
                DropdownMenuItem(value: 1, child: Text('Plan 2 (Center)')),
                DropdownMenuItem(value: 2, child: Text('Plan 3 (Right)')),
              ],
              onChanged: (val) {
                if (val != null) onPopularChanged(val);
              },
            ),
          ),

          _planBlock(
            heading: 'Plan 1 Settings',
            nameCtrl: p1NameController,
            oneTimeCtrl: p1OneTimeController,
            monthlyCtrl: p1MonthlyController,
            descCtrl: p1DescController,
            featuresCtrl: p1FeaturesController,
          ),
          _planBlock(
            heading: 'Plan 2 Settings',
            nameCtrl: p2NameController,
            oneTimeCtrl: p2OneTimeController,
            monthlyCtrl: p2MonthlyController,
            descCtrl: p2DescController,
            featuresCtrl: p2FeaturesController,
          ),
          _planBlock(
            heading: 'Plan 3 Settings',
            nameCtrl: p3NameController,
            oneTimeCtrl: p3OneTimeController,
            monthlyCtrl: p3MonthlyController,
            descCtrl: p3DescController,
            featuresCtrl: p3FeaturesController,
          ),
        ],
      ),
    );
  }

  Widget _planBlock({
    required String heading,
    required TextEditingController nameCtrl,
    required TextEditingController oneTimeCtrl,
    required TextEditingController monthlyCtrl,
    required TextEditingController descCtrl,
    required TextEditingController featuresCtrl,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Divider(color: Colors.white10),
        const SizedBox(height: 16),
        Text(
          heading,
          style: const TextStyle(
            color: Color(0xFFF59E0B),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _field(nameCtrl, 'Plan Name', 'e.g. Workflow Pro'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _field(oneTimeCtrl, 'One-Time Price', 'e.g. \$149'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _field(monthlyCtrl, 'Monthly Price', 'e.g. \$249/mo'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _field(descCtrl, 'Short Description', 'Plan summary...', maxLines: 2),
        const SizedBox(height: 12),
        _field(
          featuresCtrl,
          'Features (1 feature per line)',
          'Feature 1\nFeature 2\nFeature 3',
          maxLines: 4,
        ),
      ],
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
