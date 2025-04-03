import 'package:flutter/material.dart';
import 'add_feedback_screen.dart';
import 'view_feedback_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animal Services',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BoardingPlaceScreen(),
    );
  }
}

class BoardingPlaceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Boarding Places")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddFeedbackScreen(boardingPlaceId: 'place_id')),
              );
            },
            child: Text("Add Feedback"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewFeedbackScreen()),
              );
            },
            child: Text("View Feedback"),
          ),
        ],
      ),
    );
  }
}