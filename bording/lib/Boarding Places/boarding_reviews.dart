import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_plus_new/model/boarding_review.dart';
import 'package:pet_plus_new/widgets/training/rating_stars.dart';

class BoardingReviews extends StatefulWidget {
  final List<BoardingReview> reviews;
  final String facilityId;
  final VoidCallback onReviewAdded;

  const BoardingReviews({
    super.key,
    required this.reviews,
    required this.facilityId,
    required this.onReviewAdded,
  });

  @override
  State<BoardingReviews> createState() => _BoardingReviewsState();
}

class _BoardingReviewsState extends State<BoardingReviews> {
  final _commentController = TextEditingController();
  double _userRating = 5.0;
  bool _isSubmitting = false;
  late List<BoardingReview> _localReviews;
  String? _selectedPetType;
  String? _stayDuration;

  @override
  void initState() {
    super.initState();
    _localReviews = List.from(widget.reviews);
  }

  @override
  void didUpdateWidget(BoardingReviews oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reviews != widget.reviews) {
      setState(() {
        _localReviews = List.from(widget.reviews);
      });
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _selectPetType(String petType) {
    setState(() {
      _selectedPetType = petType;
    });
  }

  Future<void> _submitReview() async {
    if (_commentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a review comment')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Create a new review
      final newReview = BoardingReview(
        id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
        userId: 'current_user_id',
        userName: 'You',
        userPhotoUrl: '',
        rating: _userRating,
        comment: _commentController.text.trim(),
        date: DateTime.now(),
        facilityId: widget.facilityId,
        petType: _selectedPetType,
        stayDuration: _stayDuration,
      );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Add to local list
      setState(() {
        _localReviews.insert(0, newReview);
        _isSubmitting = false;
      });

      // Clear form
      _commentController.clear();
      _userRating = 5.0;
      _selectedPetType = null;
      _stayDuration = null;

      // Notify parent
      widget.onReviewAdded();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thank you for your review!')),
      );
    } catch (e) {
      setState(() {
        _isSubmitting = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error submitting review: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Write a Review',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Rating: '),
                      const SizedBox(width: 8),
                      RatingStars(
                        rating: _userRating,
                        onRatingChanged: (rating) {
                          setState(() {
                            _userRating = rating;
                          });
                        },
                        size: 30,
                        isEditable: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('Pet Type:'),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildPetChip('Dog'),
                      _buildPetChip('Cat'),
                      _buildPetChip('Bird'),
                      _buildPetChip('Reptile'),
                      _buildPetChip('Small Pet'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Stay Duration (e.g., 3 days)',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _stayDuration = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Share your experience...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 20, 32, 166),
                      ),
                      onPressed: _isSubmitting ? null : _submitReview,
                      child:
                          _isSubmitting
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : const Text(
                                'Submit Review',
                                style: TextStyle(color: Colors.white),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Reviews (${_localReviews.length})',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _localReviews.isEmpty
              ? const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text(
                    'No reviews yet. Be the first to review!',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              )
              : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _localReviews.length,
                itemBuilder: (context, index) {
                  final review = _localReviews[index];
                  return _buildReviewCard(review);
                },
              ),
        ],
      ),
    );
  }

  Widget _buildPetChip(String petType) {
    final bool isSelected = _selectedPetType == petType;

    return FilterChip(
      label: Text(petType),
      selected: isSelected,
      onSelected: (_) => _selectPetType(petType),
      backgroundColor: Colors.grey.shade200,
      selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
      checkmarkColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildReviewCard(BoardingReview review) {
    final bool isCurrentUserReview = review.userName == 'You';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildUserAvatar(review),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              isCurrentUserReview
                                  ? Theme.of(context).primaryColor
                                  : null,
                        ),
                      ),
                      Text(
                        DateFormat('MMM d, yyyy').format(review.date),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                      if (review.petType != null || review.stayDuration != null)
                        Text(
                          [
                            if (review.petType != null) review.petType,
                            if (review.stayDuration != null)
                              '${review.stayDuration} stay',
                          ].join(' · '),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
                RatingStars(rating: review.rating),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              review.comment,
              style: TextStyle(
                fontStyle:
                    isCurrentUserReview ? FontStyle.italic : FontStyle.normal,
              ),
            ),
            if (review.photoUrls != null && review.photoUrls!.isNotEmpty) ...[
              const SizedBox(height: 8),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: review.photoUrls!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          review.photoUrls![index],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey.shade200,
                              child: const Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                                size: 24,
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
            if (isCurrentUserReview)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _localReviews.remove(review);
                    });
                  },
                  child: const Text(
                    'Remove',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserAvatar(BoardingReview review) {
    final bool isCurrentUserReview = review.userName == 'You';

    if (review.userPhotoUrl == null || review.userPhotoUrl!.isEmpty) {
      return CircleAvatar(
        radius: 20,
        backgroundColor:
            isCurrentUserReview
                ? Theme.of(context).primaryColor.withOpacity(0.2)
                : Colors.grey.shade300,
        child: Text(
          review.userName.isNotEmpty ? review.userName[0].toUpperCase() : '?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color:
                isCurrentUserReview
                    ? Theme.of(context).primaryColor
                    : Colors.black54,
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: 20,
      backgroundImage: AssetImage(review.userPhotoUrl!),
      onBackgroundImageError: (exception, stackTrace) {},
    );
  }
}
