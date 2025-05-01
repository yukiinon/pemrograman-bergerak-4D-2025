import 'dart:typed_data';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String title = args['title'];
    final String location = args['location'];
    final String price = args['price'];
    final String description = args['description'];
    final Uint8List? imageBytes = args['imageBytes'];
    final String category = args['category'] ?? 'Wisata Alam';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageBytes != null
                  ? Image.memory(
                      imageBytes,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/img/Rectangle.png',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.nature, size: 20, color: Colors.grey),
                SizedBox(width: 4),
                Text(category, style: TextStyle(fontSize: 14)),
                SizedBox(width: 16),
                Icon(Icons.location_on, size: 20, color: Colors.grey),
                SizedBox(width: 4),
                Text(location, style: TextStyle(fontSize: 14)),
                Spacer(),
                Row(
                  children: [
                    Icon(Icons.monetization_on, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      price,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(fontSize: 14, height: 1.6),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
