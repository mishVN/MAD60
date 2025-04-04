class BoardingReview {
  final String id;
  final String userId;
  final String userName;
  final String? userPhotoUrl;
  final double rating;
  final String comment;
  final DateTime date;
  final String facilityId;
  final List<String>? photoUrls;
  final String? petType;
  final String? stayDuration;

  const BoardingReview({
    required this.id,
    required this.userId,
    required this.userName,
    this.userPhotoUrl,
    required this.rating,
    required this.comment,
    required this.date,
    required this.facilityId,
    this.photoUrls,
    this.petType,
    this.stayDuration,
  });
}
