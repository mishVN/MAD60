class GroomingPlace {
  String name;
  double latitude;
  double longitude;

  GroomingPlace({required this.name, required this.latitude, required this.longitude});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}