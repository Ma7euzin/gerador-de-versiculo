
import 'package:flutter/material.dart';
import 'package:geradorversiculos/home_page.dart';
import 'package:geradorversiculos/splash_screen/splash_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key,}) : super(key: key);
  
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );

  }
}
