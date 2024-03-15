// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/models/otp_verification_model.dart';
import 'package:food_app/modules/widgets/common_button.dart';
import 'package:food_app/providers/provider.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:pinput/pinput.dart';

class OtpVerifyPage extends ConsumerStatefulWidget {
  const OtpVerifyPage({super.key, required this.otpModel});
  final OtpModel otpModel;
  @override
  OtpVerifyPageState createState() => OtpVerifyPageState();
}

class OtpVerifyPageState extends ConsumerState<OtpVerifyPage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late String verificationID;
  late String phoneNumber;
  late String otpCode;
  bool isLoading = false;
  late Timer resendTimer;
  int remainingSeconds = 30;
  late Ticker ticker;

  void startResendTimer() {
    resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        remainingSeconds = 30 - timer.tick;
      });
      if (remainingSeconds <= 0) {
        timer.cancel();
        setState(() {
          remainingSeconds = 0;
        });
      }
    });
  }

  void resendOtp() {
    setState(() {
      remainingSeconds = 30;
    });
    startResendTimer();
  }

  onButtonPressed({required String type}) async {
    if (type == 'CONTINUE') {
      try {} finally {
        setState(() {
          isLoading = false;
        });
      }
    } else if (type == 'SIGN_UP') {
      Navigator.pushNamed(context, signUpScreen);
    } else if (type == 'FORGOT_PASSWORD') {
    } else if (type == 'GOOGLE') {
    } else if (type == 'FACEBOOK') {}
  }

  @override
  void initState() {
    super.initState();
    phoneNumber = widget.otpModel.phoneNumber!;
    verificationID = widget.otpModel.verificationId!;
    startResendTimer();
  }

  @override
  void dispose() {
    resendTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ResponseState>(signUpNotifierProvider,
        (ResponseState? previous, ResponseState next) {
      if (next.isLoading!) {
        showProgress(context);
      } else if (next.isError!) {
        Navigator.pop(context);
        showMessage(context, next.errorMessage!);
      } else {
        markUserAslogged();
        Navigator.pushNamedAndRemoveUntil(
            context, dashboardScreen, (routes) => false);
      }
    });
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [Image.asset("assets/images/logo.png")],
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    children: [
                      Text(
                        'Enter',
                        style: TextStyle(
                            color: FoodAppColors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 20),
                      Text(
                        'OTP',
                        style: TextStyle(
                            color: FoodAppColors.red,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'A verification codes has been sent\n to${widget.otpModel.phoneNumber}',
                        style: const TextStyle(
                          color: FoodAppColors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Pinput(
                    length: 6,
                    onCompleted: (value) {
                      setState(() {
                        otpCode = value;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't receive the code?",
                        style: TextStyle(
                          color: FoodAppColors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 10),
                      remainingSeconds > 0
                          ? Text(
                              "Resend($remainingSeconds)",
                              style: const TextStyle(
                                color: FoodAppColors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                resendOtp();
                              },
                              child: const Text(
                                "Resend",
                                style: TextStyle(
                                  color: FoodAppColors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CommonButton(
                    labelText: 'Continue',
                    onButtonPressed: () {
                      ref.read(signUpNotifierProvider.notifier).verifyOtp(
                          otpModel: OtpModel(
                              verificationId: verificationID, otp: otpCode));
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              )),
        ),
      ),
    );
  }
}
