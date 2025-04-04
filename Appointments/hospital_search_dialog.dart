import 'package:flutter/material.dart';
import 'package:pet_plus_new/model/hospital.dart';
import 'package:pet_plus_new/provider/hospital_provider.dart';
import 'package:provider/provider.dart';

class HospitalSearchDialog extends StatefulWidget {
  final Function(Hospital) onHospitalSelected;

  const HospitalSearchDialog({super.key, required this.onHospitalSelected});

  @override
  State<HospitalSearchDialog> createState() => _HospitalSearchDialogState();
}

class _HospitalSearchDialogState extends State<HospitalSearchDialog> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Column(
        children: [
          Text(
            'Select Veterinary Hospital',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search vet...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value.toLowerCase();
              });
            },
          ),
          const SizedBox(height: 16),
          Text(
            "Pick a vet from the list below",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Consumer<HospitalProvider>(
          builder: (context, hospitalProvider, child) {
            final hospitals =
                hospitalProvider.hospitals
                    .where(
                      (hospital) =>
                          hospital.name.toLowerCase().contains(searchQuery),
                    )
                    .toList();

            return ListView.builder(
              shrinkWrap: true,
              itemCount: hospitals.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: 1,
                      color: const Color.fromARGB(96, 158, 158, 158),
                    ),
                    ListTile(
                      title: Text(hospitals[index].name, style: TextStyle()),
                      onTap: () {
                        widget.onHospitalSelected(hospitals[index]);
                        Navigator.of(context).pop();
                      },
                    ),
                    Container(
                      height: 1,
                      color: const Color.fromARGB(96, 158, 158, 158),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
