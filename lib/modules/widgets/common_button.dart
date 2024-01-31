import 'package:flutter/material.dart';
import 'package:food_app/constants/color_path.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      required this.onButtonPressed,
      this.hasBorder = false,
      this.borderColor = FoodAppColors.red,
      this.backgroundColor = FoodAppColors.red,
      this.foregroundColor = FoodAppColors.white,
      this.labelText = 'Button',
      this.hasIcon = false,
      this.icon,
      this.hasIconOnly = false});

  final VoidCallback onButtonPressed;
  final bool hasBorder;
  final Color borderColor;
  final Color backgroundColor;
  final Color foregroundColor;
  final String labelText;
  final bool hasIcon;
  final Widget? icon;
  final bool hasIconOnly;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 16, horizontal: 20)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
            side: hasBorder
                ? MaterialStatePropertyAll(
                    BorderSide(width: 1, color: borderColor))
                : null,
            foregroundColor: MaterialStatePropertyAll(foregroundColor),
            backgroundColor: MaterialStatePropertyAll(
                hasBorder ? FoodAppColors.white : backgroundColor),
            overlayColor: MaterialStatePropertyAll(hasBorder
                ? FoodAppColors.red.withOpacity(.10)
                : FoodAppColors.white.withOpacity(.10))),
        onPressed: onButtonPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hasIcon
                ? Padding(
                    padding: const EdgeInsets.only(right: 10), child: icon!)
                : const SizedBox.shrink(),
            hasIconOnly
                ? const SizedBox.shrink()
                : Text(
                    labelText,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
          ],
        ));
  }
}
