import 'package:flutter/material.dart';
import 'newdata.dart';
import 'lastpage.dart';
// import 'dart:typed_data';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/list': (context) => ListScreen(),
        '/detail': (context) => DetailScreen(),
        '/newdata': (context) => NewDataPage(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> customPlaces = [];

  void _navigateToNewData() async {
    final newData = await Navigator.pushNamed(context, '/newdata');
    if (newData != null && newData is Map<String, dynamic>) {
      setState(() {
        customPlaces.add(newData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add, color: Colors.white, size: 32),
        onPressed: _navigateToNewData,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hi, User 👋',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/img/Ellipse.png'),
                  ),  
                ],
              ),
              SizedBox(height: 24),
              _buildSectionTitle(context, 'Hot Places'),
              SizedBox(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    PlaceCard(
                      title: 'National Park Yosemite',
                      description: 'California',
                      isHorizontal: true,
                      image: AssetImage('assets/img/Rectangle.png'),
                      onTap: () {
                        Navigator.pushNamed(context, '/detail', arguments: {
                          'title': 'National Park Yosemite',
                          'location': 'California',
                          'price': '30000',
                          'description': 'A beautiful national park.',
                          'imageBytes': null,
                          'category': 'Wisata Alam',
                        });
                      },
                    ),
                    ...customPlaces.map((place) => PlaceCard(
                          title: place['nama'],
                          description: place['lokasi'],
                          isHorizontal: true,
                          image: MemoryImage(place['imageBytes']),
                          onTap: () {
                            Navigator.pushNamed(context, '/detail', arguments: {
                              'title': place['nama'],
                              'location': place['lokasi'],
                              'price': place['harga'].toString(),
                              'description': place['deskripsi'],
                              'imageBytes': place['imageBytes'],
                              'category': place['kategori'] ?? 'Wisata Alam',
                            });
                          },
                        )),
                  ],
                ),
              ),
              SizedBox(height: 24),
              _buildSectionTitle(context, 'Best Hotels'),
              Expanded(
                child: ListView(
                  children: [
                    PlaceCard(
                      title: 'National Park Yosemite',
                      description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
                      isHorizontal: false,
                      image: AssetImage('assets/img/Rectangle.png'),
                      onTap: () {
                        Navigator.pushNamed(context, '/detail', arguments: {
                          'title': 'National Park Yosemite',
                          'location': 'California',
                          'price': '30000',
                          'description': 'Lorem ipsum dolor sit amet...',
                          'imageBytes': null,
                          'category': 'Wisata Alam',
                        });
                      },
                    ),
                    ...customPlaces.map((place) => PlaceCard(
                          title: place['nama'],
                          description: place['deskripsi'],
                          isHorizontal: false,
                          image: MemoryImage(place['imageBytes']),
                          onTap: () {
                            Navigator.pushNamed(context, '/detail', arguments: {
                              'title': place['nama'],
                              'location': place['lokasi'],
                              'price': place['harga'].toString(),
                              'description': place['deskripsi'],
                              'imageBytes': place['imageBytes'],
                              'category': place['kategori'] ?? 'Wisata Alam',
                            });
                          },
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/list');
          },
          child: Text('See All', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}

class PlaceCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isHorizontal;
  final ImageProvider image;
  final VoidCallback onTap;

  const PlaceCard({
    required this.title,
    required this.description,
    required this.isHorizontal,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isHorizontal ? 230 : double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image(
                image: image,
                width: isHorizontal ? 50 : 80,
                height: isHorizontal ? 50 : 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 6),
                  Text(description,
                      style: TextStyle(fontSize: 13),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Places'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => PlaceCard(
            title: 'National Park Yosemite',
            description: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quis, doloribus.',
            isHorizontal: false,
            image: AssetImage('assets/img/Rectangle.png'),
            onTap: () {
              Navigator.pushNamed(context, '/detail', arguments: {
                'title': 'National Park Yosemite',
                'location': 'California',
                'price': '30000',
                'description': 'Lorem ipsum dolor sit amet...',
                'imageBytes': null,
                'category': 'Wisata Alam',
              });
            },
          ),
        ),
      ),
    );
  }
}
