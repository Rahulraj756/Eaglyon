import 'package:flutter/material.dart';
import 'package:my_practice_app/Data_Model/site_data.dart';
import 'package:my_practice_app/Screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // App open hone se pehle local storage se data load karein
  await SiteData.loadData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eaglyon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF1F5F9),
      ),
      home: const HomeScreen(),
    );
  }
}
