import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirmed;

  const ConfirmationDialog({super.key, required this.onConfirmed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(
        "Booking Confirmed!",
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w500,
          color: const Color.fromARGB(255, 60, 63, 66),
        ),
      ),
      content: SizedBox(
        width: double.infinity,
        height: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your appointment with Dr. Sunil Perera at Asiri Hospital, Kandy, has been successfully booked for 10:30 AM on January 12, 2025.",
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 60, 63, 66),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "We look forward to seeing you!",
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 60, 63, 66),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 20, 32, 166),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              minimumSize: const Size(double.infinity, 55),
            ),
            onPressed: () {
              Navigator.pop(context);
              onConfirmed();
            },
            child: Text(
              "DONE",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
