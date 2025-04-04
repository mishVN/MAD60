import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_plus_new/model/appointment.dart';
import 'package:pet_plus_new/model/doctor.dart';
import 'package:pet_plus_new/model/hospital.dart';
import 'package:pet_plus_new/services/firebase_services.dart';

class AppoinmentProvider extends ChangeNotifier {
  Hospital? _selectedHospital;
  Doctor? _selectedDoctor;
  String? _selectedCategory;
  DateTime? _selectedDate;
  String? _selectedTime;

  final FirebaseService firebaseService = FirebaseService();

  Hospital? get selectedHospital => _selectedHospital;
  Doctor? get selectedDoctor => _selectedDoctor;
  String? get selectedCategory => _selectedCategory;
  DateTime? get selectedDate => _selectedDate;
  String? get selectedTime => _selectedTime;

  void setSelectedHospital(Hospital hospital) {
    _selectedHospital = hospital;
    notifyListeners();
  }

  void setSelectedDoctor(Doctor doctor) {
    _selectedDoctor = doctor;
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setSelectedTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  String _generateAppointmentId() {
    if (_selectedHospital == null ||
        _selectedDoctor == null ||
        _selectedDate == null ||
        _selectedTime == null) {
      throw Exception('All appointment details must be set to generate ID');
    }

    // Format date as YYYYMMDD
    String dateStr =
        "${_selectedDate!.year}${_selectedDate!.month.toString().padLeft(2, '0')}${_selectedDate!.day.toString().padLeft(2, '0')}";

    // Remove spaces and special characters from hospital and doctor names
    String hospitalName = _selectedHospital!.name.replaceAll(
      RegExp(r'[^\w]'),
      '',
    );
    String doctorName = _selectedDoctor!.name.replaceAll(RegExp(r'[^\w]'), '');

    // Remove : and spaces from time
    String timeStr = _selectedTime!.replaceAll(RegExp(r'[^\w]'), '');

    // Combine all parts to create unique ID
    return "${hospitalName}_${doctorName}_${dateStr}_$timeStr".toLowerCase();
  }

  Future<void> makeAppointment() async {
    String appointmentId = _generateAppointmentId();

    Appointment appointment = Appointment(
      selectedHospital: _selectedHospital!.name,
      selectedDoctor: _selectedDoctor!.name,
      selectedCategory: _selectedCategory!,
      selectedDate: Timestamp.fromDate(_selectedDate!),
      selectedTime: _selectedTime!,
    );

    print("Appointment ID: $appointmentId");

    try {
      //await firebaseService.uploadDocument('appointments', appointment.toMap(), appointmentId);
    } catch (e) {
      throw Exception('Failed to make appointment: $e');
    }
  }
}
