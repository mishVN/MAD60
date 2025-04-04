import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_plus_new/model/patient.dart';
import 'package:pet_plus_new/services/firebase_services.dart';

// final _firebase = FirebaseAuth.instance;

class PatientProvider extends ChangeNotifier {
  Patient? patient;
  DocumentSnapshot? featchedDriver;
  bool isLoading = false;
  bool isAnyError = false;
  bool emptyAssignedAmbulance = false;
  String? error;
  final FirebaseService _firebaseService = FirebaseService();

  Future<void> getUserInfo() async {
    try {
      isAnyError = false;
      isLoading = true;
      notifyListeners();

      String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;
      print("currentUserUid: $currentUserUid");

      QuerySnapshot querySnapshot = await _firebaseService
          .getDocumentsWithField(
            collection: "Users",
            fieldName: "user-uid",
            fieldValue: currentUserUid,
          );
      if (querySnapshot.docs.isNotEmpty) {
        featchedDriver = querySnapshot.docs.first;
      }
      patient = Patient.fromMap(featchedDriver!);

      if (patient != null) {
        print(".........................................");
        print(patient!.name);
        print(patient!.email);
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      isAnyError = true;
      error = e.toString();
      print('Error fetching user: $e');
      notifyListeners();
    }
  }

  void toggleIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setPatient(Patient patient) {
    this.patient = patient;
    notifyListeners();
  }
}
