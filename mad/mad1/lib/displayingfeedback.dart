import 'package:flutter/material.dart';
import 'boarding_service.dart';
import 'feedback_model.dart';

class ViewFeedbackScreen extends StatelessWidget {
  final BoardingService boardingService = BoardingService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Feedback")),
      body: StreamBuilder<List<Feedback>>(
        stream: boardingService.getFeedbacks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var feedbackList = snapshot.data!;
          return ListView.builder(
            itemCount: feedbackList.length,
            itemBuilder: (context, index) {
              var feedback = feedbackList[index];
              return ListTile(
                title: Text(feedback.userName),
                subtitle: Text(feedback.comment),
                trailing: Text(feedback.rating.toString()),
              );
            },
          );
        },
      ),
    );
  }
}