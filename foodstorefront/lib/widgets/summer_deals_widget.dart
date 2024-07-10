import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/utils/images_strings.dart';
import 'package:foodstorefront/widgets/rating_widget.dart';
import 'package:foodstorefront/widgets/deal_card.dart';

class SummerDealsWidget extends StatelessWidget {
  const SummerDealsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Fellow foodies say",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              Text(
                "See all",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: MyColors.primary),
              ),
            ],
          ),
        ),

        ///reviews
        Container(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: ReviewCard(
                  reviewText: 'Review $index',
                  rating: 4.0,
                  reviewerName: 'Reviewer $index',
                  timeAgo: '1 month ago',
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10),

        //summer deals card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Text(
                  "Summer Deals",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: List.generate(4, (index) {
                  return Column(
                    children: [
                      if (index > 0)
                        Divider(
                          indent: 12,
                          endIndent: 12,
                        ),
                      DealCard(
                        title2: 'Summer Deal ${index + 1}',
                        originalPrice: 1020.00,
                        discountedPrice: 575.00,
                        description:
                            'Shotgun Burger (Org/Hot) + Original Fries (Plain/Masala)',
                        imageUrl: ImagesStrings
                            .burgerimage, // replace with your image URL
                        isPopular: true,
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
