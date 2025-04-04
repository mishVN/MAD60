class Trainer {
  final String id;
  final String name;
  final String bio;
  final String imageUrl;
  final List<String> specializations;
  final List<String> certifications;
  final int yearsOfExperience;
  final double rating;

  Trainer({
    required this.id,
    required this.name,
    required this.bio,
    required this.imageUrl,
    required this.specializations,
    required this.certifications,
    required this.yearsOfExperience,
    required this.rating,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      id: json['id'],
      name: json['name'],
      bio: json['bio'],
      imageUrl: json['imageUrl'],
      specializations: List<String>.from(json['specializations']),
      certifications: List<String>.from(json['certifications']),
      yearsOfExperience: json['yearsOfExperience'],
      rating: json['rating'].toDouble(),
    );
  }
}
