import 'package:flutter/material.dart';

class BoardingSearch extends StatefulWidget {
  final String initialQuery;
  final Map<String, dynamic> initialFilters;
  final Function(String, Map<String, dynamic>) onSearch;

  const BoardingSearch({
    super.key,
    this.initialQuery = '',
    this.initialFilters = const {},
    required this.onSearch,
  });

  @override
  State<BoardingSearch> createState() => _BoardingSearchState();
}

class _BoardingSearchState extends State<BoardingSearch> {
  late TextEditingController _searchController;
  late Map<String, dynamic> _filters;

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
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search Pet Boarding',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name, location, etc.',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Filters',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildFilterChip('Dogs', _filters['petType'] == 'Dogs', (
                  selected,
                ) {
                  setState(() {
                    if (selected) {
                      _filters['petType'] = 'Dogs';
                    } else {
                      _filters.remove('petType');
                    }
                  });
                }),
                _buildFilterChip('Cats', _filters['petType'] == 'Cats', (
                  selected,
                ) {
                  setState(() {
                    if (selected) {
                      _filters['petType'] = 'Cats';
                    } else {
                      _filters.remove('petType');
                    }
                  });
                }),
                _buildFilterChip(
                  'Small Pets',
                  _filters['petType'] == 'Small Pets',
                  (selected) {
                    setState(() {
                      if (selected) {
                        _filters['petType'] = 'Small Pets';
                      } else {
                        _filters.remove('petType');
                      }
                    });
                  },
                ),
                _buildFilterChip('Birds', _filters['petType'] == 'Birds', (
                  selected,
                ) {
                  setState(() {
                    if (selected) {
                      _filters['petType'] = 'Birds';
                    } else {
                      _filters.remove('petType');
                    }
                  });
                }),
                _buildFilterChip(
                  'Reptiles',
                  _filters['petType'] == 'Reptiles',
                  (selected) {
                    setState(() {
                      if (selected) {
                        _filters['petType'] = 'Reptiles';
                      } else {
                        _filters.remove('petType');
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Services',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildFilterChip(
                  'Overnight Boarding',
                  _filters['service'] == 'Overnight Boarding',
                  (selected) {
                    setState(() {
                      if (selected) {
                        _filters['service'] = 'Overnight Boarding';
                      } else {
                        _filters.remove('service');
                      }
                    });
                  },
                ),
                _buildFilterChip('Daycare', _filters['service'] == 'Daycare', (
                  selected,
                ) {
                  setState(() {
                    if (selected) {
                      _filters['service'] = 'Daycare';
                    } else {
                      _filters.remove('service');
                    }
                  });
                }),
                _buildFilterChip(
                  'Grooming',
                  _filters['service'] == 'Grooming',
                  (selected) {
                    setState(() {
                      if (selected) {
                        _filters['service'] = 'Grooming';
                      } else {
                        _filters.remove('service');
                      }
                    });
                  },
                ),
                _buildFilterChip(
                  'Training',
                  _filters['service'] == 'Training',
                  (selected) {
                    setState(() {
                      if (selected) {
                        _filters['service'] = 'Training';
                      } else {
                        _filters.remove('service');
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Show only available places'),
                const Spacer(),
                Switch(
                  value: _filters['availability'] == true,
                  onChanged: (value) {
                    setState(() {
                      if (value) {
                        _filters['availability'] = true;
                      } else {
                        _filters.remove('availability');
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Minimum Rating:'),
                const Spacer(),
                for (var i = 3; i <= 5; i++)
                  _buildRatingButton(
                    i.toDouble(),
                    _filters['minRating'] == i.toDouble(),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _filters.clear();
                    });
                  },
                  child: const Text('Clear All'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onSearch(_searchController.text, _filters);
                      Navigator.pop(context);
                    },
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    bool selected,
    Function(bool) onSelected,
  ) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      backgroundColor: Colors.grey.shade200,
      selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
      checkmarkColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildRatingButton(double rating, bool selected) {
    return InkWell(
      onTap: () {
        setState(() {
          if (selected) {
            _filters.remove('minRating');
          } else {
            _filters['minRating'] = rating;
          }
        });
      },
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).primaryColor : Colors.transparent,
          border: Border.all(
            color:
                selected
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          '$rating+',
          style: TextStyle(color: selected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
