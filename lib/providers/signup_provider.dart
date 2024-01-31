import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/models/auth_model.dart';
import 'package:food_app/models/otp_verification_model.dart';
import 'package:food_app/utils/response_state.dart';

final signUpProvider = StateNotifierProvider<SignUpNotifier, ResponseState>(
    (ref) => SignUpNotifier());

class SignUpNotifier extends StateNotifier<ResponseState> {
  SignUpNotifier() : super(ResponseState(isLoading: false, isError: false));
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> signUpWithEmail({bool init = true, AuthModel? authModel}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);
        final result = await firebaseAuth.createUserWithEmailAndPassword(
            email: authModel!.email!, password: authModel.password!);
        state =
            state.copyWith(isLoading: false, isError: false, response: result);
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }

  Future<void> verifyPhoneNumber(
      {bool init = true, required AuthModel authModel}) async {
    try {
      if (init) {
        state.copyWith(isLoading: true, isError: false);
      }

      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: authModel.phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await firebaseAuth.signInWithCredential(credential);
            state = state.copyWith(isLoading: false, isError: false);
          },
          verificationFailed: (FirebaseAuthException e) {
            state = state.copyWith(
                isLoading: false, isError: true, errorMessage: e.toString());
          },
          codeSent: (String verificationId, int? resendToken) {
            state = state.copyWith(
                isLoading: false, isError: false, response: verificationId);
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }

  Future<void> verifyOtp({bool init = true, required OtpModel otpModel}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);
      }
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: otpModel.verificationId!, smsCode: otpModel.otp!);
      await firebaseAuth.signInWithCredential(credential);
      state = state.copyWith(isLoading: false, isError: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }
}
