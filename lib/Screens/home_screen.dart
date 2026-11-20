import 'package:flutter/material.dart';
import 'package:my_practice_app/Dashboard/admin_panel_screen.dart';
import 'package:my_practice_app/Screens/projects_section.dart';
import 'package:my_practice_app/Sections/about_section.dart';
import 'package:my_practice_app/Sections/hero_section.dart';
import 'package:my_practice_app/Sections/pricing_section.dart';
import 'package:my_practice_app/Sections/services_section.dart';
import 'package:my_practice_app/navbar_section.dart';
import 'package:my_practice_app/Sections/contact_section.dart';
import 'package:my_practice_app/Sections/footer_section.dart';
import 'package:my_practice_app/Screens/projects_grid_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _pricingKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(String menuTitle) {
    GlobalKey? targetKey;
    switch (menuTitle) {
      case 'Home':
        targetKey = _homeKey;
        break;
      case 'About':
        targetKey = _aboutKey;
        break;
      case 'Services':
        targetKey = _servicesKey;
        break;
      case 'Projects':
        targetKey = _projectsKey;
        break;
      case 'Pricing':
        targetKey = _pricingKey;
        break;
      case 'Contact':
        targetKey = _contactKey;
        break;
    }

    if (targetKey != null && targetKey.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  void _openAdminPanel() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdminPanelScreen()),
    ).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      appBar: NavbarSection(
        onMenuSelected: (menu) => _scrollToSection(menu),
        onAdminClosed: () {
          if (mounted) {
            setState(() {});
          }
        },
        onAdminPressed: _openAdminPanel,
      ),
      endDrawer: MobileEndDrawer(
        onMenuSelected: (menu) => _scrollToSection(menu),
        onAdminPressed: _openAdminPanel,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              key: _homeKey,
              child: HeroSection(
                onExploreWorks: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProjectsGridScreen(),
                    ),
                  );
                },
              ),
            ),
            Container(key: _aboutKey, child: const AboutSection()),
            Container(key: _servicesKey, child: const ServicesSection()),
            Container(key: _projectsKey, child: const ProjectsSection()),

            // Aane wale sections
            Container(
              key: _pricingKey,
              child: PricingSection(
                onSelectPlan: (selectedPlan) {
                  _scrollToSection('Contact');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color(0xFF1F2937),
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'Selected: $selectedPlan',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(key: _contactKey, child: const ContactSection()),
            FooterSection(onMenuSelected: (menu) => _scrollToSection(menu)),
          ],
        ),
      ),
    );
  }
}
