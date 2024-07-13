import 'package:flutter/material.dart';
import 'package:foodstorefront/utils/colors.dart';

class SpecialInstructionSection extends StatefulWidget {
  const SpecialInstructionSection({
    super.key,
  });

  @override
  _SpecialInstructionSectionState createState() =>
      _SpecialInstructionSectionState();
}

class _SpecialInstructionSectionState extends State<SpecialInstructionSection> {
  final TextEditingController _controller = TextEditingController();
  final int maxLength = 500;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Special Instructions",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8),
        Text(
          "Please let us know if you are allergic to anything or if we need to avoid anything",
          style: TextStyle(
              fontSize: 13,
              color: MyColors.greyText,
              overflow: TextOverflow.clip),
        ),
        SizedBox(height: 20),
        Container(
          height: 130,
          child: TextFormField(
            controller: _controller,
            maxLines: null,
            expands: true,
            decoration: InputDecoration(
              labelText: "e.g. no mayo",
              alignLabelWithHint: true,
              labelStyle: TextStyle(color: MyColors.greyText, fontSize: 14),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: MyColors.greyText,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: MyColors.greyText,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: MyColors.primary,
                ),
              ),
            ),
            onChanged: (text) {
              setState(() {});
            },
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              '${_controller.text.length}/$maxLength',
              style: TextStyle(fontSize: 12, color: MyColors.black87),
            ),
          ),
        ),
      ],
    );
  }
}
