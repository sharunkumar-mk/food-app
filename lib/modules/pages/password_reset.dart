import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/modules/widgets/common_button.dart';
import 'package:food_app/modules/widgets/common_textfield.dart';
import 'package:food_app/providers/signin_provider.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordReset extends ConsumerStatefulWidget {
  const PasswordReset({super.key});

  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends ConsumerState<PasswordReset> {
  TextEditingController emailController = TextEditingController();

  onButtonPressed({required String type}) {
    if (type == 'SEND_EMAIL') {
      ref
          .read(signInNotifierProvider.notifier)
          .sendPasswordResetEmail(email: emailController.text.trim());
    }
    if (type == 'SIGN_IN') {
      Navigator.pushReplacementNamed(context, signInScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ResponseState>(signInNotifierProvider,
        (ResponseState? previous, ResponseState next) {
      if (next.isLoading!) {
        showProgress(context);
      } else if (next.isError!) {
        Navigator.pop(context);
        showMessage(context, next.errorMessage.toString());
      } else {
        Navigator.pop(context);
        showMessage(context, 'Email send sucessfully');
        Navigator.pushReplacementNamed(context, signInScreen);
      }
    });

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [Image.asset("assets/images/logo.png")],
              ),
              const SizedBox(height: 30),
              const Row(
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                        color: FoodAppColors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Cohort',
                    style: TextStyle(
                        color: FoodAppColors.red,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Row(
                children: [
                  Text(
                    'Please enter your sign in details.',
                    style: TextStyle(
                      color: FoodAppColors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 41),
              CommonTextField(
                isEmail: true,
                textEditingController: emailController,
                hintText: 'Enter Email address',
                labelText: 'Email address',
                isPhone: true,
              ),
              const SizedBox(height: 30),
              CommonButton(
                labelText: 'Send verification email',
                hasBorder: true,
                foregroundColor: FoodAppColors.red,
                onButtonPressed: () {
                  onButtonPressed(type: 'SEND_EMAIL');
                },
              ),
              const SizedBox(height: 30),
              CommonButton(
                labelText: 'Sign In',
                foregroundColor: FoodAppColors.white,
                onButtonPressed: () {
                  onButtonPressed(type: 'SIGN_IN');
                },
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Or Continue With',
                    style: GoogleFonts.poppins(
                      color: FoodAppColors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CommonButton(
                      hasBorder: true,
                      hasIcon: true,
                      labelText: 'Google',
                      icon: Image.asset(
                        'assets/icons/google.png',
                        width: 24,
                        height: 24,
                      ),
                      borderColor: FoodAppColors.grey.withOpacity(.20),
                      foregroundColor: FoodAppColors.black,
                      onButtonPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CommonButton(
                      labelText: 'Facebook',
                      hasBorder: true,
                      hasIcon: true,
                      icon: Image.asset(
                        'assets/icons/fb.png',
                        width: 24,
                        height: 24,
                      ),
                      borderColor: FoodAppColors.grey.withOpacity(.20),
                      foregroundColor: FoodAppColors.black,
                      onButtonPressed: () {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
