import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';

class ProjectItem {
  final String id;
  final String title;
  final String tag;
  final String shortDesc;
  final String fullDetails;
  final String toolsUsed;
  final String outcome;
  final Uint8List? sampleImageBytes;

  ProjectItem({
    required this.id,
    required this.title,
    required this.tag,
    required this.shortDesc,
    required this.fullDetails,
    required this.toolsUsed,
    required this.outcome,
    this.sampleImageBytes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'tag': tag,
      'shortDesc': shortDesc,
      'fullDetails': fullDetails,
      'toolsUsed': toolsUsed,
      'outcome': outcome,
      'sampleImageBase64': sampleImageBytes != null
          ? base64Encode(sampleImageBytes!)
          : null,
    };
  }

  factory ProjectItem.fromJson(Map<String, dynamic> json) {
    Uint8List? bytes;
    final b64 = json['sampleImageBase64'] as String?;
    if (b64 != null && b64.isNotEmpty) {
      try {
        bytes = base64Decode(b64);
      } catch (_) {
        bytes = null;
      }
    }

    return ProjectItem(
      id:
          json['id'] as String? ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: json['title'] as String? ?? 'Untitled Project',
      tag: json['tag'] as String? ?? 'SPREADSHEET',
      shortDesc: json['shortDesc'] as String? ?? '',
      fullDetails: json['fullDetails'] as String? ?? '',
      toolsUsed: json['toolsUsed'] as String? ?? 'Excel • Google Sheets',
      outcome: json['outcome'] as String? ?? 'Clean & error-free delivery',
      sampleImageBytes: bytes,
    );
  }
}

class SiteData {
  // Navbar Data
  static String logoText = 'PORTFOLIO';
  static Uint8List? logoImageBytes;

  // Hero Section Data
  static String heroBadge = 'SHARP & FOCUSED';
  static String heroTitleWhite = 'Transforming Data\nDriving ';
  static String heroTitleGold = 'Decisions.';
  static String heroDescription =
      'Precision in every cell, accuracy in every report.\nTransforming complex data into crystal-clear insights.\nAutomating workflows to save your valuable business hours.';
  static Uint8List? heroImageBytes;

  // About Section Data
  static String aboutBadge = 'ABOUT ME';
  static String aboutTitle = 'Turning Raw Data Into Smart Decisions';
  static String aboutDescription =
      'I help businesses organize messy spreadsheets, automate repetitive workflows, and build clean digital interfaces.\nEvery formula, report, and layout is crafted for speed, accuracy, and clarity.';
  static String aboutHighlightText = 'Excel • Google Sheets • Flutter';

  // Services Section Data
  static String servicesBadge = 'SERVICES';
  static String servicesTitle = 'Solutions Built For Speed & Accuracy';
  static String servicesSubtitle =
      'Practical spreadsheet solutions, data workflows, and clean web/app interfaces tailored for real business needs.';

  static String service1Title = 'Excel & Google Sheets';
  static String service1Desc =
      'Data cleaning, formulas, dashboards, automated trackers, and clean formatting with zero clutter.';

  static String service2Title = 'Data & Lead Workflows';
  static String service2Desc =
      'Structured contact lists, PDF to sheet conversions, and organized data pipelines ready for action.';

  static String service3Title = 'Web & App Interfaces';
  static String service3Desc =
      'Responsive Flutter web & mobile UIs with modern dark themes, live previews, and smooth navigation.';

  // Projects Section Header Data
  static String projectsBadge = 'PROJECTS';
  static String projectsTitle = 'Selected Work & Case Studies';
  static String projectsSubtitle =
      'Grid showcase of real projects. Click "View More Details" on any card to inspect sample previews and full scope.';

