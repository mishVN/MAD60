import 'package:flutter/material.dart';
import 'package:pet_plus_new/model/review.dart';
import 'package:pet_plus_new/model/trainer.dart';
import 'package:pet_plus_new/model/training_class.dart';
import 'package:pet_plus_new/model/training_fac.dart';
import 'package:pet_plus_new/screens/training/class_shedule.dart';
import 'package:pet_plus_new/screens/training/services.dart';
import 'package:pet_plus_new/screens/training/trainer_profile.dart';
import 'package:pet_plus_new/screens/training/training_reviews.dart';
import 'package:pet_plus_new/widgets/training/rating_stars.dart';
import 'package:url_launcher/url_launcher.dart';

class TrainingDetailPage extends StatefulWidget {
  final String facilityId;

  const TrainingDetailPage({super.key, required this.facilityId});

  @override
  State<TrainingDetailPage> createState() => _TrainingDetailPageState();
}

class _TrainingDetailPageState extends State<TrainingDetailPage>
    with SingleTickerProviderStateMixin {
  final TrainingService _trainingService = TrainingService();
  late TabController _tabController;
  bool _isLoading = true;
  late TrainingFacility _facility;
  List<Trainer> _trainers = [];
  List<TrainingClass> _classes = [];
  List<Review> _reviews = [];

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
      final facility = await _trainingService.getTrainingFacilityById(
        widget.facilityId,
      );
      final trainers = await _trainingService.getTrainersByFacilityId(
        widget.facilityId,
      );
      final classes = await _trainingService.getClassesByFacilityId(
        widget.facilityId,
      );
      final reviews = await _trainingService.getReviewsByFacilityId(
        widget.facilityId,
      );

      setState(() {
        _facility = facility;
        _trainers = trainers;
        _classes = classes;
        _reviews = reviews;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
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
                // title: Text(
                //   _facility.name,
                //   style: const TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white,
                //   ),
                // ),
                background: Image.asset(
                  _facility.imageUrl,
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
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_facility.description),
                    const SizedBox(height: 16),
                    const Text(
                      'Contact Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
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
                    const Divider(),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children:
                          _facility.trainingTypes
                              .map(
                                (type) => Chip(
                                  label: Text(
                                    type,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
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
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Trainers'),
                    Tab(text: 'Classes'),
                    Tab(text: 'Reviews'),
                  ],
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Theme.of(context).primaryColor,
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            TrainerProfile(trainers: _trainers),
            ClassSchedule(classes: _classes),
            TrainingReviews(
              reviews: _reviews,
              facilityId: _facility.id,
              onReviewAdded: () {
                _loadData();
              },
            ),
          ],
        ),
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
