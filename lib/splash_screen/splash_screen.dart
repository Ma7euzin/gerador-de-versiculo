import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geradorversiculos/home_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Container(
            color: Colors.black87,
            child: Image.asset('assets/SUETAMSOFT.png'),
          ),
        ],
      ),
    );
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 5), (_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const Versiculos(),
        ),
      );
    });
  }
}
