import 'package:flutter/material.dart';
import 'package:my_practice_app/Data_Model/site_data.dart';
import 'package:my_practice_app/Screens/projects_grid_screen.dart';
import 'package:my_practice_app/Themes_Data/themes_colors.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onExploreWorks;
  const HeroSection({super.key, this.onExploreWorks});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 900;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: screenHeight - 80),
      decoration: const BoxDecoration(color: AppColors.backgroundDark),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80.0 : 24.0,
        vertical: 40.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 5, child: _buildLeftContent(context)),
                    const SizedBox(width: 40),
                    Expanded(flex: 6, child: _buildRightEagleImageCard()),
                  ],
                )
              : Column(
                  children: [
                    _buildLeftContent(context),
                    const SizedBox(height: 40),
                    _buildRightEagleImageCard(),
                  ],
                ),

          const SizedBox(height: 50),
          _buildStatsBar(context),
        ],
      ),
    );
  }

  Widget _buildLeftContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFF59E0B), width: 0.5),
          ),
          child: Text(
            '⚡ ${SiteData.heroBadge}',
            style: const TextStyle(
              color: Color(0xFFF59E0B),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            text: SiteData.heroTitleWhite,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.15,
            ),
            children: <TextSpan>[
              TextSpan(
                text: SiteData.heroTitleGold,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF59E0B),
                  letterSpacing: 1.15,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          SiteData.heroDescription,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF94A3B8),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 35),
        Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF59E0B),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                if (onExploreWorks != null) {
                  onExploreWorks!();
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProjectsGridScreen(),
                    ),
                  );
                }
              },
              child: const Text(
                'Explore Works',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            const SizedBox(width: 16),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white24),
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Contact Me',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRightEagleImageCard() {
    return Center(
      child: Container(
        height: 400,
        width: 440,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: SiteData.heroImageBytes != null
              ? Image.memory(SiteData.heroImageBytes!, fit: BoxFit.cover)
              : Image.network(
                  'https://plus.unsplash.com/premium_photo-1664304354144-9201500b8aeb?q=80&w=863&auto=format&fit=crop',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.pets, size: 80, color: Color(0xFFF59E0B)),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildStatsBar(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: isDesktop
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(number: "10+", label: "Projects Built"),
                  _StatItem(number: "100%", label: "Focus & Quality"),
                  _StatItem(number: "50+", label: "Happy Clients"),
                  _StatItem(number: "100%", label: "Fast Delivery"),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Expanded(
                        child: Center(
                          child: _StatItem(
                            number: "10+",
                            label: "Projects Built",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: _StatItem(
                            number: "100%",
                            label: "Focus & Quality",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Expanded(
                        child: Center(
                          child: _StatItem(
                            number: "50+",
                            label: "Happy Clients",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: _StatItem(
                            number: "24/7",
                            label: "Execution Ready",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String number;
  final String label;

  const _StatItem({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: Color(0xFFF59E0B),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
        ),
      ],
    );
  }
}
