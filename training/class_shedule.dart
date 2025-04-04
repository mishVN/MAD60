import 'package:flutter/material.dart';
import 'package:pet_plus_new/model/training_class.dart';

class ClassSchedule extends StatelessWidget {
  final List<TrainingClass> classes;

  const ClassSchedule({super.key, required this.classes});

  @override
  Widget build(BuildContext context) {
    if (classes.isEmpty) {
      return const Center(child: Text('No classes available'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final trainingClass = classes[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        trainingClass.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        trainingClass.trainingType,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(trainingClass.description),
                const SizedBox(height: 16),
                _buildInfoRow(
                  'Price',
                  '\$${trainingClass.price.toStringAsFixed(2)}',
                ),
                _buildInfoRow(
                  'Sessions',
                  '${trainingClass.sessionCount} sessions (${trainingClass.sessionLengthMinutes} mins each)',
                ),
                _buildInfoRow(
                  'Max Participants',
                  trainingClass.maxParticipants.toString(),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Schedule',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...trainingClass.schedule.entries
                    .map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                entry.key,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(child: Text(entry.value.join(', '))),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                if (trainingClass.prerequisites.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Prerequisites',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...trainingClass.prerequisites
                      .map(
                        (prereq) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.check_circle,
                                size: 16,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 8),
                              Expanded(child: Text(prereq)),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ],
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle class booking
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Booking functionality coming soon!'),
                        ),
                      );
                    },
                    child: const Text('Book Now'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
