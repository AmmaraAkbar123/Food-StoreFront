import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class ReviewCard extends StatelessWidget {
  final String reviewText;
  final double rating;
  final String reviewerName;
  final String timeAgo;

  const ReviewCard({
    Key? key,
    required this.reviewText,
    required this.rating,
    required this.reviewerName,
    required this.timeAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              reviewText,
              style: TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis),
            ),
            SizedBox(height: 8),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingBar(
                  //isHalfAllowed: true,
                  size: 15,
                  alignment: Alignment.center,
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  emptyColor: MyColors.primary,
                  filledColor: Colors.amberAccent,
                  halfFilledIcon: Icons.star_half,
                  halfFilledColor: Colors.amberAccent,
                  initialRating: 3.5,
                  maxRating: 5, onRatingChanged: (double) {},
                ),
                SizedBox(width: 8),
                Text(
                  reviewerName,
                  style: TextStyle(color: MyColors.greyText, fontSize: 12),
                ),
                SizedBox(width: 8),
                Text(timeAgo,
                    style: TextStyle(color: MyColors.greyText, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
