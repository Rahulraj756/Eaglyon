import 'package:shared_preferences/shared_preferences.dart';

class HeroDataModel {
  static final HeroDataModel _instance = HeroDataModel._internal();
  factory HeroDataModel() => _instance;
  HeroDataModel._internal();

  // Values
  String heroTitle = "Hi, I'm\nRahul Raj.";
  String heroSubtitle = "Brand & Web Designer\nbased in Ghaziabad, India.";
  String heroBio =
      "I help startups and creative brands build thoughtful identities and digital experiences that connect.";
  String heroImage =
      "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500&auto=format&fit=crop&q=60";

  // Local Storage se data load karne ke liye
  Future<void> loadDataFromLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    heroTitle = prefs.getString('heroTitle') ?? heroTitle;
    heroSubtitle = prefs.getString('heroSubtitle') ?? heroSubtitle;
    heroBio = prefs.getString('heroBio') ?? heroBio;
    heroImage = prefs.getString('heroImage') ?? heroImage;
  }

  // Local Storage me data save karne ke liye
  Future<void> saveDataToLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('heroTitle', heroTitle);
    await prefs.setString('heroSubtitle', heroSubtitle);
    await prefs.setString('heroBio', heroBio);
    await prefs.setString('heroImage', heroImage);
  }
}
