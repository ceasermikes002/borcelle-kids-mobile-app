import 'package:app_infants/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>  HomeScreen(),
        ),
      );
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration( // Remove "const" from here to customize the decoration
          gradient: LinearGradient(
            colors: [
              Color(0xfffc91d1), // #fc91d1 at the top
              Color(0xffFEB8e2), // #FEB8e2 at the middle
              Color(0xffff7eec), // #ff7eec at the bottom
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Image.asset('assets/splash_screen_logo.png'), // Add your logo here
        ),
      ),
    );
  }
}
