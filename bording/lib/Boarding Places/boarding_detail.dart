// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pet_plus_new/model/boarding_fac.dart';
import 'package:pet_plus_new/model/boarding_review.dart';
import 'package:pet_plus_new/screens/Boarding%20Places/boarding_reviews.dart';
import 'package:pet_plus_new/screens/Boarding%20Places/boarding_service.dart';
import 'package:pet_plus_new/widgets/boarding/price_table.dart';
import 'package:pet_plus_new/widgets/training/rating_stars.dart';
import 'package:url_launcher/url_launcher.dart';

class BoardingDetailPage extends StatefulWidget {
  final String facilityId;

  const BoardingDetailPage({super.key, required this.facilityId});

  @override
  State<BoardingDetailPage> createState() => _BoardingDetailPageState();
}

class _BoardingDetailPageState extends State<BoardingDetailPage>
    with SingleTickerProviderStateMixin {
  final BoardingService _boardingService = BoardingService();
  late TabController _tabController;
  bool _isLoading = true;
  late BoardingFacility _facility;
  List<BoardingReview> _reviews = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final facility = await _boardingService.getBoardingFacilityById(
        widget.facilityId,
      );
      final reviews = await _boardingService.getReviewsByFacilityId(
        widget.facilityId,
      );

      setState(() {
        _facility = facility;
        _reviews = reviews;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading details: $e')));
    }
  }

  Future<void> _launchUrl(String url) async {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background:
                    _facility.imageUrls.isNotEmpty
                        ? Image.asset(
                          _facility.imageUrls[0],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade200,
                              child: const Icon(
                                Icons.pets,
                                size: 80,
                                color: Colors.grey,
                              ),
                            );
                          },
                        )
                        : Container(
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.pets,
                            size: 80,
                            color: Colors.grey,
                          ),
                        ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _facility.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        RatingStars(rating: _facility.rating),
                        const SizedBox(width: 8),
                        Text('(${_facility.reviewCount} reviews)'),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                _facility.hasAvailability
                                    ? Colors.green
                                    : Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _facility.hasAvailability
                                ? 'Available'
                                : 'Fully Booked',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_facility.description),
                    const SizedBox(height: 16),
                    _buildSectionTitle('Pet Types'),
                    Wrap(
                      spacing: 8,
                      children:
                          _facility.petTypes
                              .map(
                                (type) => Chip(
                                  label: Text(type),
                                  backgroundColor: Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.2),
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle('Services'),
                    Wrap(
                      spacing: 8,
                      children:
                          _facility.services
                              .map(
                                (service) => Chip(
                                  label: Text(
                                    service,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Color.fromARGB(
                                    255,
                                    20,
                                    32,
                                    166,
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle('Amenities'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          _facility.amenities
                              .map(
                                (amenity) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(amenity),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle('Pricing'),
                    PriceTable(pricing: _facility.pricing),
                    const SizedBox(height: 16),
                    _buildSectionTitle('Hours'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          _facility.businessHours
                              .map(
                                (hours) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(hours),
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle('Contact Information'),
                    _buildContactInfo(Icons.location_on, _facility.address),
                    _buildContactInfo(Icons.phone, _facility.phoneNumber),
                    _buildContactInfo(Icons.email, _facility.email),
                    InkWell(
                      onTap: () => _launchUrl(_facility.website),
                      child: _buildContactInfo(
                        Icons.language,
                        _facility.website,
                        isLink: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                          _facility.socialMedia.entries.map((entry) {
                            IconData icon;
                            switch (entry.key) {
                              case 'facebook':
                                icon = Icons.facebook;
                                break;
                              case 'instagram':
                                icon = Icons.camera_alt;
                                break;
                              case 'twitter':
                                icon = Icons.chat;
                                break;
                              case 'youtube':
                                icon = Icons.play_arrow;
                                break;
                              default:
                                icon = Icons.link;
                            }
                            return IconButton(
                              icon: Icon(icon),
                              onPressed: () => _launchUrl(entry.value),
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 16),
                    if (_facility.imageUrls.length > 1) ...[
                      _buildSectionTitle('Photos'),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _facility.imageUrls.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  _facility.imageUrls[index],
                                  width: 160,
                                  height: 120,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 160,
                                      height: 120,
                                      color: Colors.grey.shade200,
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed:
                          _facility.hasAvailability
                              ? () {
                                // Navigate to booking page
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Booking feature coming soon!',
                                    ),
                                  ),
                                );
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 20, 32, 166),
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Reviews'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: BoardingReviews(
          reviews: _reviews,
          facilityId: _facility.id,
          onReviewAdded: () {
            _loadData();
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: isLink ? Colors.blue : null,
                decoration: isLink ? TextDecoration.underline : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