  // Dynamic Grid Projects List (Newest project stays at index 0 -> top row)
  static List<ProjectItem> projectList = [
    ProjectItem(
      id: 'proj_3',
      title: 'Editable Portfolio & Admin CMS',
      tag: 'FLUTTER WEB',
      shortDesc: 'Responsive dark-gold portfolio with modular admin tabs and local persistence.',
      fullDetails: 'Built a multi-section portfolio architecture where every section can be updated from a modular Admin Panel. Supports instant UI refresh upon return and persistent local storage across browser sessions.',
      toolsUsed: 'Flutter • Dart • SharedPreferences',
      outcome: 'Modular, maintainable codebase with live admin editing',
    ),
    ProjectItem(
      id: 'proj_2',
      title: 'Messy Dataset & Lead List Cleanup',
      tag: 'DATA CLEANING',
      shortDesc: 'Removed duplicates, standardized columns, and prepared clean outreach sheets.',
      fullDetails: 'Cleaned raw exported lists containing inconsistent casing, blank cells, duplicate entries, and mixed phone/text formats. Structured into filter-ready sheets with validation rules.',
      toolsUsed: 'Excel • Google Sheets • XLOOKUP • FILTER • UNIQUE',
      outcome: '100% structured dataset ready for daily team use',
    ),
    ProjectItem(
      id: 'proj_1',
      title: 'Automated Sales & Invoice Tracker',
      tag: 'EXCEL & SHEETS',
      shortDesc: 'Dynamic formulas, summary metrics, and clean tracking without manual rework.',
      fullDetails: 'Designed a structured sales and billing tracker with automated totals, status counts, and summary views so business owners can check daily/monthly numbers at a glance.',
      toolsUsed: 'Excel • SUMIF • COUNTIF • Pivot Tables',
      outcome: 'Faster reporting with zero manual formula errors',
    ),
  ];

  // Pricing Section Data
  static String pricingBadge = 'PRICING & PLANS';
  static String pricingTitle = 'Transparent Pricing For Every Stage';
  static String pricingSubtitle =
      'Clear packages for quick spreadsheet fixes, full workflow automation, and ongoing monthly support.';
  static int popularPlanIndex = 1;

  static String plan1Name = 'Starter Fix';
  static String plan1OneTimePrice = '\$49';
  static String plan1MonthlyPrice = '\$99/mo';
  static String plan1Desc =
      'Best for quick data cleaning, formatting, or a single sheet task.';
  static String plan1Features =
      'Data cleaning & deduplication\nUp to 5,000 rows\nClean formatting & basic formulas\n2-day delivery';

  static String plan2Name = 'Workflow Pro';
  static String plan2OneTimePrice = '\$149';
  static String plan2MonthlyPrice = '\$249/mo';
  static String plan2Desc =
      'Ideal for automated trackers, dashboards, and structured lead sheets.';
  static String plan2Features =
      'Advanced formulas & dashboards\nAutomated tracker setup\nPDF / raw data conversion\nPriority support & revisions';

  static String plan3Name = 'Custom & UI';
  static String plan3OneTimePrice = '\$299';
  static String plan3MonthlyPrice = '\$449/mo';
  static String plan3Desc =
      'Tailored data systems, multi-sheet workflows, and Flutter UI modules.';
  static String plan3Features =
      'Custom end-to-end architecture\nMulti-sheet / app integration\nDocumentation & handover\nDedicated ongoing assistance';

  // Slider / Row Pricing Data
  static String sliderProj1Label = 'Excel / Sheets Data & Cleaning';
  static double sliderProj1RatePerRow = 0.50;
  static int sliderProj1MinRows = 100;
  static int sliderProj1MaxRows = 20000;
  static String sliderProj1Note =
      'Clean formatting, deduplication, aur formula check har row par apply hota hai.';

  static String sliderProj2Label = 'Lead List & Data Structuring';
  static double sliderProj2RatePerRow = 0.80;
  static int sliderProj2MinRows = 100;
  static int sliderProj2MaxRows = 15000;
  static String sliderProj2Note =
      'Structured columns, contact cleanup, aur ready-to-use sheet format.';

  static String sliderProj3Label = 'Interactive Dashboard & Report';
  static double sliderProj3RatePerRow = 1.50;
  static double sliderProj3BaseFee = 299.0;
  static int sliderProj3MinRows = 500;
  static int sliderProj3MaxRows = 50000;
  static String sliderProj3Note =
      '500 rows dashboard ~₹1,049 | 2,000 rows ~₹3,299 | 10,000 rows ~₹15,299 (Base setup + per-row data volume).';

