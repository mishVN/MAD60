import 'package:flutter/material.dart';
import 'package:pet_plus_new/provider/appoinment_provider.dart';
import 'package:pet_plus_new/provider/patient_provider.dart';
import 'package:pet_plus_new/screens/Appointment/zz_booking_confirmed_alert.dart';
import 'package:pet_plus_new/widgets/text_holder.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({
    super.key,
    required this.onSelectedBack,
    required this.onSelectedNext,
  });

  final void Function() onSelectedBack;
  final void Function() onSelectedNext;

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  void showConfirmationDialog(BuildContext context, VoidCallback onConfirmed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(onConfirmed: onConfirmed);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final appoinmentProvider = context.watch<AppoinmentProvider>();
    final patientProvider = context.watch<PatientProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  left: 25,
                  right: 25,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 80,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Confirm Your Visit",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 60, 63, 66),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About Your Visit",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 60, 63, 66),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextHolder(
                          title: "Patient Name",
                          value: patientProvider.patient!.name,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 8),
                        TextHolder(
                          title: "When",
                          value:
                              "${DateFormat('yyyy-MM-dd').format(appoinmentProvider.selectedDate!)} at ${appoinmentProvider.selectedTime!}",
                          width: double.infinity,
                        ),
                        const SizedBox(height: 8),
                        TextHolder(
                          title: "Where",
                          value: appoinmentProvider.selectedHospital!.name,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 8),
                        TextHolder(
                          title: "Doctor",
                          value:
                              "Dr. ${appoinmentProvider.selectedDoctor!.name}",
                          width: double.infinity,
                        ),
                        const SizedBox(height: 8),
                        TextHolder(
                          title: "Service",
                          value: appoinmentProvider.selectedCategory!,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 8),
                        TextHolder(
                          title: "Price",
                          value: "Rs.2400 +tax",
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
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
                    onPressed: () async {
                      await context
                          .read<AppoinmentProvider>()
                          .makeAppointment();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmationDialog(
                            onConfirmed: () {
                              Navigator.pop(context);
                              widget.onSelectedNext();
                            },
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: Color.fromARGB(255, 20, 32, 166),
                    ),
                    child: Text(
                      "Confirm",
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
        ],
      ),
    );
  }
}
