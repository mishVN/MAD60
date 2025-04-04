class TrainingClass {
  final String id;
  final String name;
  final String description;
  final String trainingType;
  final String trainerId;
  final double price;
  final int sessionCount;
  final int sessionLengthMinutes;
  final Map<String, List<String>> schedule; // day -> [time slots]
  final int maxParticipants;
  final List<String> prerequisites;

  TrainingClass({
    required this.id,
    required this.name,
    required this.description,
    required this.trainingType,
    required this.trainerId,
    required this.price,
    required this.sessionCount,
    required this.sessionLengthMinutes,
    required this.schedule,
    required this.maxParticipants,
    required this.prerequisites,
  });

  factory TrainingClass.fromJson(Map<String, dynamic> json) {
    return TrainingClass(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      trainingType: json['trainingType'],
      trainerId: json['trainerId'],
      price: json['price'].toDouble(),
      sessionCount: json['sessionCount'],
      sessionLengthMinutes: json['sessionLengthMinutes'],
      schedule: Map<String, List<String>>.from(
        json['schedule'].map(
          (key, value) => MapEntry(key, List<String>.from(value)),
        ),
      ),
      maxParticipants: json['maxParticipants'],
      prerequisites: List<String>.from(json['prerequisites']),
    );
  }
}
