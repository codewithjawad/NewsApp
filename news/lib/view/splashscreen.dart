import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/view/homescreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homescreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/splash.jpg',
            fit: BoxFit.cover,
            height: height * 0.5,
            width: width * 1,
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Text(
            "Top Headlines",
            style: GoogleFonts.anton(
              letterSpacing: 6,
            ),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          const SpinKitChasingDots(
            color: Colors.blue,
            size: 50,
          )
        ],
      ),
    );
  }
}
