import 'package:flutter/material.dart';
import 'package:pet_plus_new/model/hospital.dart';
import 'package:pet_plus_new/services/firebase_services.dart';

class HospitalProvider extends ChangeNotifier {
  List<Hospital> _hospitals = [];
  final FirebaseService firebaseService = FirebaseService();

  List<Hospital> get hospitals => _hospitals;

  Future<void> getHospitalDetails() async {
    try {
      final querySnapshot = await firebaseService.getDocuments('Hospitals');
      _hospitals =
          querySnapshot.docs.map((doc) => Hospital.fromMap(doc)).toList();

      // Print hospital details
      print('Fetched ${_hospitals.length} hospitals:');
      for (var hospital in _hospitals) {
        print('Hospital: ${hospital.toMap()}');
      }

      notifyListeners();
    } catch (e) {
      print('Error fetching hospitals: $e');
      throw Exception('Failed to fetch hospitals: $e');
    }
  }
}
