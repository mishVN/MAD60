import 'package:pet_plus_new/model/review.dart';
import 'package:pet_plus_new/model/trainer.dart';
import 'package:pet_plus_new/model/training_class.dart';
import 'package:pet_plus_new/model/training_fac.dart';

class TrainingService {
  // This would typically connect to your backend API
  // For now, we'll use mock data

  Future<List<TrainingFacility>> getTrainingFacilities({
    String query = '',
    Map<String, dynamic> filters = const {},
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));

    // This would be replaced with actual API calls
    List<TrainingFacility> mockFacilities = [
      TrainingFacility(
        id: '1',
        name: 'Pawsome Training Center',
        description: 'Professional dog training for all breeds and ages.',
        address: 'No. 123 Main St, Kottawa, Sri Lanka',
        phoneNumber: '(081) 123-4567',
        email: 'info@pawsometraining.com',
        website: 'www.pawsometraining.com',
        socialMedia: {
          'facebook': 'facebook.com/pawsometraining',
          'instagram': 'instagram.com/pawsometraining',
        },
        trainingTypes: ['Obedience', 'Agility', 'Behavior Correction'],
        breedSpecializations: ['All breeds'],
        imageUrl: 'assets/AdobeStock_282473421-scaled.jpg',
        rating: 4.8,
        reviewCount: 124,
        trainerIds: ['t1', 't2'],
        classIds: ['c1', 'c2', 'c3'],
        latitude: 40.7128,
        longitude: -74.0060,
      ),
      TrainingFacility(
        id: '2',
        name: 'Elite K9 Academy',
        description: 'Specialized training for working and service dogs.',
        address: '456 Oak Ave, Pannipitiya, Sri Lanka',
        phoneNumber: '(555) 987-6543',
        email: 'training@elitek9.com',
        website: 'www.elitek9.com',
        socialMedia: {
          'facebook': 'facebook.com/elitek9',
          'instagram': 'instagram.com/elitek9academy',
          'youtube': 'youtube.com/elitek9',
        },
        trainingTypes: [
          'Service Dog Training',
          'Protection Training',
          'Obedience',
        ],
        breedSpecializations: [
          'German Shepherd',
          'Belgian Malinois',
          'Doberman',
        ],
        imageUrl: 'assets/dog-indoor-582.27a0b3efe00405e7.png',
        rating: 4.9,
        reviewCount: 87,
        trainerIds: ['t3', 't4'],
        classIds: ['c4', 'c5'],
        latitude: 34.0522,
        longitude: -118.2437,
      ),
    ];

    // Apply filters and search
    if (query.isNotEmpty) {
      mockFacilities =
          mockFacilities
              .where(
                (facility) =>
                    facility.name.toLowerCase().contains(query.toLowerCase()) ||
                    facility.description.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
              )
              .toList();
    }

    if (filters.containsKey('trainingType') &&
        filters['trainingType'] != null) {
      mockFacilities =
          mockFacilities
              .where(
                (facility) =>
                    facility.trainingTypes.contains(filters['trainingType']),
              )
              .toList();
    }

    if (filters.containsKey('breedSpecialization') &&
        filters['breedSpecialization'] != null) {
      mockFacilities =
          mockFacilities
              .where(
                (facility) => facility.breedSpecializations.contains(
                  filters['breedSpecialization'],
                ),
              )
              .toList();
    }

