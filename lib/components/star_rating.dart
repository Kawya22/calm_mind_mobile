import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final int rating;
  final ValueChanged<int> onRatingChanged;

  StarRating({required this.rating, required this.onRatingChanged});

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(10, (index) {
        final star = index + 1;
        return InkWell(
          onTap: () {
            widget.onRatingChanged(star);
          },
          child: Icon(
            star <= widget.rating ? Icons.star : Icons.star_border,
            color: star <= widget.rating ? Colors.amber : Colors.grey,
          ),
        );
      }),
    );
  }
}