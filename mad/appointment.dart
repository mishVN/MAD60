import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String selectedHospital;
  final String selectedDoctor;
  final String selectedCategory;
  final Timestamp selectedDate;
  final String selectedTime;

  Appointment({
    required this.selectedHospital,
    required this.selectedDoctor,
    required this.selectedCategory,
    required this.selectedDate,
    required this.selectedTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'selectedHospital': selectedHospital,
      'selectedDoctor': selectedDoctor,
      'selectedCategory': selectedCategory,
      'selectedDate': selectedDate,
      'selectedTime': selectedTime,
    };
  }

  factory Appointment.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Appointment(
      selectedHospital: data['selectedHospital'] ?? '',
      selectedDoctor: data['selectedDoctor'] ?? '',
      selectedCategory: data['selectedCategory'] ?? '',
      selectedDate: data['selectedDate'] ?? Timestamp.now(),
      selectedTime: data['selectedTime'] ?? '',
    );
  }
}
