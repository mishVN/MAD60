import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Settings Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile Settings'),
            onTap: () {
              // Profile settings action
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Languages'),
            onTap: () {
              // Languages action
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text('Dark Mode'),
            trailing: Switch(
              value: false, // You can implement dark mode logic
              onChanged: (value) {},
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help & Support'),
            onTap: () {
              // Help & Support action
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.pets),
            title: Text('Pet Information Management'),
            onTap: () {
              // Pet Info action
            },
          ),
        ],
      ),
    );
  }
}