import 'package:flutter/material.dart';
import 'package:pet_plus_new/provider/appoinment_provider.dart';
import 'package:pet_plus_new/widgets/Appointments/hospital_search_dialog.dart';
import 'package:pet_plus_new/widgets/text_holder.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

// ignore: must_be_immutable
class SelectPage1 extends StatefulWidget {
  const SelectPage1({super.key, required this.onSelectednext});

  final void Function() onSelectednext;
  @override
  State<SelectPage1> createState() => _SelectPage1State();
}

class _SelectPage1State extends State<SelectPage1> {
  void submit() {}

  void _showHospitalSearchDialog() {
    showDialog(
      context: context,
      builder:
          (context) => HospitalSearchDialog(
            onHospitalSelected: (hospital) {
              context.read<AppoinmentProvider>().setSelectedHospital(hospital);
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
                      "Select a Veterinary Hospital",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 60, 63, 66),
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextHolder(
                      title: "Search for a veterinary hospital",
                      value:
                          context
                              .watch<AppoinmentProvider>()
                              .selectedHospital
                              ?.name ??
                          'Select a veterinary hospital',
                      width: double.infinity,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: SizedBox(
                        width: screenSize.width,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _showHospitalSearchDialog,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            backgroundColor: Color.fromARGB(255, 20, 32, 166),
                          ),
                          child: Text(
                            context
                                        .watch<AppoinmentProvider>()
                                        .selectedHospital
                                        ?.name ==
                                    null
                                ? 'Select Veterinary Hospital'
                                : "Change Veterinary Hospital",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      "Service Category",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 60, 63, 66),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButtonFormField<String>(
                        value:
                            context
                                .watch<AppoinmentProvider>()
                                .selectedCategory,
                        dropdownColor: const Color.fromRGBO(214, 226, 246, 1),
                        borderRadius: BorderRadius.circular(5),
                        menuMaxHeight: 250,
                        isExpanded: true,
                        hint: Text(
                          'Select a category',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'parvo',
                            child: _CategoryItem(text: 'Parvovirus'),
                          ),
                          DropdownMenuItem(
                            value: 'distemper',
                            child: _CategoryItem(text: 'Canine Distemper'),
                          ),
                          DropdownMenuItem(
                            value: 'rabies',
                            child: _CategoryItem(text: 'Rabies'),
                          ),
                          DropdownMenuItem(
                            value: 'feline_leukemia',
                            child: _CategoryItem(
                              text: 'Feline Leukemia Virus (FeLV)',
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'feline_immunodeficiency',
                            child: _CategoryItem(
                              text: 'Feline Immunodeficiency Virus (FIV)',
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'heartworm',
                            child: _CategoryItem(text: 'Heartworm Disease'),
                          ),
                          DropdownMenuItem(
                            value: 'lyme',
                            child: _CategoryItem(text: 'Lyme Disease'),
                          ),
                          DropdownMenuItem(
                            value: 'kennel_cough',
                            child: _CategoryItem(text: 'Kennel Cough'),
                          ),
                          DropdownMenuItem(
                            value: 'ringworm',
                            child: _CategoryItem(text: 'Ringworm'),
                          ),
                          DropdownMenuItem(
                            value: 'panleukopenia',
                            child: _CategoryItem(text: 'Feline Panleukopenia'),
                          ),
                        ],

                        onChanged: (value) {
                          if (value != null) {
                            context
                                .read<AppoinmentProvider>()
                                .setSelectedCategory(value);
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 20, 32, 166),
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 20, 32, 166),
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 20, 32, 166),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
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
                    onPressed: () => Navigator.pop(context),
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
                      "Cancel",
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
                      if (context.read<AppoinmentProvider>().selectedCategory !=
                              null &&
                          context.read<AppoinmentProvider>().selectedHospital !=
                              null) {
                        widget.onSelectednext();
                      } else {
                        toastification.show(
                          style: ToastificationStyle.flatColored,
                          type: ToastificationType.custom(
                            "Error",
                            Colors.red,
                            Icons.error,
                          ),
                          context: context,
                          title: Text('Please select a hospital and category'),
                          autoCloseDuration: const Duration(seconds: 5),
                          foregroundColor: Colors.black,
                          description: Text(
                            'Select a hospital and category to continue the process',
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
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final String text;
  const _CategoryItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: const Color.fromARGB(255, 60, 63, 66),
        ),
      ),
    );
  }
}
