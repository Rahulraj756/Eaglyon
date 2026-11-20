import 'package:flutter/material.dart';
import 'package:my_practice_app/Data_Model/site_data.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

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
              '⚡ ${SiteData.servicesBadge}',
              style: const TextStyle(
                color: Color(0xFFF59E0B),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Section Heading
          Text(
            SiteData.servicesTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              height: 1.2,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),

          // Section Subtitle
          Text(
            SiteData.servicesSubtitle,
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 16,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 36),

          // Service Cards (Desktop: 3 Columns, Mobile: Stacked)
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildServiceCard(
                        icon: Icons.table_view_outlined,
                        title: SiteData.service1Title,
                        description: SiteData.service1Desc,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildServiceCard(
                        icon: Icons.query_stats_outlined,
                        title: SiteData.service2Title,
                        description: SiteData.service2Desc,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildServiceCard(
                        icon: Icons.devices_outlined,
                        title: SiteData.service3Title,
                        description: SiteData.service3Desc,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _buildServiceCard(
                      icon: Icons.table_view_outlined,
                      title: SiteData.service1Title,
                      description: SiteData.service1Desc,
                    ),
                    const SizedBox(height: 16),
                    _buildServiceCard(
                      icon: Icons.query_stats_outlined,
                      title: SiteData.service2Title,
                      description: SiteData.service2Desc,
                    ),
                    const SizedBox(height: 16),
                    _buildServiceCard(
                      icon: Icons.devices_outlined,
                      title: SiteData.service3Title,
                      description: SiteData.service3Desc,
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFFF59E0B), size: 24),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 14,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}