  // Contact Section Data
  static String contactBadge = 'CONTACT ME';
  static String contactTitle = 'Let’s Build Something Clean & Fast';
  static String contactSubtitle =
      'Need help with Excel/Google Sheets automation, data cleanup, or a Flutter interface? Send a message or reach out directly.';
  static String contactEmail = 'rahulraj.work@example.com';
  static String contactPhone = '+91 98765 43210';
  static String contactLocation = 'Ghaziabad, Delhi-NCR, India';

  // Footer Section Data
  static String footerTagline =
      'Precision spreadsheets, automated workflows, and clean digital interfaces.';
  static String footerCopyright = '© 2026 All rights reserved.';

  static get logoImage => null;

  static Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    logoText = prefs.getString('saved_logo_text') ?? logoText;
    final logoImageBase64 = prefs.getString('saved_logo_image');
    if (logoImageBase64 != null && logoImageBase64.isNotEmpty) {
      logoImageBytes = base64Decode(logoImageBase64);
    }

    heroBadge = prefs.getString('saved_hero_badge') ?? heroBadge;
    heroTitleWhite =
        prefs.getString('saved_hero_title_white') ?? heroTitleWhite;
    heroTitleGold = prefs.getString('saved_hero_title_gold') ?? heroTitleGold;
    heroDescription = prefs.getString('saved_hero_desc') ?? heroDescription;

    final imgBase64 = prefs.getString('saved_hero_image');
    if (imgBase64 != null && imgBase64.isNotEmpty) {
      heroImageBytes = base64Decode(imgBase64);
    }

    aboutBadge = prefs.getString('saved_about_badge') ?? aboutBadge;
    aboutTitle = prefs.getString('saved_about_title') ?? aboutTitle;
    aboutDescription = prefs.getString('saved_about_desc') ?? aboutDescription;
    aboutHighlightText =
        prefs.getString('saved_about_highlight') ?? aboutHighlightText;

    servicesBadge = prefs.getString('saved_services_badge') ?? servicesBadge;
    servicesTitle = prefs.getString('saved_services_title') ?? servicesTitle;
    servicesSubtitle =
        prefs.getString('saved_services_subtitle') ?? servicesSubtitle;
    service1Title = prefs.getString('saved_service_1_title') ?? service1Title;
    service1Desc = prefs.getString('saved_service_1_desc') ?? service1Desc;
    service2Title = prefs.getString('saved_service_2_title') ?? service2Title;
    service2Desc = prefs.getString('saved_service_2_desc') ?? service2Desc;
    service3Title = prefs.getString('saved_service_3_title') ?? service3Title;
    service3Desc = prefs.getString('saved_service_3_desc') ?? service3Desc;

    projectsBadge = prefs.getString('saved_projects_badge') ?? projectsBadge;
    projectsTitle = prefs.getString('saved_projects_title') ?? projectsTitle;
    projectsSubtitle =
        prefs.getString('saved_projects_subtitle') ?? projectsSubtitle;

    final savedProjectsJson = prefs.getString('saved_projects_list_json');
    if (savedProjectsJson != null && savedProjectsJson.isNotEmpty) {
      try {
        final decoded = jsonDecode(savedProjectsJson) as List<dynamic>;
        projectList = decoded
            .map((item) => ProjectItem.fromJson(item as Map<String, dynamic>))
            .toList();
      } catch (_) {
        // Keep defaults if parse fails
      }
    }

    pricingBadge = prefs.getString('saved_pricing_badge') ?? pricingBadge;
    pricingTitle = prefs.getString('saved_pricing_title') ?? pricingTitle;
    pricingSubtitle =
        prefs.getString('saved_pricing_subtitle') ?? pricingSubtitle;
    popularPlanIndex =
        prefs.getInt('saved_popular_plan_index') ?? popularPlanIndex;

    plan1Name = prefs.getString('saved_plan_1_name') ?? plan1Name;
    plan1OneTimePrice =
        prefs.getString('saved_plan_1_onetime') ?? plan1OneTimePrice;
    plan1MonthlyPrice =
        prefs.getString('saved_plan_1_monthly') ?? plan1MonthlyPrice;
    plan1Desc = prefs.getString('saved_plan_1_desc') ?? plan1Desc;
    plan1Features = prefs.getString('saved_plan_1_features') ?? plan1Features;

