class Feedback {
  String userName;
  String comment;
  int rating;

  Feedback({required this.userName, required this.comment, required this.rating});

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'comment': comment,
      'rating': rating,
    };
  }

  Feedback.fromMap(Map<String, dynamic> map)
      : userName = map['userName'],
        comment = map['comment'],
        rating = map['rating'];
}