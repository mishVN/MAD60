import 'package:flutter/material.dart';
import 'package:pet_plus_new/model/trainer.dart';
import 'package:pet_plus_new/widgets/training/rating_stars.dart';

class TrainerProfile extends StatelessWidget {
  final List<Trainer> trainers;

  const TrainerProfile({super.key, required this.trainers});

  @override
  Widget build(BuildContext context) {
    if (trainers.isEmpty) {
      return const Center(child: Text('No trainers available'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: trainers.length,
      itemBuilder: (context, index) {
        final trainer = trainers[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(
                        trainer.imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.person, size: 40),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trainer.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              RatingStars(rating: trainer.rating),
                              const SizedBox(width: 8),
                              Text(
                                '${trainer.yearsOfExperience} years experience',
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children:
                                trainer.specializations
                                    .map(
                                      (spec) => Chip(
                                        label: Text(
                                          spec,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        padding: EdgeInsets.zero,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        backgroundColor: Colors.blue.shade100,
                                      ),
                                    )
                                    .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(trainer.bio),
                const SizedBox(height: 16),
                const Text(
                  'Certifications',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...trainer.certifications
                    .map(
                      (cert) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.verified,
                              size: 16,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 8),
                            Text(cert),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
