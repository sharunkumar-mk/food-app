import 'package:flutter/material.dart';
import 'package:food_app/constants/color_path.dart';

class CommonTextButton extends StatelessWidget {
  const CommonTextButton(
      {super.key,
      required this.onButtonPressed,
      this.labelText = '',
      this.textColor = FoodAppColors.red});

  final VoidCallback onButtonPressed;
  final String labelText;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonPressed,
      child: Text(
        labelText,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
