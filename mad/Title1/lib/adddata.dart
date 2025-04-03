import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddGroomingPlaceScreen extends StatefulWidget {
  @override
  _AddGroomingPlaceScreenState createState() => _AddGroomingPlaceScreenState();
}

class _AddGroomingPlaceScreenState extends State<AddGroomingPlaceScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  final CollectionReference groomingPlaces = FirebaseFirestore.instance.collection('grooming_places');

  Future<void> _addGroomingPlace() async {
    String name = _nameController.text;
    double latitude = double.tryParse(_latitudeController.text) ?? 0.0;
    double longitude = double.tryParse(_longitudeController.text) ?? 0.0;

    if (name.isNotEmpty) {
      await groomingPlaces.add({
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Grooming Place Added")));
      _nameController.clear();
      _latitudeController.clear();
      _longitudeController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Grooming Place")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _latitudeController,
              decoration: InputDecoration(labelText: "Latitude"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _longitudeController,
              decoration: InputDecoration(labelText: "Longitude"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addGroomingPlace,
              child: Text("Add Place"),
            ),
          ],
        ),
      ),
    );
  }
}