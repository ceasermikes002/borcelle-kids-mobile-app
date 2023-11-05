import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> mockProducts;

  FavoritesScreen({required this.mockProducts});

  @override
  Widget build(BuildContext context) {
    // Filter the mockProducts to show only liked products
    final List<Map<String, dynamic>> likedProducts = mockProducts
        .expand((category) => category['products'] as List<Map<String, dynamic>>)
        .where((product) => product['liked'] == 1)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Products'),
      ),
      body: ListView.builder(
        itemCount: likedProducts.length,
        itemBuilder: (context, index) {
          final product = likedProducts[index];
          // Build your UI to display the liked product
        },
      ),
    );
  }
}
