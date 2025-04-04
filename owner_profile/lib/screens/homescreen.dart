import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pet_plus_new/provider/user_provider.dart';
import 'package:pet_plus_new/screens/Appointment/book_appointment_page.dart';
import 'package:pet_plus_new/screens/Boarding%20Places/boarding_places_page.dart';
import 'package:pet_plus_new/screens/Grooming/grooming.dart';
import 'package:pet_plus_new/screens/pet%20info/pet_info.dart';
import 'package:pet_plus_new/screens/profile/profile.dart';
import 'package:pet_plus_new/screens/reminder/reminder.dart';
import 'package:pet_plus_new/screens/settings.dart';
import 'package:pet_plus_new/screens/shop/shop.dart';
import 'package:pet_plus_new/screens/training/training_page.dart';
import 'package:pet_plus_new/widgets/homecard.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    PetListScreen(),
    ReminderScreen(),
    const SettingsPage(),
  ];

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  Future<void> _getUserInfo() async {
    if (context.read<UserProvider>().user == null) {
      await context.read<UserProvider>().getUserData();
      print(
        "Image URL ${context.read<UserProvider>().user!.profilePictureURL}",
      );
      print("Email ${context.read<UserProvider>().user!.email}");
      print("Name ${context.read<UserProvider>().user!.username}");
      print("Phone ${context.read<UserProvider>().user!.contactNumber}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          context.watch<UserProvider>().isLoading
              ? Scaffold(
                body: Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
              : Scaffold(
                body: _screens[_currentIndex],
                bottomNavigationBar: ConvexAppBar(
                  backgroundColor: Color.fromARGB(
                    255,
                    20,
                    32,
                    166,
                  ).withOpacity(0.2),
                  activeColor: Colors.white,
                  height: 60,
                  curve: Curves.easeInOut,
                  color: const Color.fromARGB(255, 75, 73, 73),
                  items: const [
                    TabItem(icon: Icon(Icons.home, size: 30.0), title: 'Home'),
                    TabItem(
                      icon: Icon(Icons.info, size: 30.0),
                      title: 'Pet Info',
                    ),
                    TabItem(
                      icon: Icon(Icons.alarm, size: 30.0),
                      title: 'Reminder',
                    ),
                    TabItem(
                      icon: Icon(Icons.settings, size: 30.0),
                      title: 'Settings',
                    ),
                  ],
                  initialActiveIndex: _currentIndex,
                  onTap: (int index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int _carouselIndex = 0;

  final List<Map<String, String>> carouselItems = [
    {
      "title": "Pet Health Alert",
      "description": "Watch out for seasonal allergies in pets",
      "color": "#FF5252",
      "image": "assets/health_alert.jpg",
    },
    {
      "title": "Latest Pet News",
      "description": "New pet vaccination guidelines released",
      "color": "#448AFF",
      "image": "assets/pet_news.jpg",
    },
    {
      "title": "Common Illness",
      "description": "Signs of heartworm disease in dogs",
      "color": "#66BB6A",
      "image": "assets/pet_illness.jpeg",
    },
    {
      "title": "Pet Care Tip",
      "description": "Dental hygiene importance in cats",
      "color": "#AB47BC",
      "image": "assets/pet_care.jpg",
    },
    {
      "title": "Breaking News",
      "description": "New treatment for canine arthritis",
      "color": "#FF7043",
      "image": "assets/breaking_news.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 20, 32, 166).withOpacity(0.2),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/pet.png', width: 55),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF242424),
                    ),
                  ),
                  Text(
                    context.read<UserProvider>().user!.username,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF242424),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Profile()),
                    ),
                child: ClipOval(
                  child: SizedBox(
                    height: 48,
                    width: 48,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/pet.png',
                      image:
                          context.read<UserProvider>().user!.profilePictureURL,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      },
                      placeholderFit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 500),
                      fadeInCurve: Curves.easeIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            CarouselSlider.builder(
              itemCount: carouselItems.length,
              itemBuilder: (context, index, realIndex) {
                final item = carouselItems[index];
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(
                      int.parse(item["color"]!.replaceAll('#', '0xFF')),
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["title"]!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item["description"]!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(15),
                          ),
                          child: Image.asset(
                            item["image"]!,
                            fit: BoxFit.cover,
                            height: double.infinity,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              options: CarouselOptions(
                height: 160,
                viewportFraction: 0.85,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                onPageChanged: (index, reason) {
                  setState(() {
                    _carouselIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  carouselItems.asMap().entries.map((entry) {
                    return Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _carouselIndex == entry.key
                                ? Color.fromARGB(255, 20, 32, 166)
                                : Colors.blue.shade100,
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 25),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Homecard(
                      icon: Icons.medical_services_sharp,
                      title: "Doctor",
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BookAppointmentPage(),
                            ),
                          ),
                    ),
                    Homecard(
                      icon: Icons.cut_sharp,
                      title: "Groomings",
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroomingScreen(),
                            ),
                          ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Homecard(
                      icon: Icons.model_training_outlined,
                      title: "Training",
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TrainingPage(),
                            ),
                          ),
                    ),
                    Homecard(
                      icon: Icons.pets_sharp,
                      title: "Boarding Place",
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BoardingPlacesPage(),
                            ),
                          ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Shop()),
                    ),
                child: Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 20, 32, 166),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 67, 66, 66),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 45,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Shop',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
