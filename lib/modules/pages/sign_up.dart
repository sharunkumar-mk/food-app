import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/modules/widgets/common_button.dart';
import 'package:food_app/modules/widgets/common_textbutton.dart';
import 'package:food_app/modules/widgets/common_textfield.dart';
import 'package:food_app/providers/provider.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends ConsumerState<SignUpPage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  late String verificationID;

  Future<void> verifyPhoneNumber() async {
    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+917907784710',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          showLog(e.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            verificationID = verificationId;

            showLog(verificationID);
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            verificationID = verificationId;
          });
        });
  }

  Future<void> signInWithPhoneNumber(String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: smsCode);
      await firebaseAuth.signInWithCredential(credential);
      showLog('verified');
    } catch (e) {
      showLog(e.toString());
    }
  }

  onButtonPressed({required String type}) async {
    if (type == 'SIGN_IN') {
      // verifyPhoneNumber;
      // Navigator.pushNamed(context, signInScreen);
    } else if (type == 'SIGN_UP') {
      if (formKey.currentState!.validate()) {
        ref.read(signUpNotifierProvider.notifier).signUpWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      }

      showDialog(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 200,
            child: AlertDialog(
              backgroundColor: FoodAppColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 200,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Sign In with phone number',
                        style: TextStyle(
                          fontSize: 16,
                          color: FoodAppColors.grey,
                        ),
                      ),
                      Text(
                        "(+91) 65485 8XX98",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: FoodAppColors.black,
                        ),
                      ),
                      Text(
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
                          onButtonPressed: () {},
                          labelText: 'cancel',
                        ),
                      ),
                    ),
                    Expanded(
                      child: CommonButton(
                        onButtonPressed: () {},
                        labelText: 'Next',
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    } else if (type == 'FORGOT_PASSWORD') {
    } else if (type == 'GOOGLE') {
    } else if (type == 'FACEBOOK') {}
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ResponseState>(signUpNotifierProvider,
        (ResponseState? previous, ResponseState next) {
      if (next.isLoading!) {
        showProgress(context);
      } else if (next.isError!) {
        showMessage(context, next.errorMessage!);
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        showMessage(context, 'User created');
        Navigator.pushReplacementNamed(context, signInScreen);
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
                    validator: (email) => emailValidator(email),
                    textEditingController: emailController,
                    hintText: 'Enter Email Address',
                    labelText: 'Email Address',
                    isEmail: true,
                  ),
                  const SizedBox(height: 32),
                  CommonTextField(
                    validator: (password) => passwordValidator(password),
                    textEditingController: passwordController,
                    hintText: 'Enter Password',
                    labelText: 'Password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 32),
                  CommonTextField(
                    validator: (value) {
                      if (passwordController.text !=
                          rePasswordController.text) {
                        return 'Password dont match';
                      }
                      return null;
                    },
                    textEditingController: rePasswordController,
                    hintText: 'Re-Enter Password',
                    labelText: 'Re-Enter Password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 32),
                  isLoading
                      ? const CircularProgressIndicator()
                      : CommonButton(
                          labelText: 'Sign Up',
                          onButtonPressed: () {
                            onButtonPressed(type: 'SIGN_UP');
                          }),
                  const SizedBox(height: 30),
                  CommonButton(
                      hasBorder: true,
                      foregroundColor: FoodAppColors.primaryRed,
                      labelText: 'Sign In',
                      onButtonPressed: () {
                        signInWithPhoneNumber('286425');
                        // onButtonPressed(type: 'SIGN_IN');
                      }),
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
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
