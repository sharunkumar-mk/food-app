import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/models/auth_model.dart';
import 'package:food_app/models/otp_verification_model.dart';
import 'package:food_app/modules/widgets/common_button.dart';
import 'package:food_app/modules/widgets/common_textfield.dart';
import 'package:food_app/modules/widgets/phone_confirm_dialog.dart';
import 'package:food_app/providers/provider.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneSignInPage extends ConsumerStatefulWidget {
  const PhoneSignInPage({
    super.key,
  });

  @override
  PhoneSignInPageState createState() => PhoneSignInPageState();
}

class PhoneSignInPageState extends ConsumerState<PhoneSignInPage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController phoneController = TextEditingController();
  String countryCode = '+91';
  final formKey = GlobalKey<FormState>();

  onButtonPressed({required String type}) async {
    if (type == 'CONTINUE') {
      if (formKey.currentState!.validate()) {
        try {
          showDialog(
            context: context,
            builder: (context) {
              return SizedBox(
                  height: 200,
                  child: PhoneConfirmDialog(
                      onButtonPressed: () {
                        ref
                            .read(signUpNotifierProvider.notifier)
                            .verifyPhoneNumber(
                                phoneNumber:
                                    countryCode + phoneController.text.trim());
                      },
                      phoneNumber: phoneController.text.trim()));
            },
          );
        } finally {}
      }
    } else if (type == 'SIGN_UP') {
      Navigator.pushNamed(context, signUpScreen);
    } else if (type == 'PASSWORD') {
      Navigator.pushNamed(context, signInScreen);
    } else if (type == 'FORGOT_PASSWORD') {
    } else if (type == 'GOOGLE') {
    } else if (type == 'FACEBOOK') {}
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ResponseState>(signUpNotifierProvider,
        (ResponseState? previous, ResponseState next) {
      if (next.isLoading!) {
        Navigator.pop(context);

        showProgress(context);
      } else if (next.isError!) {
        Navigator.pop(context);
        showMessage(context, next.errorMessage!);
      } else {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, otpScreen,
            arguments: OtpModel(
                phoneNumber: countryCode + phoneController.text.trim(),
                verificationId: next.response));
      }
    });

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            key: formKey,
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
                      'Please enter your Phone number.',
                      style: TextStyle(
                        color: FoodAppColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1,
                              color: FoodAppColors.grey.withOpacity(0.2))),
                      width: 60,
                      height: 63,
                      child: DropdownButton(
                          elevation: 0,
                          underline: const SizedBox.shrink(),
                          borderRadius: BorderRadius.circular(10),
                          value: "+91",
                          items: const [
                            DropdownMenuItem(value: '+91', child: Text('+91')),
                            DropdownMenuItem(value: '+1', child: Text('+1')),
                          ],
                          onChanged: (value) {
                            countryCode = value!;
                          }),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CommonTextField(
                        validator: (value) => phoneNumberValidator(value),
                        textEditingController: phoneController,
                        hintText: 'Enter Phone Number',
                        labelText: 'Phone Number',
                        isPhone: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                CommonButton(
                  labelText: 'Continue',
                  onButtonPressed: () {
                    onButtonPressed(type: 'CONTINUE');
                  },
                ),
                const SizedBox(height: 30),
                CommonButton(
                  hasBorder: true,
                  foregroundColor: FoodAppColors.red,
                  labelText: 'Login With password',
                  onButtonPressed: () {
                    onButtonPressed(type: 'PASSWORD');
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
      ),
    ));
  }
}
