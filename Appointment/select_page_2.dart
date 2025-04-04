import 'package:flutter/material.dart';
import 'package:pet_plus_new/provider/appoinment_provider.dart';
import 'package:pet_plus_new/provider/doctor_provider.dart';
import 'package:pet_plus_new/widgets/Appointments/select_doctor_card.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class SelectPage2 extends StatefulWidget {
  const SelectPage2({
    super.key,
    required this.onSelectedBack,
    required this.onSelectedNext,
  });

  final void Function() onSelectedBack;
  final void Function() onSelectedNext;
  @override
  State<SelectPage2> createState() => _SelectPage2State();
}

class _SelectPage2State extends State<SelectPage2> {
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
                "Select a Doctor",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 60, 63, 66),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      final doctors = context.watch<DoctorProvider>().doctors;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SelectDoctorCard(
                          doctor: doctors[index],
                          onSelectionChanged: (bool selected) {
                            if (selected) {
                              context
                                  .read<AppoinmentProvider>()
                                  .setSelectedDoctor(doctors[index]);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
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
                      if (context.read<AppoinmentProvider>().selectedDoctor !=
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
                          title: Text('Please select your doctor'),
                          autoCloseDuration: const Duration(seconds: 5),
                          foregroundColor: Colors.black,
                          description: Text(
                            'Select a doctor that you want to make an appointment with.',
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
    );
  }
}
