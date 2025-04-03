import 'package:flutter/material.dart';

void main() {
  runApp(AnimalBoardingApp());
}

class AnimalBoardingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BoardingPlacesScreen(),
    );
  }
}

class BoardingPlacesScreen extends StatelessWidget {
  final List<Map<String, String>> places = [
    {
      "name": "Happy Paws Boarding",
      "location": "Colombo, Sri Lanka",
      "rating": "4.5",
      "image": "https://via.placeholder.com/150"
    },
    {
      "name": "Safe Haven Pet Care",
      "location": "Kandy, Sri Lanka",
      "rating": "4.8",
      "image": "https://via.placeholder.com/150"
    },
    {
      "name": "Furry Friends Lodge",
      "location": "Galle, Sri Lanka",
      "rating": "4.3",
      "image": "https://via.placeholder.com/150"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Boarding Places"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search places...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(places[index]["image"]!),
                    title: Text(places[index]["name"]!,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(places[index]["location"]!),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        Text(places[index]["rating"]!),
                      ],
                    ),
                    onTap: () {
                      // Navigate to details page (future implementation)
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}