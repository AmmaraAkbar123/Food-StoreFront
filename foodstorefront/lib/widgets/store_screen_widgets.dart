import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DiscountOffTag extends StatelessWidget {
  const DiscountOffTag({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      //height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          color: MyColors.lightPrimary,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.discount_circle,
                color: MyColors.primary,
                size: 16,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Rs. 445 off",
                style: TextStyle(
                    color: MyColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Min.order Rs. 445. Valid for selected items.\nAuto-applied",
            style: TextStyle(
              fontSize: 10,
            ),
          )
        ],
      ),
    );
  }
}

class AvailableDeals extends StatelessWidget {
  const AvailableDeals({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.event_available,
              color: MyColors.primary,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Available deals",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }
}

class DeliveryInfo extends StatelessWidget {
  const DeliveryInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.lock_clock_outlined,
              color: MyColors.primary,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Delivery: 10-25 min",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Text(
          "Change",
          style: TextStyle(
              fontSize: 12, color: MyColors.greyy, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}

class SeeReviews extends StatelessWidget {
  const SeeReviews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.star_border_outlined,
              color: MyColors.primary,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "4.7",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "10000+ ratings",
              style: TextStyle(color: MyColors.greyText, fontSize: 12),
            )
          ],
        ),
        Text(
          "See Reviews",
          style: TextStyle(
              fontSize: 12,
              color: MyColors.primary,
              fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}

class MoreInfo extends StatelessWidget {
  const MoreInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "0.8km away | Rs. 79.00 delivery",
              style: TextStyle(color: MyColors.greyText, fontSize: 12),
            ),
            Text(
              "More info",
              style: TextStyle(
                  fontSize: 12,
                  color: MyColors.primary,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
        Text(
          "Rs.249.00 minimum | Rs. 9.99 service",
          style: TextStyle(color: MyColors.greyText, fontSize: 12),
        ),
      ],
    );
  }
}
