class GroomingSalon {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String website;
  final List<String> photos;
  final Map<String, double> services;
  final List<Groomer> groomers;
  final double rating;
  final List<Review> reviews;
  final List<String> petTypes;
  final String location;

  GroomingSalon({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.website,
    required this.photos,
    required this.services,
    required this.groomers,
    required this.rating,
    required this.reviews,
    required this.petTypes,
    required this.location,
  });
}

class Groomer {
  final String id;
  final String name;
  final String specialization;
  final String bio;
  final String image;

  Groomer({
    required this.id,
    required this.name,
    required this.specialization,
    required this.bio,
    required this.image,
  });
}

class Review {
  final String userId;
  final String userName;
  final double rating;
  final String comment;
  final DateTime date;

  Review({
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });
}