class TrainingFacility {
  final String id;
  final String name;
  final String description;
  final String address;
  final String phoneNumber;
  final String email;
  final String website;
  final Map<String, String> socialMedia;
  final List<String> trainingTypes;
  final List<String> breedSpecializations;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final List<String> trainerIds;
  final List<String> classIds;
  final double latitude;
  final double longitude;

  TrainingFacility({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.website,
    required this.socialMedia,
    required this.trainingTypes,
    required this.breedSpecializations,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.trainerIds,
    required this.classIds,
    required this.latitude,
    required this.longitude,
  });

  factory TrainingFacility.fromJson(Map<String, dynamic> json) {
    return TrainingFacility(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      website: json['website'],
      socialMedia: Map<String, String>.from(json['socialMedia']),
      trainingTypes: List<String>.from(json['trainingTypes']),
      breedSpecializations: List<String>.from(json['breedSpecializations']),
      imageUrl: json['imageUrl'],
      rating: json['rating'].toDouble(),
      reviewCount: json['reviewCount'],
      trainerIds: List<String>.from(json['trainerIds']),
      classIds: List<String>.from(json['classIds']),
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }
}
