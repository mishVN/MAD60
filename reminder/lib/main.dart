import 'package:flutter/material.dart';

class ReminderPage extends StatelessWidget {
  final List<Map<String, String>> reminders = [
    {
      'title': 'Rabies Vaccination',
      'pet': 'Bella',
      'date': 'April 8, 2025',
      'time': '10:00 AM'
    },
    {
      'title': 'Deworming Schedule',
      'pet': 'Max',
      'date': 'April 10, 2025',
      'time': '2:00 PM'
    },
    {
      'title': 'General Checkup',
      'pet': 'Luna',
      'date': 'April 15, 2025',
      'time': '11:00 AM'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Reminders'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          final reminder = reminders[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(Icons.pets, color: Colors.teal),
              title: Text(reminder['title'] ?? ''),
              subtitle: Text('${reminder['pet']} • ${reminder['date']} at ${reminder['time']}'),
              trailing: Icon(Icons.notifications_active, color: Colors.orange),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add reminder page or show dialog
        },
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
        tooltip: 'Add Reminder',
      ),
    );
  }
}
