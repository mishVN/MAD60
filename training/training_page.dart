import 'package:flutter/material.dart';
import 'package:pet_plus_new/model/training_fac.dart';
import 'package:pet_plus_new/screens/training/services.dart';
import 'package:pet_plus_new/screens/training/training_detail.dart';
import 'package:pet_plus_new/screens/training/training_search.dart';
import 'package:pet_plus_new/widgets/training/training_fac_card.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  final TrainingService _trainingService = TrainingService();
  List<TrainingFacility> _facilities = [];
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
      final facilities = await _trainingService.getTrainingFacilities(
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
        title: const Text('Pet Training Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder:
                    (context) => TrainingSearch(
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
              ? const Center(child: Text('No training facilities found'))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _facilities.length,
                itemBuilder: (context, index) {
                  final facility = _facilities[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: TrainingFacilityCard(
                      facility: facility,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    TrainingDetailPage(facilityId: facility.id),
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
