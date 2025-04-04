import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  final String name;
  final String age;
  final String nic;
  final String contactNumber;
  final Timestamp dob;
  final String profilePicURL;
  final String position;

  Doctor({
    required this.name,
    required this.age,
    required this.nic,
    required this.contactNumber,
    required this.dob,
    required this.profilePicURL,
    required this.position,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'nic': nic,
      'contactNumber': contactNumber,
      'dob': dob,
      'profilePicURL': profilePicURL,
      'position': position,
    };
  }

  factory Doctor.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Doctor(
      name: data['name'] ?? '',
      age: data['age'] ?? '',
      nic: data['nic'] ?? '',
      contactNumber: data['contactNumber'] ?? '',
      dob: data['dob'] ?? Timestamp.now(),
      profilePicURL: data['profilePicURL'] ?? '',
      position: data['position'] ?? '',
    );
  }
}
