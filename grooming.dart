import 'package:flutter/material.dart';
import 'package:pet_plus_new/model/grooming_model.dart';
import 'package:pet_plus_new/screens/Grooming/saloon_details.dart';
import '../../data/grooming_data.dart';

class GroomingScreen extends StatefulWidget {
  @override
  _GroomingScreenState createState() => _GroomingScreenState();
}

class _GroomingScreenState extends State<GroomingScreen> {
  String searchQuery = '';
  String selectedLocation = '';
  String selectedPetType = '';
  String selectedService = '';

  List<GroomingSalon> get filteredSalons {
    return salonsList.where((salon) {
      final matchesSearch = salon.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          salon.address.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesLocation = selectedLocation.isEmpty || salon.location == selectedLocation;
      final matchesPetType = selectedPetType.isEmpty || salon.petTypes.contains(selectedPetType);
      final matchesService = selectedService.isEmpty || salon.services.containsKey(selectedService);
      return matchesSearch && matchesLocation && matchesPetType && matchesService;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Grooming Places'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Color.fromARGB(255, 20, 32, 166),
            child: Column(
              children: [
                _buildSearchBar(),
                _buildFilters(),
              ],
            ),
          ),
          Expanded(
            child: filteredSalons.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('No matching salons found'),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredSalons.length,
                    itemBuilder: (context, index) {
                      return _buildSalonCard(filteredSalons[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search grooming places...',
          hintStyle: TextStyle(color: Colors.white70),
          prefixIcon: Icon(Icons.search, color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white24,
        ),
        style: TextStyle(color: Colors.white),
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip(
              label: 'Location',
              selected: selectedLocation,
              options: ['Downtown', 'Uptown', 'Suburb'],
              onSelected: (value) {
                setState(() {
                  selectedLocation = value;
                });
              },
            ),
            SizedBox(width: 8),
            _buildFilterChip(
              label: 'Pet Type',
              selected: selectedPetType,
              options: ['Dogs', 'Cats', 'Both'],
              onSelected: (value) {
                setState(() {
                  selectedPetType = value;
                });
              },
            ),
            SizedBox(width: 8),
            _buildFilterChip(
              label: 'Service',
              selected: selectedService,
              options: ['Bathing', 'Haircut', 'Nail Trim', 'Full Grooming'],
              onSelected: (value) {
                setState(() {
                  selectedService = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required String selected,
    required List<String> options,
    required Function(String) onSelected,
  }) {
    return PopupMenuButton<String>(
      child: Chip(
        label: Text(
          selected.isEmpty ? label : selected,
          style: TextStyle(color: selected.isEmpty ? Colors.grey[600] : Colors.white),
        ),
        backgroundColor: selected.isEmpty ? Colors.grey[200] : Theme.of(context).primaryColor,
        deleteIcon: selected.isEmpty ? null : Icon(Icons.close, size: 18),
        onDeleted: selected.isEmpty ? null : () => onSelected(''),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: '',
          child: Text('All $label'),
        ),
        ...options.map((option) => PopupMenuItem(
              value: option,
              child: Text(option),
            )),
      ],
      onSelected: onSelected,
    );
  }

  Widget _buildSalonCard(GroomingSalon salon) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              salon.photos[0],
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      salon.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, size: 20, color: Colors.amber),
                        Text(
                          ' ${salon.rating}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        salon.address,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: salon.services.keys
                      .take(3)
                      .map((service) => Chip(
                            label: Text(
                              service,
                              style: TextStyle(fontSize: 12),
                            ),
                            backgroundColor: Colors.grey[200],
                          ))
                      .toList(),
                ),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SalonDetailScreen(salon: salon),
                      ),
                    );
                  },
                  child: Text('View Details'),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor,
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