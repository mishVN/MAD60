import 'package:flutter/material.dart';
import 'package:pet_plus_new/model/doctor.dart';
import 'package:pet_plus_new/services/firebase_services.dart';

class DoctorProvider extends ChangeNotifier {
  final FirebaseService firebaseService = FirebaseService();
  List<Doctor> _doctors = [];

  List<Doctor> get doctors => _doctors;

  Future<void> getDoctors() async {
    try {
      final querySnapshot = await firebaseService.getDocuments('Doctors');
      _doctors = querySnapshot.docs.map((doc) => Doctor.fromMap(doc)).toList();

      // Print hospital details
      print('Fetched ${_doctors.length} doctors:');
      for (var hospital in _doctors) {
        print('Doctor Details: ${hospital.toMap()}');
      }

      notifyListeners();
    } catch (e) {
      print('Error fetching doctor details: $e');
      throw Exception('Failed to fetch doctors details: $e');
    }
  }
}
