// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pet_plus_new/screens/Appointment/select_page_1.dart';
import 'package:pet_plus_new/screens/Appointment/select_page_2.dart';
import 'package:pet_plus_new/screens/Appointment/select_page_3.dart';
import 'package:pet_plus_new/screens/Appointment/select_page_4.dart';
import 'package:pet_plus_new/screens/Appointment/z_confirm_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BookAppointmentPage extends StatefulWidget {
  const BookAppointmentPage({super.key});

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'Book Appointment',
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(255, 60, 63, 66),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: SmoothPageIndicator(
                controller: _controller,
                count: 5,
                effect: ExpandingDotsEffect(
                  dotWidth: 12,
                  dotHeight: 6,
                  activeDotColor: Color.fromARGB(255, 20, 32, 166),
                  dotColor: Color.fromARGB(255, 20, 32, 166).withOpacity(0.3),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _controller,
                children: [
                  SelectPage1(
                    onSelectednext: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                  SelectPage2(
                    onSelectedBack: () {
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                    onSelectedNext: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                  SelectPage3(
                    onSelectedBack: () {
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                    onSelectedNext: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                  SelectPage4(
                    onSelectedBack: () {
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                    onSelectedNext: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                  ConfirmPage(
                    onSelectedBack: () {
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                    onSelectedNext: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
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
