import 'package:flutter/material.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/modules/widgets/common_button.dart';
import 'package:food_app/modules/widgets/common_textbutton.dart';

class PhoneConfirmDialog extends StatelessWidget {
  const PhoneConfirmDialog(
      {super.key, required this.onButtonPressed, required this.phoneNumber});

  final String phoneNumber;
  final VoidCallback onButtonPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: FoodAppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 200,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Sign In with phone number',
                style: TextStyle(
                  fontSize: 16,
                  color: FoodAppColors.grey,
                ),
              ),
              Text(
                "(+91) $phoneNumber",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: FoodAppColors.black,
                ),
              ),
              const Text(
                'We will send the authentication code to the phone number you entered. Do you want continue?',
                style: TextStyle(
                  fontSize: 16,
                  color: FoodAppColors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Center(
                child: CommonTextButton(
                  onButtonPressed: () {
                    Navigator.pop(context);
                  },
                  labelText: 'cancel',
                ),
              ),
            ),
            Expanded(
              child: CommonButton(
                onButtonPressed: onButtonPressed,
                labelText: 'Next',
              ),
            ),
          ],
        )
      ],
    );
  }
}
