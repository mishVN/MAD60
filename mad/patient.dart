import 'package:cloud_firestore/cloud_firestore.dart';

class Patient {
  final String imageUrl;
  final String name;
  final String createdAt;
  final String currentDay;
  final String contactNumber;
  final String email;
  final String userUid;

  Patient({
    required this.imageUrl,
    required this.name,
    required this.createdAt,
    required this.currentDay,
    required this.contactNumber,
    required this.email,
    required this.userUid,
  });

  Map<String, dynamic> toMap() {
    return {
      'image-url': imageUrl,
      'name': name,
      'created-at': createdAt,
      'currentDay': currentDay,
      'contact-number': contactNumber,
      'email': email,
      'user-uid': userUid,
    };
  }

  factory Patient.fromMap(DocumentSnapshot doc) {
    if (!doc.exists) {
      throw StateError('Document does not exist');
    }

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Patient(
      imageUrl: data['image-url'] ?? '',
      name: data['name'] ?? '',
      createdAt: data['created-at'] ?? '',
      currentDay: data['currentDay'] ?? '',
      contactNumber: data['contact-number'] ?? '',
      email: data['email'] ?? '',
      userUid: data['user-uid'] ?? '',
    );
  }
}
