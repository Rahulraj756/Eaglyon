import 'package:flutter/material.dart';
import 'package:my_practice_app/Data_Model/site_data.dart';

class FooterSection extends StatelessWidget {
  final ValueChanged<String>? onMenuSelected;

  const FooterSection({super.key, this.onMenuSelected});

  static const List<String> _navItems = [
    'Home',
    'About',
    'Services',
    'Projects',
    'Pricing',
    'Contact',
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF0F1523),
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 24.0,
        vertical: isDesktop ? 44.0 : 32.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: _buildBrandBlock()),
                    const SizedBox(width: 32),
                    Expanded(flex: 5, child: _buildQuickLinks(isDesktop)),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBrandBlock(),
                    const SizedBox(height: 24),
                    _buildQuickLinks(isDesktop),
                  ],
                ),

          const SizedBox(height: 28),
          const Divider(color: Colors.white10),
          const SizedBox(height: 16),

          // Bottom Copyright Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  SiteData.footerCopyright,
                  style: const TextStyle(color: Colors.white38, fontSize: 12.5),
                ),
              ),
              Text(
                SiteData.contactLocation,
                style: const TextStyle(color: Colors.white38, fontSize: 12.5),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBrandBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.bolt, color: Color(0xFFF59E0B), size: 22),
            const SizedBox(width: 8),
            Text(
              SiteData.logoText,
              style: const TextStyle(
                color: Color(0xFFF59E0B),
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          SiteData.footerTagline,
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 14,
            height: 1.55,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickLinks(bool isDesktop) {
    return Column(
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Navigation',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 10,
          alignment: isDesktop ? WrapAlignment.end : WrapAlignment.start,
          children: _navItems.map((item) {
            return InkWell(
              onTap: () => onMenuSelected?.call(item),
              child: Text(
                item,
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
