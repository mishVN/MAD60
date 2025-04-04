class PetReminder {
  final String id;
  final String petId;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isRecurring;
  final RecurringType? recurringType;
  final ReminderType type;
  final bool isCompleted;

  PetReminder({
    required this.id,
    required this.petId,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isRecurring = false,
    this.recurringType,
    required this.type,
    this.isCompleted = false,
  });
}

enum RecurringType {
  daily,
  weekly,
  monthly,
  yearly
}

enum ReminderType {
  vaccination,
  grooming,
  vetCheckup,
  medication,
  birthday,
  fleaTreatment,
  other
}