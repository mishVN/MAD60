import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;
  final bool isEditable;
  final Function(double)? onRatingChanged;

  const RatingStars({
    super.key,
    required this.rating,
    this.size = 16,
    this.isEditable = false,
    this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap:
              isEditable
                  ? () {
                    if (onRatingChanged != null) {
                      onRatingChanged!(index + 1.0);
                    }
                  }
                  : null,
          child: Icon(
            index < rating.floor()
                ? Icons.star
                : index < rating
                ? Icons.star_half
                : Icons.star_border,
            color: Colors.amber,
            size: size,
          ),
        );
      }),
    );
  }
}
