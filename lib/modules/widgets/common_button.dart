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
    this.borderColor = FoodAppColors.primaryRed,
    this.backgroundColor = FoodAppColors.primaryRed,
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
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
              vertical: paddingVertical, horizontal: paddingHorizontal)),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          side: hasBorder
              ? WidgetStatePropertyAll(BorderSide(width: 1, color: borderColor))
              : null,
          foregroundColor: WidgetStatePropertyAll(foregroundColor),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey;
              }
              return hasBorder ? FoodAppColors.white : backgroundColor;
            },
          ),
          // backgroundColor: MaterialStatePropertyAll(
          //     hasBorder ? FoodAppColors.white : backgroundColor),
          overlayColor: WidgetStatePropertyAll(hasBorder
              ? FoodAppColors.primaryRed.withOpacity(.10)
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
