class Pet {
  final String id;
  final String name;
  final String breed;
  final int age;
  final String gender;
  final String photoUrl;
  final List<String> dietaryNeeds;
  final List<String> allergies;
  final List<MedicalCondition> medicalConditions;
  final List<Vaccination> vaccinations;
  final List<String> personalityTraits;
  final List<BehaviorNote> behaviorNotes;

  Pet({
    required this.id,
    required this.name,
    required this.breed,
    required this.age,
    required this.gender,
    required this.photoUrl,
    this.dietaryNeeds = const [],
    this.allergies = const [],
    this.medicalConditions = const [],
    this.vaccinations = const [],
    this.personalityTraits = const [],
    this.behaviorNotes = const [],
  });
}

class MedicalCondition {
  final String condition;
  final String diagnosis;
  final DateTime diagnosisDate;
  final String treatment;

  MedicalCondition({
    required this.condition,
    required this.diagnosis,
    required this.diagnosisDate,
    required this.treatment,
  });
}

class Vaccination {
  final String name;
  final DateTime date;
  final DateTime nextDueDate;
  final String veterinarian;

  Vaccination({
    required this.name,
    required this.date,
    required this.nextDueDate,
    required this.veterinarian,
  });
}

class BehaviorNote {
  final String note;
  final DateTime date;

  BehaviorNote({
    required this.note,
    required this.date,
  });
}