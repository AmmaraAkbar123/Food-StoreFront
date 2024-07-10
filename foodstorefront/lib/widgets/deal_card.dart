import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/widgets/stack_image_add_icon.dart';

class DealCard extends StatelessWidget {
  final String title2;
  final double originalPrice;
  final double discountedPrice;
  final String description;
  final String imageUrl;
  final bool isPopular;

  DealCard({
    required this.originalPrice,
    required this.discountedPrice,
    required this.description,
    required this.imageUrl,
    this.isPopular = false,
    required this.title2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title2,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                // SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'Rs. $discountedPrice',
                      style: TextStyle(fontSize: 15, color: MyColors.primary),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Rs. $originalPrice',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  //  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    description,
                    style: TextStyle(
                        fontSize: 12,
                        overflow: TextOverflow.clip,
                        color: MyColors.greyText),
                  ),
                ),
                if (isPopular)
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.whatshot,
                          color: MyColors.red,
                          size: 14,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Popular',
                          style:
                              TextStyle(color: MyColors.greyText, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child:
                SizedBox(child: StackImagewithAddIcon(productImage: imageUrl)),
          ),
        ],
      ),
    );
  }
}
