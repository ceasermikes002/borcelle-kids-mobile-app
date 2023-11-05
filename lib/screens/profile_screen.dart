import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: Colors.pink, // Change the background color to match your app's theme
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xfffc91d1), // #fc91d1 at the top
              Color(0xffFEB8e2), // #FEB8e2 at the middle
              Color(0xffff7eec), // #ff7eec at the bottom
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/user_profile_image.jpg'), // Replace with the user's profile image
              ),
              const SizedBox(height: 20),
              const Text(
                'Divine Ebuka', // Replace with the user's name
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'divineebuka@gmail.com', // Replace with the user's email
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const Text('My Orders'),
                onTap: () {
                  // Navigate to user's orders page
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('My Favorites'),
                onTap: () {
                  // Navigate to user's favorites page
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  // Navigate to user settings page
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
