import 'package:flutter/material.dart';
import 'boarding_service.dart';
import 'feedback_model.dart';

class AddFeedbackScreen extends StatefulWidget {
  final String boardingPlaceId; // To link feedback to specific boarding place

  AddFeedbackScreen({required this.boardingPlaceId});

  @override
  _AddFeedbackScreenState createState() => _AddFeedbackScreenState();
}

class _AddFeedbackScreenState extends State<AddFeedbackScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();

  final BoardingService boardingService = BoardingService();

  Future<void> _submitFeedback() async {
    String userName = _userNameController.text;
    String comment = _commentController.text;
    int rating = int.tryParse(_ratingController.text) ?? 0;

    if (userName.isNotEmpty && comment.isNotEmpty && rating > 0) {
      Feedback feedback = Feedback(userName: userName, comment: comment, rating: rating);
      await boardingService.addFeedback(feedback);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Feedback Submitted")));
      _userNameController.clear();
      _commentController.clear();
      _ratingController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all fields")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Feedback")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _userNameController,
              decoration: InputDecoration(labelText: "Your Name"),
            ),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(labelText: "Comment"),
              maxLines: 4,
            ),
            TextField(
              controller: _ratingController,
              decoration: InputDecoration(labelText: "Rating (1-5)"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitFeedback,
              child: Text("Submit Feedback"),
            ),
          ],
        ),
      ),
    );
  }
}