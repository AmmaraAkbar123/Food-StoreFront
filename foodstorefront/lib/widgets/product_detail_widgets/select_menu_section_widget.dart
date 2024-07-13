import 'package:flutter/material.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/widgets/product_detail_widgets/reuired_optional_button.dart';

class SelectMenuSection extends StatefulWidget {
  final Product product;
  final ProductVariation variation;

  const SelectMenuSection({
    super.key,
    required this.product,
    required this.variation,
  });

  @override
  State<SelectMenuSection> createState() => _SelectMenuSectionState();
}

class _SelectMenuSectionState extends State<SelectMenuSection> {
  String _selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.grey),
        borderRadius: BorderRadius.circular(12),
        color: MyColors.lightPink,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 250,
                  child: Text(
                    widget.variation.title,
                    style: TextStyle(
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
                RequiredOptionalButton(
                  text: 'Required',
                  color: MyColors.primary,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Text(
              "Select one",
              style: TextStyle(
                color: MyColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: widget.product.variations.map((variation) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: _buildSelectionCircle(
                      context, variation.name, variation.price),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSelectionCircle(BuildContext context, String text, String txt2) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedOption = text;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color:
                  _selectedOption == text ? MyColors.primary : MyColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: MyColors.primary, width: 2),
            ),
            child: _selectedOption == text
                ? Icon(Icons.check, color: MyColors.white)
                : null,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: MyColors.greyText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            txt2,
            style: TextStyle(
              color: MyColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
