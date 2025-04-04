import 'package:flutter/material.dart';
import 'package:pet_plus_new/widgets/training/search.dart';

class TrainingSearch extends StatefulWidget {
  final String initialQuery;
  final Map<String, dynamic> initialFilters;
  final Function(String query, Map<String, dynamic> filters) onSearch;

  const TrainingSearch({
    super.key,
    required this.initialQuery,
    required this.initialFilters,
    required this.onSearch,
  });

  @override
  State<TrainingSearch> createState() => _TrainingSearchState();
}

class _TrainingSearchState extends State<TrainingSearch> {
  late TextEditingController _searchController;
  late Map<String, dynamic> _filters;

  final List<String> _trainingTypes = [
    'All',
    'Obedience',
    'Agility',
    'Behavior Correction',
    'Service Dog Training',
    'Puppy Training',
    'Protection Training',
  ];

  final List<String> _breedSpecializations = [
    'All breeds',
    'German Shepherd',
    'Belgian Malinois',
    'Doberman',
    'Labrador Retriever',
    'Golden Retriever',
    'Border Collie',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
    _filters = Map<String, dynamic>.from(widget.initialFilters);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search training facilities...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) {
              // Real-time search not implemented for now
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Filters',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SearchFilterWidget(
            title: 'Training Type',
            options: _trainingTypes,
            selectedOption: _filters['trainingType'] ?? 'All',
            onChanged: (value) {
              setState(() {
                if (value == 'All') {
                  _filters.remove('trainingType');
                } else {
                  _filters['trainingType'] = value;
                }
              });
            },
          ),
          const SizedBox(height: 8),
          SearchFilterWidget(
            title: 'Breed Specialization',
            options: _breedSpecializations,
            selectedOption: _filters['breedSpecialization'] ?? 'All breeds',
            onChanged: (value) {
              setState(() {
                if (value == 'All breeds') {
                  _filters.remove('breedSpecialization');
                } else {
                  _filters['breedSpecialization'] = value;
                }
              });
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onSearch(_searchController.text, _filters);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }
}
