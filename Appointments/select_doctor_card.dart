// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pet_plus_new/model/doctor.dart';
import 'package:pet_plus_new/provider/appoinment_provider.dart';
import 'package:provider/provider.dart';

class SelectDoctorCard extends StatefulWidget {
  const SelectDoctorCard({
    super.key,
    required this.doctor,
    this.onSelectionChanged,
  });

  final Doctor doctor;

  final Function(bool)? onSelectionChanged;

  @override
  State<SelectDoctorCard> createState() => _SelectDoctorCardState();
}

class _SelectDoctorCardState extends State<SelectDoctorCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color.fromARGB(255, 60, 63, 66),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromARGB(255, 20, 32, 166),
              ),
              child: const Icon(
                Icons.medical_services_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 230,
                    child: Text(
                      widget.doctor.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 60, 63, 66),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    widget.doctor.position,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 60, 63, 66),
                    ),
                  ),
                  Text(
                    "Experience: 5 years",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 60, 63, 66),
                    ),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: widget.doctor.nic,
              groupValue:
                  context.watch<AppoinmentProvider>().selectedDoctor?.nic ?? "",
              onChanged: (String? value) {
                if (widget.onSelectionChanged != null) {
                  widget.onSelectionChanged!(value == widget.doctor.nic);
                }
              },
              activeColor: Color.fromARGB(255, 20, 32, 166),
            ),
          ],
        ),
      ),
    );
  }
}
