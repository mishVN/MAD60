import 'package:pet_plus_new/data/boarding.dart';
import 'package:pet_plus_new/model/boarding_fac.dart';
import 'package:pet_plus_new/model/boarding_review.dart';

class BoardingService {
  Future<List<BoardingFacility>> getBoardingFacilities({
    String query = '',
    Map<String, dynamic> filters = const {},
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Get facilities from mock data
    List<BoardingFacility> facilities =
        BoardingMockData.getBoardingFacilities();

    // Apply search query
    if (query.isNotEmpty) {
      facilities =
          facilities
              .where(
                (facility) =>
                    facility.name.toLowerCase().contains(query.toLowerCase()) ||
                    facility.description.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    facility.address.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
              )
              .toList();
    }

    // Apply filters
    if (filters.containsKey('petType') && filters['petType'] != null) {
      facilities =
          facilities
              .where(
                (facility) => facility.petTypes.contains(filters['petType']),
              )
              .toList();
    }

    if (filters.containsKey('service') && filters['service'] != null) {
      facilities =
          facilities
              .where(
                (facility) => facility.services.contains(filters['service']),
              )
              .toList();
    }

    if (filters.containsKey('availability') &&
        filters['availability'] == true) {
      facilities =
          facilities.where((facility) => facility.hasAvailability).toList();
    }

    if (filters.containsKey('minRating') && filters['minRating'] != null) {
      facilities =
          facilities
              .where((facility) => facility.rating >= filters['minRating'])
              .toList();
    }

    return facilities;
  }

  Future<BoardingFacility> getBoardingFacilityById(String id) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Get all facilities
    final facilities = await getBoardingFacilities();

    // Find facility by ID
    return facilities.firstWhere(
      (facility) => facility.id == id,
      orElse: () => facilities.first,
    );
  }

  Future<List<BoardingReview>> getReviewsByFacilityId(String facilityId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Get reviews from mock data
    return BoardingMockData.getReviewsByFacilityId(facilityId);
  }

  Future<void> addReview(BoardingReview review) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // In a real app, we would post this to a backend server
    // For now, we just simulate the API call
    return;
  }
}
