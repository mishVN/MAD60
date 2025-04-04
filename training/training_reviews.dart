import 'package:flutter/material.dart';
import 'package:pet_plus_new/model/review.dart';
import 'package:intl/intl.dart';
import 'package:pet_plus_new/widgets/training/rating_stars.dart';

class TrainingReviews extends StatefulWidget {
  final List<Review> reviews;
  final String facilityId;
  final VoidCallback onReviewAdded;

  const TrainingReviews({
    super.key,
    required this.reviews,
    required this.facilityId,
    required this.onReviewAdded,
  });

  @override
  State<TrainingReviews> createState() => _TrainingReviewsState();
}

class _TrainingReviewsState extends State<TrainingReviews> {
  final _commentController = TextEditingController();
  double _userRating = 5.0;
  bool _isSubmitting = false;
  late List<Review> _localReviews;

  @override
  void initState() {
    super.initState();
    _localReviews = List.from(widget.reviews);
  }

  @override
  void didUpdateWidget(TrainingReviews oldWidget) {
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

    // For debugging
    print("Creating new review");

    try {
      // Create a new review with current user info
      final newReview = Review(
        id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
        userId: 'current_user_id', // In a real app, get from auth service
        userName: 'You', // In a real app, get actual username
        userPhotoUrl: '', // In a real app, get actual user photo
        rating: _userRating,
        comment: _commentController.text.trim(),
        date: DateTime.now(),
        facilityId: widget.facilityId,
      );

      // For debugging
      print("New review created: ${newReview.comment}");

      // Simulating API call
      await Future.delayed(const Duration(seconds: 1));

      // Add review to local list first (so user sees it immediately)
      setState(() {
        _localReviews.insert(0, newReview); // Add to beginning of list
        _isSubmitting = false;
      });

      // For debugging
      print("Review added to local list. Count: ${_localReviews.length}");

      // Clear form
      _commentController.clear();
      _userRating = 5.0;

      // Notify parent component to update backend
      widget.onReviewAdded();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thank you for your review!')),
      );
    } catch (e) {
      // For debugging
      print("Error creating review: $e");

      setState(() {
        _isSubmitting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error submitting review. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // For debugging
    print("Building reviews widget. Review count: ${_localReviews.length}");

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Write a review card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Write a Review',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
                                : const Text('Submit Review'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Reviews header
            Text(
              'Reviews (${_localReviews.length})',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            // Reviews list
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
                    // For debugging
                    print("Building review: ${review.comment}");
                    return _buildReviewCard(review);
                  },
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
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

  Widget _buildUserAvatar(Review review) {
    final bool isCurrentUserReview = review.userName == 'You';

    // Handle null or empty user photo URL
    if (review.userPhotoUrl == null || review.userPhotoUrl.isEmpty) {
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
      backgroundImage: NetworkImage(review.userPhotoUrl),
      onBackgroundImageError: (exception, stackTrace) {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          review.userPhotoUrl,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.person, size: 20);
          },
        ),
      ),
    );
  }
}
