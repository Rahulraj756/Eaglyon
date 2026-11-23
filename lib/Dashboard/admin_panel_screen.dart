import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:my_practice_app/Dashboard/Tab_Screen/admin_about_tab.dart';
import 'package:my_practice_app/Dashboard/Tab_Screen/admin_contact_tab.dart';
import 'package:my_practice_app/Dashboard/Tab_Screen/admin_footer_tab.dart';
import 'package:my_practice_app/Dashboard/Tab_Screen/admin_hero_tab.dart';
import 'package:my_practice_app/Dashboard/Tab_Screen/admin_navbar_tab.dart';
import 'package:my_practice_app/Dashboard/Tab_Screen/admin_pricing_tab.dart';
import 'package:my_practice_app/Dashboard/Tab_Screen/admin_projects_tab.dart';
import 'package:my_practice_app/Dashboard/Tab_Screen/admin_services_tab.dart';
import 'package:my_practice_app/Dashboard/Tab_Screen/adnin_pricingSlider_tab.dart';
import 'package:my_practice_app/Data_Model/site_data.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // 0. Navbar Controllers
  final TextEditingController _logoController = TextEditingController();

  // 1. Hero Controllers
  final TextEditingController _heroBadgeController = TextEditingController();
  final TextEditingController _heroTitleWhiteController =
      TextEditingController();
  final TextEditingController _heroTitleGoldController =
      TextEditingController();
  final TextEditingController _heroDescController = TextEditingController();

  // 2. About Controllers
  final TextEditingController _aboutBadgeController = TextEditingController();
  final TextEditingController _aboutTitleController = TextEditingController();
  final TextEditingController _aboutHighlightController =
      TextEditingController();
  final TextEditingController _aboutDescController = TextEditingController();

  // 3. Services Controllers
  final TextEditingController _servicesBadgeController =
      TextEditingController();
  final TextEditingController _servicesTitleController =
      TextEditingController();
  final TextEditingController _servicesSubtitleController =
      TextEditingController();
  final TextEditingController _s1TitleController = TextEditingController();
  final TextEditingController _s1DescController = TextEditingController();
  final TextEditingController _s2TitleController = TextEditingController();
  final TextEditingController _s2DescController = TextEditingController();
  final TextEditingController _s3TitleController = TextEditingController();
  final TextEditingController _s3DescController = TextEditingController();

  // 4. Projects Header & Dynamic List
  final TextEditingController _projectsBadgeController =
      TextEditingController();
  final TextEditingController _projectsTitleController =
      TextEditingController();
  final TextEditingController _projectsSubtitleController =
      TextEditingController();
  List<ProjectItem> _projectsDraft = [];

  // 5. Pricing Controllers
  final TextEditingController _pricingBadgeController = TextEditingController();
  final TextEditingController _pricingTitleController = TextEditingController();
  final TextEditingController _pricingSubtitleController =
      TextEditingController();
  int _popularPlanIndex = SiteData.popularPlanIndex;

  final TextEditingController _plan1NameController = TextEditingController();
  final TextEditingController _plan1OneTimeController = TextEditingController();
  final TextEditingController _plan1MonthlyController = TextEditingController();
  final TextEditingController _plan1DescController = TextEditingController();
  final TextEditingController _plan1FeaturesController =
      TextEditingController();

  final TextEditingController _plan2NameController = TextEditingController();
  final TextEditingController _plan2OneTimeController = TextEditingController();
  final TextEditingController _plan2MonthlyController = TextEditingController();
  final TextEditingController _plan2DescController = TextEditingController();
  final TextEditingController _plan2FeaturesController =
      TextEditingController();

  final TextEditingController _plan3NameController = TextEditingController();
  final TextEditingController _plan3OneTimeController = TextEditingController();
  final TextEditingController _plan3MonthlyController = TextEditingController();
  final TextEditingController _plan3DescController = TextEditingController();
  final TextEditingController _plan3FeaturesController =
      TextEditingController();

  // 6. Slider & Row Pricing Controllers
  final TextEditingController _sp1LabelCtrl = TextEditingController();
  final TextEditingController _sp1RateCtrl = TextEditingController();
  final TextEditingController _sp1MinCtrl = TextEditingController();
  final TextEditingController _sp1MaxCtrl = TextEditingController();
  final TextEditingController _sp1NoteCtrl = TextEditingController();

  final TextEditingController _sp2LabelCtrl = TextEditingController();
  final TextEditingController _sp2RateCtrl = TextEditingController();
  final TextEditingController _sp2MinCtrl = TextEditingController();
  final TextEditingController _sp2MaxCtrl = TextEditingController();
  final TextEditingController _sp2NoteCtrl = TextEditingController();

  final TextEditingController _sp3LabelCtrl = TextEditingController();
  final TextEditingController _sp3RateCtrl = TextEditingController();
  final TextEditingController _sp3BaseCtrl = TextEditingController();
  final TextEditingController _sp3MinCtrl = TextEditingController();
  final TextEditingController _sp3MaxCtrl = TextEditingController();
  final TextEditingController _sp3NoteCtrl = TextEditingController();

  // 7. Contact Controllers
  final TextEditingController _contactBadgeCtrl = TextEditingController();
  final TextEditingController _contactTitleCtrl = TextEditingController();
  final TextEditingController _contactSubtitleCtrl = TextEditingController();
  final TextEditingController _contactEmailCtrl = TextEditingController();
  final TextEditingController _contactPhoneCtrl = TextEditingController();
  final TextEditingController _contactLocationCtrl = TextEditingController();

  // 8. Footer Controllers
  final TextEditingController _footerTaglineCtrl = TextEditingController();
  final TextEditingController _footerCopyrightCtrl = TextEditingController();

  bool _isDragging = false;
  String? _droppedImageName;
  Uint8List? _imageBytes;

  bool _isHeroDragging = false;
  String? _heroImageName;
  Uint8List? _heroImageBytes;

  int _selectedMenuIndex = 0;

  @override
  void initState() {
    super.initState();

    // 0. Navbar
    _logoController.text = SiteData.logoText;
    _logoController.addListener(() {
      if (mounted) setState(() {});
    });

    // 1. Hero
    _heroBadgeController.text = SiteData.heroBadge;
    _heroTitleWhiteController.text = SiteData.heroTitleWhite;
    _heroTitleGoldController.text = SiteData.heroTitleGold;
    _heroDescController.text = SiteData.heroDescription;
    _heroImageBytes = SiteData.heroImageBytes;

    // 2. About
    _aboutBadgeController.text = SiteData.aboutBadge;
    _aboutTitleController.text = SiteData.aboutTitle;
    _aboutHighlightController.text = SiteData.aboutHighlightText;
    _aboutDescController.text = SiteData.aboutDescription;

    // 3. Services
    _servicesBadgeController.text = SiteData.servicesBadge;
    _servicesTitleController.text = SiteData.servicesTitle;
    _servicesSubtitleController.text = SiteData.servicesSubtitle;
    _s1TitleController.text = SiteData.service1Title;
    _s1DescController.text = SiteData.service1Desc;
    _s2TitleController.text = SiteData.service2Title;
    _s2DescController.text = SiteData.service2Desc;
    _s3TitleController.text = SiteData.service3Title;
    _s3DescController.text = SiteData.service3Desc;

    // 4. Projects
    _projectsBadgeController.text = SiteData.projectsBadge;
    _projectsTitleController.text = SiteData.projectsTitle;
    _projectsSubtitleController.text = SiteData.projectsSubtitle;
    _projectsDraft = List<ProjectItem>.from(SiteData.projectList);

    // 5. Pricing
    _pricingBadgeController.text = SiteData.pricingBadge;
    _pricingTitleController.text = SiteData.pricingTitle;
    _pricingSubtitleController.text = SiteData.pricingSubtitle;
    _popularPlanIndex = SiteData.popularPlanIndex;

    _plan1NameController.text = SiteData.plan1Name;
    _plan1OneTimeController.text = SiteData.plan1OneTimePrice;
    _plan1MonthlyController.text = SiteData.plan1MonthlyPrice;
    _plan1DescController.text = SiteData.plan1Desc;
    _plan1FeaturesController.text = SiteData.plan1Features;

    _plan2NameController.text = SiteData.plan2Name;
    _plan2OneTimeController.text = SiteData.plan2OneTimePrice;
    _plan2MonthlyController.text = SiteData.plan2MonthlyPrice;
    _plan2DescController.text = SiteData.plan2Desc;
    _plan2FeaturesController.text = SiteData.plan2Features;

    _plan3NameController.text = SiteData.plan3Name;
    _plan3OneTimeController.text = SiteData.plan3OneTimePrice;
    _plan3MonthlyController.text = SiteData.plan3MonthlyPrice;
    _plan3DescController.text = SiteData.plan3Desc;
    _plan3FeaturesController.text = SiteData.plan3Features;

    // 6. Slider & Row Pricing
    _sp1LabelCtrl.text = SiteData.sliderProj1Label;
    _sp1RateCtrl.text = SiteData.sliderProj1RatePerRow.toString();
    _sp1MinCtrl.text = SiteData.sliderProj1MinRows.toString();
    _sp1MaxCtrl.text = SiteData.sliderProj1MaxRows.toString();
    _sp1NoteCtrl.text = SiteData.sliderProj1Note;

    _sp2LabelCtrl.text = SiteData.sliderProj2Label;
    _sp2RateCtrl.text = SiteData.sliderProj2RatePerRow.toString();
    _sp2MinCtrl.text = SiteData.sliderProj2MinRows.toString();
    _sp2MaxCtrl.text = SiteData.sliderProj2MaxRows.toString();
    _sp2NoteCtrl.text = SiteData.sliderProj2Note;

    _sp3LabelCtrl.text = SiteData.sliderProj3Label;
    _sp3RateCtrl.text = SiteData.sliderProj3RatePerRow.toString();
    _sp3BaseCtrl.text = SiteData.sliderProj3BaseFee.toString();
    _sp3MinCtrl.text = SiteData.sliderProj3MinRows.toString();
    _sp3MaxCtrl.text = SiteData.sliderProj3MaxRows.toString();
    _sp3NoteCtrl.text = SiteData.sliderProj3Note;

    // 7. Contact
    _contactBadgeCtrl.text = SiteData.contactBadge;
    _contactTitleCtrl.text = SiteData.contactTitle;
    _contactSubtitleCtrl.text = SiteData.contactSubtitle;
    _contactEmailCtrl.text = SiteData.contactEmail;
    _contactPhoneCtrl.text = SiteData.contactPhone;
    _contactLocationCtrl.text = SiteData.contactLocation;

    // 8. Footer
    _footerTaglineCtrl.text = SiteData.footerTagline;
    _footerCopyrightCtrl.text = SiteData.footerCopyright;
  }

  @override
  void dispose() {
    _logoController.dispose();

    _heroBadgeController.dispose();
    _heroTitleWhiteController.dispose();
    _heroTitleGoldController.dispose();
    _heroDescController.dispose();

    _aboutBadgeController.dispose();
    _aboutTitleController.dispose();
    _aboutHighlightController.dispose();
    _aboutDescController.dispose();

    _servicesBadgeController.dispose();
    _servicesTitleController.dispose();
    _servicesSubtitleController.dispose();
    _s1TitleController.dispose();
    _s1DescController.dispose();
    _s2TitleController.dispose();
    _s2DescController.dispose();
    _s3TitleController.dispose();
    _s3DescController.dispose();

    _projectsBadgeController.dispose();
    _projectsTitleController.dispose();
    _projectsSubtitleController.dispose();

    _pricingBadgeController.dispose();
    _pricingTitleController.dispose();
    _pricingSubtitleController.dispose();

    _plan1NameController.dispose();
    _plan1OneTimeController.dispose();
    _plan1MonthlyController.dispose();
    _plan1DescController.dispose();
    _plan1FeaturesController.dispose();

    _plan2NameController.dispose();
    _plan2OneTimeController.dispose();
    _plan2MonthlyController.dispose();
    _plan2DescController.dispose();
    _plan2FeaturesController.dispose();

    _plan3NameController.dispose();
    _plan3OneTimeController.dispose();
    _plan3MonthlyController.dispose();
    _plan3DescController.dispose();
    _plan3FeaturesController.dispose();

    _sp1LabelCtrl.dispose();
    _sp1RateCtrl.dispose();
    _sp1MinCtrl.dispose();
    _sp1MaxCtrl.dispose();
    _sp1NoteCtrl.dispose();

    _sp2LabelCtrl.dispose();
    _sp2RateCtrl.dispose();
    _sp2MinCtrl.dispose();
    _sp2MaxCtrl.dispose();
    _sp2NoteCtrl.dispose();

    _sp3LabelCtrl.dispose();
    _sp3RateCtrl.dispose();
    _sp3BaseCtrl.dispose();
    _sp3MinCtrl.dispose();
    _sp3MaxCtrl.dispose();
    _sp3NoteCtrl.dispose();

    _contactBadgeCtrl.dispose();
    _contactTitleCtrl.dispose();
    _contactSubtitleCtrl.dispose();
    _contactEmailCtrl.dispose();
    _contactPhoneCtrl.dispose();
    _contactLocationCtrl.dispose();

    _footerTaglineCtrl.dispose();
    _footerCopyrightCtrl.dispose();

    super.dispose();
  }

  Future<void> _handleSave() async {
    if (_selectedMenuIndex == 0) {
      final newLogo = _logoController.text.trim().isEmpty
          ? 'PORTFOLIO'
          : _logoController.text.trim();
      await SiteData.saveData(newLogo, imageBytes: _imageBytes);
    } else if (_selectedMenuIndex == 1) {
      await SiteData.saveHeroData(
        badge: _heroBadgeController.text.trim().isEmpty
            ? 'SHARP & FOCUSED'
            : _heroBadgeController.text.trim(),
        titleWhite: _heroTitleWhiteController.text,
        titleGold: _heroTitleGoldController.text,
        description: _heroDescController.text,
        imageBytes: _heroImageBytes,
      );
    } else if (_selectedMenuIndex == 2) {
      await SiteData.saveAboutData(
        badge: _aboutBadgeController.text.trim().isEmpty
            ? 'ABOUT ME'
            : _aboutBadgeController.text.trim(),
        title: _aboutTitleController.text.trim().isEmpty
            ? SiteData.aboutTitle
            : _aboutTitleController.text.trim(),
        description: _aboutDescController.text,
        highlightText: _aboutHighlightController.text.trim(),
      );
    } else if (_selectedMenuIndex == 3) {
      await SiteData.saveServicesData(
        badge: _servicesBadgeController.text.trim().isEmpty
            ? 'SERVICES'
            : _servicesBadgeController.text.trim(),
        title: _servicesTitleController.text.trim().isEmpty
            ? SiteData.servicesTitle
            : _servicesTitleController.text.trim(),
        subtitle: _servicesSubtitleController.text,
        s1Title: _s1TitleController.text.trim().isEmpty
            ? SiteData.service1Title
            : _s1TitleController.text.trim(),
        s1Desc: _s1DescController.text,
        s2Title: _s2TitleController.text.trim().isEmpty
            ? SiteData.service2Title
            : _s2TitleController.text.trim(),
        s2Desc: _s2DescController.text,
        s3Title: _s3TitleController.text.trim().isEmpty
            ? SiteData.service3Title
            : _s3TitleController.text.trim(),
        s3Desc: _s3DescController.text,
      );
    } else if (_selectedMenuIndex == 4) {
      await SiteData.saveProjectsHeaderAndList(
        badge: _projectsBadgeController.text.trim().isEmpty
            ? SiteData.projectsBadge
            : _projectsBadgeController.text.trim(),
        title: _projectsTitleController.text.trim().isEmpty
            ? SiteData.projectsTitle
            : _projectsTitleController.text.trim(),
        subtitle: _projectsSubtitleController.text,
        items: _projectsDraft,
      );
    } else if (_selectedMenuIndex == 5) {
      await SiteData.savePricingData(
        badge: _pricingBadgeController.text.trim().isEmpty
            ? 'PRICING & PLANS'
            : _pricingBadgeController.text.trim(),
        title: _pricingTitleController.text.trim().isEmpty
            ? SiteData.pricingTitle
            : _pricingTitleController.text.trim(),
        subtitle: _pricingSubtitleController.text,
        popularIndex: _popularPlanIndex,
        p1Name: _plan1NameController.text.trim().isEmpty
            ? SiteData.plan1Name
            : _plan1NameController.text.trim(),
        p1OneTime: _plan1OneTimeController.text.trim(),
        p1Monthly: _plan1MonthlyController.text.trim(),
        p1Desc: _plan1DescController.text,
        p1Features: _plan1FeaturesController.text,
        p2Name: _plan2NameController.text.trim().isEmpty
            ? SiteData.plan2Name
            : _plan2NameController.text.trim(),
        p2OneTime: _plan2OneTimeController.text.trim(),
        p2Monthly: _plan2MonthlyController.text.trim(),
        p2Desc: _plan2DescController.text,
        p2Features: _plan2FeaturesController.text,
        p3Name: _plan3NameController.text.trim().isEmpty
            ? SiteData.plan3Name
            : _plan3NameController.text.trim(),
        p3OneTime: _plan3OneTimeController.text.trim(),
        p3Monthly: _plan3MonthlyController.text.trim(),
        p3Desc: _plan3DescController.text,
        p3Features: _plan3FeaturesController.text,
      );
    } else if (_selectedMenuIndex == 6) {
      await SiteData.saveSliderPricingData(
        p1Label: _sp1LabelCtrl.text.trim().isEmpty
            ? SiteData.sliderProj1Label
            : _sp1LabelCtrl.text.trim(),
        p1Rate:
            double.tryParse(_sp1RateCtrl.text.trim()) ??
            SiteData.sliderProj1RatePerRow,
        p1MinRows:
            int.tryParse(_sp1MinCtrl.text.trim()) ??
            SiteData.sliderProj1MinRows,
        p1MaxRows:
            int.tryParse(_sp1MaxCtrl.text.trim()) ??
            SiteData.sliderProj1MaxRows,
        p1Note: _sp1NoteCtrl.text.trim(),
        p2Label: _sp2LabelCtrl.text.trim().isEmpty
            ? SiteData.sliderProj2Label
            : _sp2LabelCtrl.text.trim(),
        p2Rate:
            double.tryParse(_sp2RateCtrl.text.trim()) ??
            SiteData.sliderProj2RatePerRow,
        p2MinRows:
            int.tryParse(_sp2MinCtrl.text.trim()) ??
            SiteData.sliderProj2MinRows,
        p2MaxRows:
            int.tryParse(_sp2MaxCtrl.text.trim()) ??
            SiteData.sliderProj2MaxRows,
        p2Note: _sp2NoteCtrl.text.trim(),
        p3Label: _sp3LabelCtrl.text.trim().isEmpty
            ? SiteData.sliderProj3Label
            : _sp3LabelCtrl.text.trim(),
        p3Rate:
            double.tryParse(_sp3RateCtrl.text.trim()) ??
            SiteData.sliderProj3RatePerRow,
        p3BaseFee:
            double.tryParse(_sp3BaseCtrl.text.trim()) ??
            SiteData.sliderProj3BaseFee,
        p3MinRows:
            int.tryParse(_sp3MinCtrl.text.trim()) ??
            SiteData.sliderProj3MinRows,
        p3MaxRows:
            int.tryParse(_sp3MaxCtrl.text.trim()) ??
            SiteData.sliderProj3MaxRows,
        p3Note: _sp3NoteCtrl.text.trim(),
      );
    } else if (_selectedMenuIndex == 7) {
      await SiteData.saveContactData(
        badge: _contactBadgeCtrl.text.trim().isEmpty
            ? SiteData.contactBadge
            : _contactBadgeCtrl.text.trim(),
        title: _contactTitleCtrl.text.trim().isEmpty
            ? SiteData.contactTitle
            : _contactTitleCtrl.text.trim(),
        subtitle: _contactSubtitleCtrl.text,
        email: _contactEmailCtrl.text.trim().isEmpty
            ? SiteData.contactEmail
            : _contactEmailCtrl.text.trim(),
        phone: _contactPhoneCtrl.text.trim(),
        location: _contactLocationCtrl.text.trim(),
      );
    } else if (_selectedMenuIndex == 8) {
      await SiteData.saveFooterData(
        tagline: _footerTaglineCtrl.text.trim().isEmpty
            ? SiteData.footerTagline
            : _footerTaglineCtrl.text.trim(),
        copyright: _footerCopyrightCtrl.text.trim().isEmpty
            ? SiteData.footerCopyright
            : _footerCopyrightCtrl.text.trim(),
      );
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF1F2937),
        behavior: SnackBarBehavior.floating,
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Color(0xFFF59E0B)),
            SizedBox(width: 10),
            Text(
              'Changes saved permanently!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF0B0F19),
      endDrawer: !isDesktop ? _buildMobileSectionsDrawer() : null,
      body: Row(
        children: [
          if (isDesktop) _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildTopBar(isDesktop),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(isDesktop ? 32.0 : 16.0),
                    child: isDesktop
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 6, child: _buildCurrentEditor()),
                              const SizedBox(width: 24),
                              Expanded(flex: 4, child: _buildLivePreviewCard()),
                            ],
                          )
                        : Column(
                            children: [
                              _buildCurrentEditor(),
                              const SizedBox(height: 24),
                              _buildLivePreviewCard(),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileSectionsDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF0F1523),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.admin_panel_settings,
                        color: Color(0xFFF59E0B),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'ADMIN SECTIONS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white10, height: 1),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _drawerSectionItem(0, Icons.web_asset, 'Navbar & Brand'),
                  _drawerSectionItem(1, Icons.bolt, 'Hero Section'),
                  _drawerSectionItem(2, Icons.person_outline, 'About Section'),
                  _drawerSectionItem(
                    3,
                    Icons.design_services_outlined,
                    'Services Section',
                  ),
                  _drawerSectionItem(
                    4,
                    Icons.folder_open_outlined,
                    'Projects Section',
                  ),
                  _drawerSectionItem(
                    5,
                    Icons.payments_outlined,
                    'Pricing Section',
                  ),
                  _drawerSectionItem(6, Icons.tune, 'Slider & Row Pricing'),
                  _drawerSectionItem(
                    7,
                    Icons.contact_mail_outlined,
                    'Contact Section',
                  ),
                  _drawerSectionItem(
                    8,
                    Icons.horizontal_rule_rounded,
                    'Footer Section',
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white10, height: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white70,
                    side: const BorderSide(color: Colors.white24),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close drawer
                    Navigator.pop(context); // Back to website
                  },
                  icon: const Icon(Icons.arrow_back, size: 18),
                  label: const Text('Back to Website'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerSectionItem(int index, IconData icon, String title) {
    final bool isSelected = _selectedMenuIndex == index;
    return ListTile(
      leading: Icon(
        icon,
        size: 20,
        color: isSelected ? const Color(0xFFF59E0B) : Colors.white54,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? const Color(0xFFF59E0B) : Colors.white70,
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: const Color(0xFFF59E0B).withValues(alpha: 0.1),
      onTap: () {
        setState(() => _selectedMenuIndex = index);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildCurrentEditor() {
    switch (_selectedMenuIndex) {
      case 1:
        return AdminHeroTab(
          badgeController: _heroBadgeController,
          titleWhiteController: _heroTitleWhiteController,
          titleGoldController: _heroTitleGoldController,
          descController: _heroDescController,
          imageBytes: _heroImageBytes,
          imageName: _heroImageName,
          isDragging: _isHeroDragging,
          onDragStateChanged: (val) => setState(() => _isHeroDragging = val),
          onImagePicked: (bytes, name) => setState(() {
            _heroImageBytes = bytes;
            _heroImageName = name;
          }),
          onImageCleared: () => setState(() {
            _heroImageBytes = null;
            _heroImageName = null;
          }),
        );
      case 2:
        return AdminAboutTab(
          badgeController: _aboutBadgeController,
          titleController: _aboutTitleController,
          highlightController: _aboutHighlightController,
          descController: _aboutDescController,
        );
      case 3:
        return AdminServicesTab(
          badgeController: _servicesBadgeController,
          titleController: _servicesTitleController,
          subtitleController: _servicesSubtitleController,
          s1TitleController: _s1TitleController,
          s1DescController: _s1DescController,
          s2TitleController: _s2TitleController,
          s2DescController: _s2DescController,
          s3TitleController: _s3TitleController,
          s3DescController: _s3DescController,
        );
      case 4:
        return AdminProjectsTab(
          badgeController: _projectsBadgeController,
          titleController: _projectsTitleController,
          subtitleController: _projectsSubtitleController,
          projects: _projectsDraft,
          onAddProjectTop: (newProj) {
            setState(() {
              _projectsDraft.insert(0, newProj);
            });
          },
          onRemoveProjectAt: (idx) {
            setState(() {
              _projectsDraft.removeAt(idx);
            });
          },
        );
      case 5:
        return AdminPricingTab(
          badgeController: _pricingBadgeController,
          titleController: _pricingTitleController,
          subtitleController: _pricingSubtitleController,
          popularPlanIndex: _popularPlanIndex,
          onPopularChanged: (val) => setState(() => _popularPlanIndex = val),
          p1NameController: _plan1NameController,
          p1OneTimeController: _plan1OneTimeController,
          p1MonthlyController: _plan1MonthlyController,
          p1DescController: _plan1DescController,
          p1FeaturesController: _plan1FeaturesController,
          p2NameController: _plan2NameController,
          p2OneTimeController: _plan2OneTimeController,
          p2MonthlyController: _plan2MonthlyController,
          p2DescController: _plan2DescController,
          p2FeaturesController: _plan2FeaturesController,
          p3NameController: _plan3NameController,
          p3OneTimeController: _plan3OneTimeController,
          p3MonthlyController: _plan3MonthlyController,
          p3DescController: _plan3DescController,
          p3FeaturesController: _plan3FeaturesController,
        );
      case 6:
        return AdminPricingSliderTab(
          p1LabelCtrl: _sp1LabelCtrl,
          p1RateCtrl: _sp1RateCtrl,
          p1MinCtrl: _sp1MinCtrl,
          p1MaxCtrl: _sp1MaxCtrl,
          p1NoteCtrl: _sp1NoteCtrl,
          p2LabelCtrl: _sp2LabelCtrl,
          p2RateCtrl: _sp2RateCtrl,
          p2MinCtrl: _sp2MinCtrl,
          p2MaxCtrl: _sp2MaxCtrl,
          p2NoteCtrl: _sp2NoteCtrl,
          p3LabelCtrl: _sp3LabelCtrl,
          p3RateCtrl: _sp3RateCtrl,
          p3BaseCtrl: _sp3BaseCtrl,
          p3MinCtrl: _sp3MinCtrl,
          p3MaxCtrl: _sp3MaxCtrl,
          p3NoteCtrl: _sp3NoteCtrl,
        );
      case 7:
        return AdminContactTab(
          badgeController: _contactBadgeCtrl,
          titleController: _contactTitleCtrl,
          subtitleController: _contactSubtitleCtrl,
          emailController: _contactEmailCtrl,
          phoneController: _contactPhoneCtrl,
          locationController: _contactLocationCtrl,
        );
      case 8:
        return AdminFooterTab(
          taglineController: _footerTaglineCtrl,
          copyrightController: _footerCopyrightCtrl,
        );
      default:
        return AdminNavbarTab(
          logoController: _logoController,
          logoImageBytes: _imageBytes,
          imageName: _droppedImageName,
          isDragging: _isDragging,
          onDragStateChanged: (val) => setState(() => _isDragging = val),
          onImagePicked: (bytes, name) => setState(() {
            _imageBytes = bytes;
            _droppedImageName = name;
          }),
          onImageCleared: () => setState(() {
            _imageBytes = null;
            _droppedImageName = null;
          }),
        );
    }
  }

  Widget _buildSidebar() {
    return Container(
      width: 250,
      decoration: const BoxDecoration(
        color: Color(0xFF0F1523),
        border: Border(right: BorderSide(color: Colors.white10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.admin_panel_settings,
                    color: Color(0xFFF59E0B),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'ADMIN CMS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white10, height: 1),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _sidebarItem(0, Icons.web_asset, 'Navbar & Brand'),
                _sidebarItem(1, Icons.bolt, 'Hero Section'),
                _sidebarItem(2, Icons.person_outline, 'About Section'),
                _sidebarItem(
                  3,
                  Icons.design_services_outlined,
                  'Services Section',
                ),
                _sidebarItem(4, Icons.folder_open_outlined, 'Projects Section'),
                _sidebarItem(5, Icons.payments_outlined, 'Pricing Section'),
                _sidebarItem(6, Icons.tune, 'Slider & Row Pricing'),
                _sidebarItem(7, Icons.contact_mail_outlined, 'Contact Section'),
                _sidebarItem(
                  8,
                  Icons.horizontal_rule_rounded,
                  'Footer Section',
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white10, height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white70,
                  side: const BorderSide(color: Colors.white24),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, size: 18),
                label: const Text('Back to Website'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sidebarItem(int index, IconData icon, String title) {
    final bool isSelected = _selectedMenuIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedMenuIndex = index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFF59E0B).withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFF59E0B).withValues(alpha: 0.4)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 19,
              color: isSelected ? const Color(0xFFF59E0B) : Colors.white54,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white60,
                  fontSize: 13.5,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(bool isDesktop) {
    String heading = 'Navbar & Brand Settings';
    String subHeading = 'Customize your website logo text and brand icon';

    if (_selectedMenuIndex == 1) {
      heading = 'Hero Section Settings';
      subHeading = 'Update badge, main heading, description, and hero image';
    } else if (_selectedMenuIndex == 2) {
      heading = 'About Section Settings';
      subHeading = 'Update about badge, heading, description, and highlight';
    } else if (_selectedMenuIndex == 3) {
      heading = 'Services Section Settings';
      subHeading = 'Customize services heading and all three service cards';
    } else if (_selectedMenuIndex == 4) {
      heading = 'Projects Section & Grid Settings';
      subHeading =
          'Add new projects to the top row with sample image & details';
    } else if (_selectedMenuIndex == 5) {
      heading = 'Pricing Section Settings';
      subHeading = 'Manage plans, prices, popular badge, and features';
    } else if (_selectedMenuIndex == 6) {
      heading = 'Slider & Row Pricing Settings';
      subHeading = 'Set per-row rates, row ranges, and dashboard setup fees';
    } else if (_selectedMenuIndex == 7) {
      heading = 'Contact Section Settings';
      subHeading = 'Update contact heading, email, phone, and location';
    } else if (_selectedMenuIndex == 8) {
      heading = 'Footer Section Settings';
      subHeading = 'Update footer tagline and copyright notice';
    }

    return Container(
      height: 72,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 32 : 12),
      decoration: const BoxDecoration(
        color: Color(0xFF0F1523),
        border: Border(bottom: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        children: [
          if (!isDesktop)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subHeading,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF59E0B),
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 20 : 12,
                vertical: isDesktop ? 14 : 10,
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: _handleSave,
            icon: const Icon(Icons.save_outlined, size: 17),
            label: Text(
              isDesktop ? 'Save Changes' : 'Save',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          if (!isDesktop) ...[
            const SizedBox(width: 4),
            IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFFF59E0B)),
              tooltip: 'All Sections',
              onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLivePreviewCard() {
    final previewText = _logoController.text.trim().isEmpty
        ? 'PORTFOLIO'
        : _logoController.text.trim();

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
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'LIVE NAVBAR PREVIEW',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF0B0F19),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white12),
            ),
            child: Row(
              children: [
                if (_imageBytes != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.memory(
                      _imageBytes!,
                      width: 28,
                      height: 28,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                ] else ...[
                  const Icon(Icons.bolt, color: Color(0xFFF59E0B), size: 22),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    previewText,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFFF59E0B),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Text(
                  'Home',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Projects',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Tip: Kisi bhi tab me changes bharne ke baad upar "Save Changes" dabayein, phir website par wapas jaakar naya data dekhein.',
            style: TextStyle(color: Colors.white38, fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }
}
