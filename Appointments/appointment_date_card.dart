import 'package:flutter/material.dart';

class AppointmentDateCard extends StatefulWidget {
  const AppointmentDateCard({super.key});

  @override
  State<AppointmentDateCard> createState() => _AppointmentDateCardState();
}

class _AppointmentDateCardState extends State<AppointmentDateCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 52, 52, 52).withOpacity(0.4),
            offset: const Offset(0, 5),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "20",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Jan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 85,
                        child: Text(
                          "Surgery",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 45),
                      Text(
                        "10:30 AM",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                          color: const Color.fromARGB(255, 108, 108, 108),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(
                          "Dr.Sunil Perera",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 190,
                        child: Text(
                          "Your Doctor",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                            color: const Color.fromARGB(255, 108, 108, 108),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
