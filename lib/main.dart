import 'package:flutter/material.dart';
import 'package:app_infants/screens/splash_screen.dart';
import 'package:app_infants/screens/product_list.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Baby's Life Store",
      theme: ThemeData(
        primaryColor: Colors.pink,
        hintColor: Colors.blue,
        fontFamily: 'Arial',
      ),
      home: const SplashScreen(),
      routes: {
        '/productList': (context) => const ProductsListScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key}); // Remove 'const' from the constructor

  final AudioPlayer audioPlayer = AudioPlayer(); // Create an instance of AudioPlayer

  void playSound() async {
    await audioPlayer.play('assets/sounds/sound1.mp3' as Source); // Replace 'assets/sound.mp3' with the path to your audio file
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                'assets/logo.png',
                height: 40,
              ),
            ),
            const Text("BORCELLE KIDS STORE"),
          ],
        ),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        decoration: const BoxDecoration(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                playSound(); // Play the sound when the image is tapped
              },
              child: Image.asset(
                'assets/baby.png',
                height: 200,
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  "Welcome to Borcelle's kids store, where you can shop your baby's product. Bringing comfort to infants...",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'MarkoOne', // Replace 'ChildishFont' with your chosen childish font
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0x80fc91d1), // Light version of the background color
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Add padding
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/productList');
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Open Store',
                    style: TextStyle(
                      color: Colors.blue, // Make the button text blue
                      fontSize: 18,
                      fontFamily: 'PlaypenSans', // Replace 'ChildishFont' with your chosen childish font
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
