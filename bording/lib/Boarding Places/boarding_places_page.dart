import 'package:flutter/material.dart';
import 'package:pet_plus_new/model/boarding_fac.dart';
import 'package:pet_plus_new/screens/Boarding%20Places/boarding_detail.dart';
import 'package:pet_plus_new/screens/Boarding%20Places/boarding_search.dart';
import 'package:pet_plus_new/screens/Boarding%20Places/boarding_service.dart';
import 'package:pet_plus_new/widgets/boarding/b_facility_card.dart';

class BoardingPlacesPage extends StatefulWidget {
  const BoardingPlacesPage({super.key});

  @override
  State<BoardingPlacesPage> createState() => _BoardingPlacesPageState();
}

class _BoardingPlacesPageState extends State<BoardingPlacesPage> {
  final BoardingService _boardingService = BoardingService();
  List<BoardingFacility> _facilities = [];
  bool _isLoading = true;
  String _searchQuery = '';
  Map<String, dynamic> _filters = {};

  @override
  void initState() {
    super.initState();
    _loadFacilities();
  }

  Future<void> _loadFacilities() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final facilities = await _boardingService.getBoardingFacilities(
        query: _searchQuery,
        filters: _filters,
      );
      setState(() {
        _facilities = facilities;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading facilities: $e')));
    }
  }

  void _onSearch(String query, Map<String, dynamic> filters) {
    setState(() {
      _searchQuery = query;
      _filters = filters;
    });
    _loadFacilities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Boarding Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder:
                    (context) => BoardingSearch(
                      initialQuery: _searchQuery,
                      initialFilters: _filters,
                      onSearch: _onSearch,
                    ),
              );
            },
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _facilities.isEmpty
              ? const Center(child: Text('No boarding facilities found'))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _facilities.length,
                itemBuilder: (context, index) {
                  final facility = _facilities[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: BoardingFacilityCard(
                      facility: facility,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    BoardingDetailPage(facilityId: facility.id),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
    );
  }
}