    plan2Name = prefs.getString('saved_plan_2_name') ?? plan2Name;
    plan2OneTimePrice =
        prefs.getString('saved_plan_2_onetime') ?? plan2OneTimePrice;
    plan2MonthlyPrice =
        prefs.getString('saved_plan_2_monthly') ?? plan2MonthlyPrice;
    plan2Desc = prefs.getString('saved_plan_2_desc') ?? plan2Desc;
    plan2Features = prefs.getString('saved_plan_2_features') ?? plan2Features;

    plan3Name = prefs.getString('saved_plan_3_name') ?? plan3Name;
    plan3OneTimePrice =
        prefs.getString('saved_plan_3_onetime') ?? plan3OneTimePrice;
    plan3MonthlyPrice =
        prefs.getString('saved_plan_3_monthly') ?? plan3MonthlyPrice;
    plan3Desc = prefs.getString('saved_plan_3_desc') ?? plan3Desc;
    plan3Features = prefs.getString('saved_plan_3_features') ?? plan3Features;

    sliderProj1Label =
        prefs.getString('saved_slider_p1_label') ?? sliderProj1Label;
    sliderProj1RatePerRow =
        prefs.getDouble('saved_slider_p1_rate') ?? sliderProj1RatePerRow;
    sliderProj1MinRows =
        prefs.getInt('saved_slider_p1_min') ?? sliderProj1MinRows;
    sliderProj1MaxRows =
        prefs.getInt('saved_slider_p1_max') ?? sliderProj1MaxRows;
    sliderProj1Note =
        prefs.getString('saved_slider_p1_note') ?? sliderProj1Note;

    sliderProj2Label =
        prefs.getString('saved_slider_p2_label') ?? sliderProj2Label;
    sliderProj2RatePerRow =
        prefs.getDouble('saved_slider_p2_rate') ?? sliderProj2RatePerRow;
    sliderProj2MinRows =
        prefs.getInt('saved_slider_p2_min') ?? sliderProj2MinRows;
    sliderProj2MaxRows =
        prefs.getInt('saved_slider_p2_max') ?? sliderProj2MaxRows;
    sliderProj2Note =
        prefs.getString('saved_slider_p2_note') ?? sliderProj2Note;

    sliderProj3Label =
        prefs.getString('saved_slider_p3_label') ?? sliderProj3Label;
    sliderProj3RatePerRow =
        prefs.getDouble('saved_slider_p3_rate') ?? sliderProj3RatePerRow;
    sliderProj3BaseFee =
        prefs.getDouble('saved_slider_p3_base') ?? sliderProj3BaseFee;
    sliderProj3MinRows =
        prefs.getInt('saved_slider_p3_min') ?? sliderProj3MinRows;
    sliderProj3MaxRows =
        prefs.getInt('saved_slider_p3_max') ?? sliderProj3MaxRows;
    sliderProj3Note =
        prefs.getString('saved_slider_p3_note') ?? sliderProj3Note;

    contactBadge = prefs.getString('saved_contact_badge') ?? contactBadge;
    contactTitle = prefs.getString('saved_contact_title') ?? contactTitle;
    contactSubtitle =
        prefs.getString('saved_contact_subtitle') ?? contactSubtitle;
    contactEmail = prefs.getString('saved_contact_email') ?? contactEmail;
    contactPhone = prefs.getString('saved_contact_phone') ?? contactPhone;
    contactLocation =
        prefs.getString('saved_contact_location') ?? contactLocation;

