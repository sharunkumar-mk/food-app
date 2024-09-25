import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/modules/widgets/common_button.dart';
import 'package:food_app/modules/widgets/common_textfield.dart';
import 'package:food_app/providers/provider.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends ConsumerState<SignInPage> {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  late bool isFirstTime;
  final formKey = GlobalKey<FormState>();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  onButtonPressed({required String type}) async {
    if (type == 'SIGN_IN') {
      if (formKey.currentState!.validate()) {
        ref.read(signInNotifierProvider.notifier).signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      }
    } else if (type == 'SIGN_UP') {
      Navigator.pushNamed(context, signUpScreen);
    } else if (type == 'FORGOT_PASSWORD') {
      Navigator.pushNamed(context, passwordResetScreen);
    } else if (type == 'GOOGLE') {
      try {
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        print(googleUser);
      } catch (e) {
        print(e);
      }
    } else if (type == 'PHONE') {
      Navigator.pushNamed(context, phoneSigninScreen);
    } else if (type == 'FACEBOOK') {}
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ResponseState>(signInNotifierProvider,
        (ResponseState? previous, ResponseState next) async {
      if (next.isLoading!) {
        showProgress(context);
      } else if (next.isError!) {
        Navigator.pop(context);
        showMessage(context, next.errorMessage!);
      } else {
        Navigator.pop(context);
        showMessage(context, 'Signin sucessfully');
        markUserAslogged();
        Navigator.pushNamedAndRemoveUntil(
            context, dashboardScreen, (route) => false);
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
                  children: [
                    Image.asset(
                        width: 150, height: 150, "assets/images/logo.png")
                  ],
                ),
                const SizedBox(height: 30),
                const Row(
                  children: [
                    Text(
                      'Restro',
                      style: TextStyle(
                          color: FoodAppColors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'App',
                      style: TextStyle(
                          color: FoodAppColors.primaryRed,
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
                  validator: (value) => emailValidator(value),
                  isEmail: true,
                  textEditingController: emailController,
                  hintText: 'Enter Email address',
                  labelText: 'Email address',
                ),
                const SizedBox(height: 32),
                CommonTextField(
                  // validator: (value) => passwordValidator(value),
                  textEditingController: passwordController,
                  hintText: 'Enter Password',
                  labelText: 'Password',
                  isPassword: true,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        onButtonPressed(type: "FORGOT_PASSWORD");
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: FoodAppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                CommonButton(
                    labelText: 'Sign In',
                    onButtonPressed: () {
                      onButtonPressed(type: 'SIGN_IN');
                    }),
                const SizedBox(height: 30),
                CommonButton(
                  labelText: 'Sign Up',
                  hasBorder: true,
                  foregroundColor: FoodAppColors.primaryRed,
                  onButtonPressed: () {
                    onButtonPressed(type: 'SIGN_UP');
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
                        hasIconOnly: true,
                        icon: Image.asset(
                          'assets/icons/google.png',
                          width: 24,
                          height: 24,
                        ),
                        borderColor: FoodAppColors.grey.withOpacity(.20),
                        foregroundColor: FoodAppColors.black,
                        onButtonPressed: () {
                          onButtonPressed(type: "GOOGLE");
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CommonButton(
                        hasBorder: true,
                        hasIcon: true,
                        labelText: 'phone',
                        hasIconOnly: true,
                        icon: Image.asset(
                          'assets/icons/phone.png',
                          width: 24,
                          height: 24,
                        ),
                        borderColor: FoodAppColors.grey.withOpacity(.20),
                        foregroundColor: FoodAppColors.black,
                        onButtonPressed: () {
                          onButtonPressed(type: "PHONE");
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CommonButton(
                        labelText: 'Facebook',
                        hasBorder: true,
                        hasIcon: true,
                        hasIconOnly: true,
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
