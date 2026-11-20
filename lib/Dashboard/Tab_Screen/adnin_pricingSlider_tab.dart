// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AdminPricingSliderTab extends StatelessWidget {
  final TextEditingController p1LabelCtrl;
  final TextEditingController p1RateCtrl;
  final TextEditingController p1MinCtrl;
  final TextEditingController p1MaxCtrl;
  final TextEditingController p1NoteCtrl;

  final TextEditingController p2LabelCtrl;
  final TextEditingController p2RateCtrl;
  final TextEditingController p2MinCtrl;
  final TextEditingController p2MaxCtrl;
  final TextEditingController p2NoteCtrl;

  final TextEditingController p3LabelCtrl;
  final TextEditingController p3RateCtrl;
  final TextEditingController p3BaseCtrl;
  final TextEditingController p3MinCtrl;
  final TextEditingController p3MaxCtrl;
  final TextEditingController p3NoteCtrl;

  const AdminPricingSliderTab({
    super.key,
    required this.p1LabelCtrl,
    required this.p1RateCtrl,
    required this.p1MinCtrl,
    required this.p1MaxCtrl,
    required this.p1NoteCtrl,
    required this.p2LabelCtrl,
    required this.p2RateCtrl,
    required this.p2MinCtrl,
    required this.p2MaxCtrl,
    required this.p2NoteCtrl,
    required this.p3LabelCtrl,
    required this.p3RateCtrl,
    required this.p3BaseCtrl,
    required this.p3MinCtrl,
    required this.p3MaxCtrl,
    required this.p3NoteCtrl,
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
            'Project Row & Slider Pricing Rules',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Har project ke liye per-row price (₹), row limits, aur notes set karein.',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),

          _projectRuleBlock(
            title: 'Project 1: Spreadsheet / Data Rows',
            labelCtrl: p1LabelCtrl,
            rateCtrl: p1RateCtrl,
            minCtrl: p1MinCtrl,
            maxCtrl: p1MaxCtrl,
            noteCtrl: p1NoteCtrl,
          ),

          _projectRuleBlock(
            title: 'Project 2: Lead / Data Cleaning Rows',
            labelCtrl: p2LabelCtrl,
            rateCtrl: p2RateCtrl,
            minCtrl: p2MinCtrl,
            maxCtrl: p2MaxCtrl,
            noteCtrl: p2NoteCtrl,
          ),

          _projectRuleBlock(
            title: 'Project 3: Dashboard & Analytics',
            labelCtrl: p3LabelCtrl,
            rateCtrl: p3RateCtrl,
            baseCtrl: p3BaseCtrl,
            minCtrl: p3MinCtrl,
            maxCtrl: p3MaxCtrl,
            noteCtrl: p3NoteCtrl,
          ),
        ],
      ),
    );
  }

  Widget _projectRuleBlock({
    required String title,
    required TextEditingController labelCtrl,
    required TextEditingController rateCtrl,
    TextEditingController? baseCtrl,
    required TextEditingController minCtrl,
    required TextEditingController maxCtrl,
    required TextEditingController noteCtrl,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Divider(color: Colors.white10),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFF59E0B),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _input(
          labelCtrl,
          'Project Label',
          'e.g. Excel / Sheets Data & Cleaning',
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _input(rateCtrl, 'Rate Per Row (₹)', 'e.g. 0.50')),
            if (baseCtrl != null) ...[
              const SizedBox(width: 12),
              Expanded(
                child: _input(baseCtrl, 'Dashboard Base Fee (₹)', 'e.g. 299'),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _input(minCtrl, 'Min Rows', 'e.g. 100')),
            const SizedBox(width: 12),
            Expanded(child: _input(maxCtrl, 'Max Rows', 'e.g. 20000')),
          ],
        ),
        const SizedBox(height: 12),
        _input(
          noteCtrl,
          'Pricing / Project Note',
          'Short note for client...',
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _input(
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
