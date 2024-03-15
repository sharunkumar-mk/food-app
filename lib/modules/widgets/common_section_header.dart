import 'package:flutter/material.dart';
import 'package:food_app/constants/color_path.dart';

class CommonSectionHeader extends StatelessWidget {
  const CommonSectionHeader(
      {super.key,
      required this.header,
      required this.subHeader,
      this.onButtonPressed});

  final String header;
  final String subHeader;
  final VoidCallback? onButtonPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            header,
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            subHeader,
            style: const TextStyle(
              fontSize: 14,
              color: FoodAppColors.red,
            ),
          ),
        ],
      ),
    );
  }
}
