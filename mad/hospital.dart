import 'package:cloud_firestore/cloud_firestore.dart';

class Hospital {
  final String name;
  final String imageURL;
  final String email;
  final String address;
  final String contactNumber;

  Hospital({
    required this.name,
    required this.imageURL,
    required this.email,
    required this.address,
    required this.contactNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageURL': imageURL,
      'email': email,
      'address': address,
      'contactNumber': contactNumber,
    };
  }

  factory Hospital.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Hospital(
      name: data['name'] ?? '',
      imageURL: data['imageURL'] ?? '',
      email: data['email'] ?? '',
      address: data['address'] ?? '',
      contactNumber: data['contactNumber'] ?? '',
    );
  }
}
