import 'package:flutter/material.dart';
import 'package:foodstorefront/models/review_model.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/widgets/review_card.dart'; // Assuming you have defined ReviewCard widget

class FavoriteScreen extends StatelessWidget {
  final List<ReviewModel> reviews; // Existing list of reviews

  const FavoriteScreen({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Expanded(child: ReviewCard(reviews: reviews)),
    );
  }
}
