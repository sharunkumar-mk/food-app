import 'package:flutter/material.dart';
import 'package:food_app/constants/color_path.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    super.key,
    required this.textEditingController,
    this.labelText = 'Label Text',
    this.hintText = 'Hint Text',
    this.hasSuffix = false,
    this.hasPrefix = false,
    this.prefixIcon,
    this.suffixIcon,
    this.isPhone = false,
    this.isEmail = false,
    this.isPassword = false,
  });

  final TextEditingController textEditingController;
  final String labelText;
  final String hintText;
  final bool hasSuffix;
  final bool hasPrefix;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final bool isPhone;
  final bool isEmail;
  final bool isPassword;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword ? true : false,
      keyboardType: widget.isPhone
          ? TextInputType.phone
          : widget.isEmail
              ? TextInputType.emailAddress
              : null,
      controller: widget.textEditingController,
      style: const TextStyle(
        height: 2.5,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: FoodAppColors.black,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: FoodAppColors.grey.withOpacity(0.2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: FoodAppColors.grey.withOpacity(0.2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: FoodAppColors.red,
              width: 1,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          prefixIcon: widget.hasPrefix ? widget.prefixIcon : null,
          suffixIcon: widget.isPhone
              ? Image.asset(
                  'assets/icons/call.png',
                  height: 24,
                  width: 24,
                )
              : widget.isPassword
                  ? Image.asset(
                      'assets/icons/eye.png',
                      height: 24,
                      width: 24,
                    )
                  : widget.hasSuffix
                      ? IconButton(
                          icon: widget.suffixIcon!,
                          onPressed: () {},
                        )
                      : null),
    );
  }
}