    return mockFacilities;
  }

  Future<TrainingFacility> getTrainingFacilityById(String id) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Get all facilities and find the one with the matching ID
    final facilities = await getTrainingFacilities();

    // Find the facility with the matching ID or return the first facility as fallback
    return facilities.firstWhere(
      (facility) => facility.id == id,
      orElse: () => facilities.first,
    );
  }

  Future<List<Trainer>> getTrainersByFacilityId(String facilityId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // For facility 1
    if (facilityId == '1') {
      return [
        Trainer(
          id: 't1',
          name: 'Sarah Johnson',
          bio:
              'Certified professional dog trainer with 10+ years of experience.',
          imageUrl: 'assets/trainers/trainer1.jpg',
          specializations: [
            'Obedience',
            'Puppy Training',
            'Behavior Modification',
          ],
          certifications: ['CPDT-KA', 'AKC CGC Evaluator'],
          yearsOfExperience: 12,
          rating: 4.9,
        ),
        Trainer(
          id: 't2',
          name: 'Mike Peters',
          bio: 'Specializes in agility and competition training.',
          imageUrl: 'assets/trainers/trainer2.jpg',
          specializations: [
            'Agility',
            'Competition Obedience',
            'Trick Training',
          ],
          certifications: ['NADAC Agility Instructor', 'AKC Agility Evaluator'],
          yearsOfExperience: 8,
          rating: 4.7,
        ),
      ];
    }
    // For facility 2
    else if (facilityId == '2') {
      return [
        Trainer(
          id: 't3',
          name: 'Alex Rodriguez',
          bio: 'Expert in protection and service dog training.',
          imageUrl: 'assets/trainers/trainer3.jpg',
          specializations: [
            'Protection Training',
            'Service Dog Training',
            'K9 Unit Training',
          ],
          certifications: ['NAPWDA Certified', 'PSA Decoy'],
          yearsOfExperience: 15,
          rating: 5.0,
        ),
        Trainer(
          id: 't4',
          name: 'Lisa Chen',
          bio: 'Behavioral specialist focusing on rehabilitation.',
          imageUrl: 'assets/trainers/trainer4.jpg',
          specializations: ['Behavior Modification', 'Reactivity', 'Anxiety'],
          certifications: ['CDBC', 'Fear-Free Certified'],
          yearsOfExperience: 10,
          rating: 4.8,
        ),
      ];
    }

    // Default fallback
    return [];
  }

  Future<List<TrainingClass>> getClassesByFacilityId(String facilityId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // For facility 1
    if (facilityId == '1') {
      return [
        TrainingClass(
          id: 'c1',
          name: 'Basic Obedience',
          description:
              'Learn essential commands and build a strong foundation.',
          trainingType: 'Obedience',
          trainerId: 't1',
          price: 299.99,
          sessionCount: 6,
          sessionLengthMinutes: 60,
          schedule: {
            'Monday': ['10:00 AM', '6:00 PM'],
            'Wednesday': ['6:00 PM'],
            'Saturday': ['9:00 AM', '11:00 AM'],
          },
          maxParticipants: 8,
          prerequisites: [
            'Dogs must be at least 16 weeks old',
            'Up-to-date vaccinations',
          ],
        ),
        TrainingClass(
          id: 'c2',
          name: 'Agility Basics',
          description:
              'Introduction to agility equipment and basic handling skills.',
          trainingType: 'Agility',
          trainerId: 't2',
          price: 349.99,
          sessionCount: 8,
          sessionLengthMinutes: 75,
          schedule: {
            'Tuesday': ['5:00 PM'],
            'Thursday': ['5:00 PM'],
            'Sunday': ['10:00 AM'],
          },
          maxParticipants: 6,
          prerequisites: [
            'Dogs must be at least 12 months old',
            'Basic obedience required',
          ],
        ),
      ];
    }
    // For facility 2
    else if (facilityId == '2') {
      return [
        TrainingClass(
          id: 'c4',
          name: 'Protection Training',
          description: 'Train your dog for home and personal protection.',
          trainingType: 'Protection Training',
          trainerId: 't3',
          price: 499.99,
          sessionCount: 10,
          sessionLengthMinutes: 90,
          schedule: {
            'Monday': ['4:00 PM'],
            'Friday': ['4:00 PM'],
          },
          maxParticipants: 4,
          prerequisites: [
            'Dogs must be at least 18 months old',
            'Good temperament evaluation required',
            'Advanced obedience required',
          ],
        ),
        TrainingClass(
          id: 'c5',
          name: 'Service Dog Foundation',
          description: 'First steps toward service dog training.',
          trainingType: 'Service Dog Training',
          trainerId: 't3',
          price: 599.99,
          sessionCount: 12,
          sessionLengthMinutes: 60,
          schedule: {
            'Wednesday': ['10:00 AM', '2:00 PM'],
            'Saturday': ['9:00 AM'],
          },
          maxParticipants: 5,
          prerequisites: [
            'Dogs must be 6-18 months old',
            'Temperament evaluation required',
          ],
        ),
      ];
    }

    // Default fallback
    return [];
  }

  Future<List<Review>> getReviewsByFacilityId(String facilityId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // For facility 1
    if (facilityId == '1') {
      return [
        Review(
          id: 'r1',
          userId: 'u1',
          userName: 'John D.',
          userPhotoUrl: 'assets/users/user1.jpg',
          rating: 5.0,
          comment:
              'Great training facility! My dog learned so much in just a few weeks.',
          date: DateTime.now().subtract(const Duration(days: 14)),
          facilityId: facilityId,
        ),
        Review(
          id: 'r2',
          userId: 'u2',
          userName: 'Emily S.',
          userPhotoUrl: 'assets/users/user2.jpg',
          rating: 4.5,
          comment:
              'The trainers are knowledgeable and patient. My puppy loved the classes.',
          date: DateTime.now().subtract(const Duration(days: 30)),
          facilityId: facilityId,
        ),
      ];
    }
    // For facility 2
    else if (facilityId == '2') {
      return [
        Review(
          id: 'r3',
          userId: 'u3',
          userName: 'Michael T.',
          userPhotoUrl: 'assets/users/user3.jpg',
          rating: 5.0,
          comment:
              'Alex is an amazing trainer. My German Shepherd is now perfectly trained for protection work.',
          date: DateTime.now().subtract(const Duration(days: 5)),
          facilityId: facilityId,
        ),
        Review(
          id: 'r4',
          userId: 'u4',
          userName: 'Jessica L.',
          userPhotoUrl: '',
          rating: 4.0,
          comment:
              'Great facility but classes fill up quickly. Book well in advance!',
          date: DateTime.now().subtract(const Duration(days: 45)),
          facilityId: facilityId,
        ),
      ];
    }

    // Default fallback
    return [];
  }

  // For adding a new review
  Future<void> addReview(Review review) async {
    // In a real app, this would send the review to a backend service
    // For now, we'll just simulate an API delay
    await Future.delayed(const Duration(seconds: 1));

    // You could implement local caching here if needed
    return;
  }
}
