import 'package:flutter/material.dart';
import 'package:pet_plus_new/provider/appoinment_provider.dart';
import 'package:pet_plus_new/widgets/text_holder.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class SelectPage4 extends StatefulWidget {
  const SelectPage4({
    super.key,
    required this.onSelectedBack,
    required this.onSelectedNext,
  });

  final void Function() onSelectedBack;
  final void Function() onSelectedNext;
  @override
  State<SelectPage4> createState() => _SelectPage4State();
}

class _SelectPage4State extends State<SelectPage4> {
  final List<String> timeSlots = [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
    '03:30 PM',
    '04:00 PM',
    '04:30 PM',
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select a Time",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 60, 63, 66),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Morning",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 60, 63, 66),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  final time = timeSlots[index];
                  final isSelected =
                      time == context.watch<AppoinmentProvider>().selectedTime;

                  return GestureDetector(
                    onTap: () {
                      context.read<AppoinmentProvider>().setSelectedTime(time);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? Color.fromARGB(255, 20, 32, 166)
                                : Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color:
                              isSelected
                                  ? Color.fromARGB(255, 20, 32, 166)
                                  : Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          time,
                          style: TextStyle(
                            color:
                                isSelected
                                    ? Colors.white
                                    : const Color.fromARGB(255, 60, 63, 66),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Afternoon",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 60, 63, 66),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  final time = timeSlots[index + 6];
                  final isSelected =
                      time == context.watch<AppoinmentProvider>().selectedTime;

                  return GestureDetector(
                    onTap: () {
                      context.read<AppoinmentProvider>().setSelectedTime(time);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? Color.fromARGB(255, 20, 32, 166)
                                : Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color:
                              isSelected
                                  ? Color.fromARGB(255, 20, 32, 166)
                                  : Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          time,
                          style: TextStyle(
                            color:
                                isSelected
                                    ? Colors.white
                                    : const Color.fromARGB(255, 60, 63, 66),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 60),
              TextHolder(
                title: "Selected time",
                value:
                    context.watch<AppoinmentProvider>().selectedTime ??
                    "Select a time",
                width: double.infinity,
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Container(
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
                        if (context.read<AppoinmentProvider>().selectedTime !=
                            null) {
                          widget.onSelectedNext();
                        } else {
                          toastification.show(
                            style: ToastificationStyle.flatColored,
                            type: ToastificationType.custom(
                              "Error",
                              Colors.red,
                              Icons.error,
                            ),
                            context: context,
                            title: Text('Please select a time slot'),
                            autoCloseDuration: const Duration(seconds: 5),
                            foregroundColor: Colors.black,
                            description: Text(
                              'Select a time slot to meet your doctor',
                            ),
                            showProgressBar: false,
                          );
                        }
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
      ),
    );
  }
}