    footerTagline = prefs.getString('saved_footer_tagline') ?? footerTagline;
    footerCopyright =
        prefs.getString('saved_footer_copyright') ?? footerCopyright;
  }

  static Future<void> saveData(String newLogo, {Uint8List? imageBytes}) async {
    final prefs = await SharedPreferences.getInstance();
    logoText = newLogo;
    await prefs.setString('saved_logo_text', newLogo);

    logoImageBytes = imageBytes;
    if (imageBytes != null) {
      await prefs.setString('saved_logo_image', base64Encode(imageBytes));
    } else {
      await prefs.remove('saved_logo_image');
    }
  }

  static Future<void> saveHeroData({
    required String badge,
    required String titleWhite,
    required String titleGold,
    required String description,
    Uint8List? imageBytes,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    heroBadge = badge;
    heroTitleWhite = titleWhite;
    heroTitleGold = titleGold;
    heroDescription = description;
    if (imageBytes != null) {
      heroImageBytes = imageBytes;
      await prefs.setString('saved_hero_image', base64Encode(imageBytes));
    }

    await prefs.setString('saved_hero_badge', badge);
    await prefs.setString('saved_hero_title_white', titleWhite);
    await prefs.setString('saved_hero_title_gold', titleGold);
    await prefs.setString('saved_hero_desc', description);
  }

  static Future<void> saveAboutData({
    required String badge,
    required String title,
    required String description,
    required String highlightText,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    aboutBadge = badge;
    aboutTitle = title;
    aboutDescription = description;
    aboutHighlightText = highlightText;

    await prefs.setString('saved_about_badge', badge);
    await prefs.setString('saved_about_title', title);
    await prefs.setString('saved_about_desc', description);
    await prefs.setString('saved_about_highlight', highlightText);
  }

  static Future<void> saveServicesData({
    required String badge,
    required String title,
    required String subtitle,
    required String s1Title,
    required String s1Desc,
    required String s2Title,
    required String s2Desc,
    required String s3Title,
    required String s3Desc,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    servicesBadge = badge;
    servicesTitle = title;
    servicesSubtitle = subtitle;
    service1Title = s1Title;
    service1Desc = s1Desc;
    service2Title = s2Title;
    service2Desc = s2Desc;
    service3Title = s3Title;
    service3Desc = s3Desc;

    await prefs.setString('saved_services_badge', badge);
    await prefs.setString('saved_services_title', title);
    await prefs.setString('saved_services_subtitle', subtitle);
    await prefs.setString('saved_service_1_title', s1Title);
    await prefs.setString('saved_service_1_desc', s1Desc);
    await prefs.setString('saved_service_2_title', s2Title);
    await prefs.setString('saved_service_2_desc', s2Desc);
    await prefs.setString('saved_service_3_title', s3Title);
    await prefs.setString('saved_service_3_desc', s3Desc);
  }

  static Future<void> saveProjectsHeaderAndList({
    required String badge,
    required String title,
    required String subtitle,
    required List<ProjectItem> items,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    projectsBadge = badge;
    projectsTitle = title;
    projectsSubtitle = subtitle;
    projectList = List<ProjectItem>.from(items);

    await prefs.setString('saved_projects_badge', badge);
    await prefs.setString('saved_projects_title', title);
    await prefs.setString('saved_projects_subtitle', subtitle);

    final encoded = jsonEncode(projectList.map((e) => e.toJson()).toList());
    await prefs.setString('saved_projects_list_json', encoded);
  }

  static Future<void> savePricingData({
    required String badge,
    required String title,
    required String subtitle,
    required int popularIndex,
    required String p1Name,
    required String p1OneTime,
    required String p1Monthly,
    required String p1Desc,
    required String p1Features,
    required String p2Name,
    required String p2OneTime,
    required String p2Monthly,
    required String p2Desc,
    required String p2Features,
    required String p3Name,
    required String p3OneTime,
    required String p3Monthly,
    required String p3Desc,
    required String p3Features,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    pricingBadge = badge;
    pricingTitle = title;
    pricingSubtitle = subtitle;
    popularPlanIndex = popularIndex;

    plan1Name = p1Name;
    plan1OneTimePrice = p1OneTime;
    plan1MonthlyPrice = p1Monthly;
    plan1Desc = p1Desc;
    plan1Features = p1Features;

    plan2Name = p2Name;
    plan2OneTimePrice = p2OneTime;
    plan2MonthlyPrice = p2Monthly;
    plan2Desc = p2Desc;
    plan2Features = p2Features;

    plan3Name = p3Name;
    plan3OneTimePrice = p3OneTime;
    plan3MonthlyPrice = p3Monthly;
    plan3Desc = p3Desc;
    plan3Features = p3Features;

    await prefs.setString('saved_pricing_badge', badge);
    await prefs.setString('saved_pricing_title', title);
    await prefs.setString('saved_pricing_subtitle', subtitle);
    await prefs.setInt('saved_popular_plan_index', popularIndex);

    await prefs.setString('saved_plan_1_name', p1Name);
    await prefs.setString('saved_plan_1_onetime', p1OneTime);
    await prefs.setString('saved_plan_1_monthly', p1Monthly);
    await prefs.setString('saved_plan_1_desc', p1Desc);
    await prefs.setString('saved_plan_1_features', p1Features);

    await prefs.setString('saved_plan_2_name', p2Name);
    await prefs.setString('saved_plan_2_onetime', p2OneTime);
    await prefs.setString('saved_plan_2_monthly', p2Monthly);
    await prefs.setString('saved_plan_2_desc', p2Desc);
    await prefs.setString('saved_plan_2_features', p2Features);

    await prefs.setString('saved_plan_3_name', p3Name);
    await prefs.setString('saved_plan_3_onetime', p3OneTime);
    await prefs.setString('saved_plan_3_monthly', p3Monthly);
    await prefs.setString('saved_plan_3_desc', p3Desc);
    await prefs.setString('saved_plan_3_features', p3Features);
  }

  static Future<void> saveSliderPricingData({
    required String p1Label,
    required double p1Rate,
    required int p1MinRows,
    required int p1MaxRows,
    required String p1Note,
    required String p2Label,
    required double p2Rate,
    required int p2MinRows,
    required int p2MaxRows,
    required String p2Note,
    required String p3Label,
    required double p3Rate,
    required double p3BaseFee,
    required int p3MinRows,
    required int p3MaxRows,
    required String p3Note,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    sliderProj1Label = p1Label;
    sliderProj1RatePerRow = p1Rate;
    sliderProj1MinRows = p1MinRows;
    sliderProj1MaxRows = p1MaxRows;
    sliderProj1Note = p1Note;

    sliderProj2Label = p2Label;
    sliderProj2RatePerRow = p2Rate;
    sliderProj2MinRows = p2MinRows;
    sliderProj2MaxRows = p2MaxRows;
    sliderProj2Note = p2Note;

    sliderProj3Label = p3Label;
    sliderProj3RatePerRow = p3Rate;
    sliderProj3BaseFee = p3BaseFee;
    sliderProj3MinRows = p3MinRows;
    sliderProj3MaxRows = p3MaxRows;
    sliderProj3Note = p3Note;

    await prefs.setString('saved_slider_p1_label', p1Label);
    await prefs.setDouble('saved_slider_p1_rate', p1Rate);
    await prefs.setInt('saved_slider_p1_min', p1MinRows);
    await prefs.setInt('saved_slider_p1_max', p1MaxRows);
    await prefs.setString('saved_slider_p1_note', p1Note);

    await prefs.setString('saved_slider_p2_label', p2Label);
    await prefs.setDouble('saved_slider_p2_rate', p2Rate);
    await prefs.setInt('saved_slider_p2_min', p2MinRows);
    await prefs.setInt('saved_slider_p2_max', p2MaxRows);
    await prefs.setString('saved_slider_p2_note', p2Note);

    await prefs.setString('saved_slider_p3_label', p3Label);
    await prefs.setDouble('saved_slider_p3_rate', p3Rate);
    await prefs.setDouble('saved_slider_p3_base', p3BaseFee);
    await prefs.setInt('saved_slider_p3_min', p3MinRows);
    await prefs.setInt('saved_slider_p3_max', p3MaxRows);
    await prefs.setString('saved_slider_p3_note', p3Note);
  }

  static Future<void> saveContactData({
    required String badge,
    required String title,
    required String subtitle,
    required String email,
    required String phone,
    required String location,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    contactBadge = badge;
    contactTitle = title;
    contactSubtitle = subtitle;
    contactEmail = email;
    contactPhone = phone;
    contactLocation = location;

    await prefs.setString('saved_contact_badge', badge);
    await prefs.setString('saved_contact_title', title);
    await prefs.setString('saved_contact_subtitle', subtitle);
    await prefs.setString('saved_contact_email', email);
    await prefs.setString('saved_contact_phone', phone);
    await prefs.setString('saved_contact_location', location);
  }

  static Future<void> saveFooterData({
    required String tagline,
    required String copyright,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    footerTagline = tagline;
    footerCopyright = copyright;

    await prefs.setString('saved_footer_tagline', tagline);
    await prefs.setString('saved_footer_copyright', copyright);
  }
}
