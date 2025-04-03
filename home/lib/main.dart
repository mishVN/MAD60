import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController();
  final List<String> bannerTexts = [
    "Pet Care",
    "Quality Services",
    "Happy Pets"
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Pet Care',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, size: 30, color: Colors.white),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          /// Carousel Slider for Banners
          CarouselSlider(
            options: CarouselOptions(
              height: 180,
              autoPlay: true,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: bannerTexts.map((text) {
              return BannerPage(text);
            }).toList(),
          ),

          /// Services Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Our Services',
              style: GoogleFonts.poppins(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return ServiceButton(services[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Chat with Support");
        },
        backgroundColor: Colors.teal,
        child: Icon(Icons.chat, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Alerts"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}

/// Services List
final List<String> services = [
  'Vet',
  'Grooming',
  'Boarding',
  'Training',
  'Pet Foods',
  'Checkups',
];

class BannerPage extends StatelessWidget {
  final String text;
  BannerPage(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.teal,
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ServiceButton extends StatelessWidget {
  final String service;
  ServiceButton(this.service);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print('$service clicked');
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.teal.shade400,
        foregroundColor: Colors.white,
      ),
      child: Text(
        service,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
