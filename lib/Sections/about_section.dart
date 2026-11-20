import 'package:flutter/material.dart';
import 'package:my_practice_app/Data_Model/site_data.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      width: double.infinity,
      color: const Color(0xFF0B0F19),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 24.0,
        vertical: isDesktop ? 72.0 : 48.0,
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 6, child: _buildLeftContent()),
                const SizedBox(width: 40),
                Expanded(flex: 4, child: _buildRightCards()),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLeftContent(),
                const SizedBox(height: 32),
                _buildRightCards(),
              ],
            ),
    );
  }

  Widget _buildLeftContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFF59E0B), width: 0.6),
          ),
          child: Text(
            '⚡ ${SiteData.aboutBadge}',
            style: const TextStyle(
              color: Color(0xFFF59E0B),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // About Title
        Text(
          SiteData.aboutTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
            height: 1.2,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 18),

        // About Description
        Text(
          SiteData.aboutDescription,
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 16,
            height: 1.65,
          ),
        ),
        const SizedBox(height: 24),

        // Highlight Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF111827),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.verified_outlined,
                color: Color(0xFFF59E0B),
                size: 18,
              ),
              const SizedBox(width: 10),
              Text(
                SiteData.aboutHighlightText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRightCards() {
    return Column(
      children: [
        _featureCard(
          icon: Icons.table_chart_outlined,
          title: 'Data Cleaning & Automation',
          description: 'Structured sheets, clean formulas, and automated workflows with zero manual clutter.',
        ),
        const SizedBox(height: 16),
        _featureCard(
          icon: Icons.dashboard_customize_outlined,
          title: 'Modern UI & App Craft',
          description: 'Clean, responsive interfaces built with dark precision and smooth user experience.',
        ),
      ],
    );
  }

  Widget _featureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFFF59E0B), size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
