import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class RemoveFromOrderSection extends StatelessWidget {
  const RemoveFromOrderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // To align text to the start
      children: [
        Text(
          "If this product is not available",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: "Remove it from my order",
            hintStyle: TextStyle(
              color: Colors.grey,
            ), // Hint text style
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: MyColors.primary,
              ),
            ),
            suffixIcon: Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: MyColors.primary,
            ), // Icon on the right side
            contentPadding: EdgeInsets.symmetric(
                vertical: 16, horizontal: 12), // Padding inside the TextField
          ),
        )
      ],
    );
  }
}
