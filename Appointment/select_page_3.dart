import 'package:flutter/material.dart';
import 'package:pet_plus_new/provider/appoinment_provider.dart';
import 'package:pet_plus_new/widgets/text_holder.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectPage3 extends StatefulWidget {
  const SelectPage3({
    super.key,
    required this.onSelectedBack,
    required this.onSelectedNext,
  });

  final void Function() onSelectedBack;
  final void Function() onSelectedNext;
  @override
  State<SelectPage3> createState() => _SelectPage3State();
}

class _SelectPage3State extends State<SelectPage3> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select a Date",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 60, 63, 66),
                ),
              ),
              const SizedBox(height: 16),
              TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 365)),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: const BoxDecoration(
                    color: Color.fromARGB(255, 20, 32, 166),
                    shape: BoxShape.rectangle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: const Color.fromARGB(
                      255,
                      131,
                      180,
                      255,
                    ).withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              TextHolder(
                title: "Selected date",
                value:
                    "${_selectedDay.day}/${_selectedDay.month}/${_selectedDay.year}",
                width: double.infinity,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenSize.width * 0.42,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: widget.onSelectedBack,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(
                          width: 1.5,
                          color: Color.fromARGB(255, 60, 63, 66),
                        ),
                      ),
                    ),
                    child: Text(
                      "Back",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 60, 63, 66),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.42,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AppoinmentProvider>().setSelectedDate(
                        _selectedDay,
                      );
                      widget.onSelectedNext();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: Color.fromARGB(255, 20, 32, 166),
                    ),
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
