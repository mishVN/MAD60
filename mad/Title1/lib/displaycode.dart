import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroomingPlacesList extends StatelessWidget {
  final CollectionReference groomingPlaces = FirebaseFirestore.instance.collection('grooming_places');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grooming Places")),
      body: StreamBuilder(
        stream: groomingPlaces.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['name']),
                subtitle: Text("Lat: ${doc['latitude']}, Lng: ${doc['longitude']}"),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}