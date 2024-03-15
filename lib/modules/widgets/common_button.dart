import 'package:flutter/material.dart';
import 'package:food_app/constants/color_path.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onButtonPressed;
  final bool hasBorder;
  final Color borderColor;
  final Color backgroundColor;
  final Color foregroundColor;
  final String labelText;
  final bool hasIcon;
  final Widget? icon;
  final bool hasIconOnly;
  final double paddingVertical;
  final double paddingHorizontal;
  final bool isActive;
  const CommonButton({
    super.key,
    required this.onButtonPressed,
    this.hasBorder = false,
    this.borderColor = FoodAppColors.red,
    this.backgroundColor = FoodAppColors.red,
    this.foregroundColor = FoodAppColors.white,
    this.labelText = '',
    this.hasIcon = false,
    this.icon,
    this.hasIconOnly = false,
    this.paddingHorizontal = 20,
    this.paddingVertical = 16,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
              vertical: paddingVertical, horizontal: paddingHorizontal)),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          side: hasBorder
              ? MaterialStatePropertyAll(
                  BorderSide(width: 1, color: borderColor))
              : null,
          foregroundColor: MaterialStatePropertyAll(foregroundColor),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.grey;
              }
              return hasBorder ? FoodAppColors.white : backgroundColor;
            },
          ),
          // backgroundColor: MaterialStatePropertyAll(
          //     hasBorder ? FoodAppColors.white : backgroundColor),
          overlayColor: MaterialStatePropertyAll(hasBorder
              ? FoodAppColors.red.withOpacity(.10)
              : FoodAppColors.white.withOpacity(.10))),
      onPressed: isActive ? onButtonPressed : null,
      child: hasIconOnly
          ? icon!
          : hasIcon
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: icon!,
                    ),
                    Text(
                      labelText,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              : Text(
                  labelText,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
    );
  }
}
