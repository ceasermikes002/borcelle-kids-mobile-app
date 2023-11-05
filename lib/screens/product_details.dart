import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>? product;
  final AssetImage imageAsset;

  const ProductDetailsScreen({Key? key, this.product, required this.imageAsset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String productName = product?['name'] as String? ?? 'Product Name';
    final String productDescription = product?['description'] as String? ?? 'No Description';
    final double productPrice = product?['price'] as double? ?? 0.00;
    final bool productAvailable = product?['available'] as bool? ?? false;
    final String productGender = product?['gender'] as String? ?? 'Unknown';
    final String productSize = product?['size'] as String? ?? 'Unknown';
    final String productAgeGroup = product?['age_group'] as String? ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details for $productName',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xfffc91d1), // Top color
              Color(0xffFEB8e2), // Middle color
              Color(0xffff7eec), // Bottom color
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image(
                  image: imageAsset,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),
              Column(
                children: [
                  _buildListTile('Product Name', productName),
                  _buildListTile('Description', productDescription),
                  _buildListTile('Price', '\$${productPrice.toStringAsFixed(2)}'),
                  _buildListTile('Availability', productAvailable ? 'Available' : 'Not Available'),
                  _buildListTile('Gender', productGender),
                  _buildListTile('Size', productSize),
                  _buildListTile('Age Group', productAgeGroup),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.pink, // Set the bottom app bar color to pink
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                // Navigate to cart screen
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                // Add to favorites
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Navigate to profile screen
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile(String label, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      leading: const Icon(Icons.fiber_manual_record, size: 10, color: Colors.grey),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
