class BoardingFacility {
  final String id;
  final String name;
  final String description;
  final String address;
  final double latitude;
  final double longitude;
  final String phoneNumber;
  final String email;
  final String website;
  final Map<String, String> socialMedia;
  final List<String> petTypes;
  final List<String> services;
  final List<String> amenities;
  final Map<String, dynamic> pricing;
  final List<String> imageUrls;
  final double rating;
  final int reviewCount;
  final bool hasAvailability;
  final List<String> businessHours;

  const BoardingFacility({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber,
    required this.email,
    required this.website,
    required this.socialMedia,
    required this.petTypes,
    required this.services,
    required this.amenities,
    required this.pricing,
    required this.imageUrls,
    required this.rating,
    required this.reviewCount,
    required this.hasAvailability,
    required this.businessHours,
  });
}
