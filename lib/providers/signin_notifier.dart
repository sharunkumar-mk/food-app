import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_app/constants/shared_preference_path.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInNotifier extends StateNotifier<ResponseState> {
  final FirebaseAuth firebaseAuth;

  SignInNotifier({required this.firebaseAuth})
      : super(ResponseState(isLoading: true, isError: false));
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  final GoogleSignIn googleSignIn = GoogleSignIn();

//check user sigend or not
  Future<void> checkUserSigned({bool init = true}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);
      }
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final result = preferences.getBool(SharedPreferencePath.isUserSigned);
      state =
          state.copyWith(isLoading: false, isError: false, response: result);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }

//Login with email and password
  Future<void> signInWithEmailAndPassword(
      {bool init = true,
      required String email,
      required String password}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);

        final user = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        state =
            state.copyWith(isLoading: false, isError: false, response: user);
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }

//send Password reset email
  Future<void> sendPasswordResetEmail(
      {bool init = true, required String email}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);
        await firebaseAuth.sendPasswordResetEmail(email: email);
        state =
            state.copyWith(isLoading: false, isError: false, response: true);
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }

  Future<void> signInWithGoogle({bool init = true}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);
        final GoogleSignInAccount? googleSignInAccount =
            await googleSignIn.signIn();
        if (googleSignInAccount != null) {
          final GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;
          final AuthCredential authCredential = GoogleAuthProvider.credential(
              accessToken: googleSignInAuthentication.accessToken,
              idToken: googleSignInAuthentication.idToken);
          final UserCredential userCredential =
              await firebaseAuth.signInWithCredential(authCredential);
          final user = userCredential.user;
          state =
              state.copyWith(isLoading: false, isError: false, response: user);
        }
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }

  Future<void> signInWithFacebook({bool init = true}) async {
    try {
      if (init) {
        // state = state.copyWith(isLoading: true, isError: false);
        final LoginResult loginResult = await FacebookAuth.instance.login();
        if (loginResult.status == LoginStatus.success) {
          final OAuthCredential facebookAuthCredential =
              FacebookAuthProvider.credential(
                  loginResult.accessToken!.tokenString);
          final user = await FirebaseAuth.instance
              .signInWithCredential(facebookAuthCredential);
          state =
              state.copyWith(isLoading: true, isError: false, response: user);
        }
      }
    } catch (e) {
      print(e);
    }
  }

// Future<void> verifyPasswordResetCode(
//     {bool init = true, required String code}) async {
//   try {
//     if (init) {
//       state = state.copyWith(isLoading: true, isError: false);
//       final result = await firebaseAuth.verifyPasswordResetCode(code);
//       state =
//           state.copyWith(isLoading: false, isError: false, response: result);
//     }
//   } catch (e) {
//     state = state.copyWith(
//         isLoading: false, isError: true, errorMessage: e.toString());
//   }
// }

// Future<void> confirmPasswordReset(
//     {bool init = true,
//     required String code,
//     required String newPassword}) async {
//   try {
//     if (init) {
//       state = state.copyWith(isLoading: true, isError: false);
//       await firebaseAuth.confirmPasswordReset(
//           code: code, newPassword: newPassword);
//       state = state.copyWith(isLoading: false, isError: false);
//     }
//   } catch (e) {
//     state = state.copyWith(
//         isLoading: false, isError: true, errorMessage: e.toString());
//   }
// }

  Future<void> userSignOut({bool init = true}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        final result =
            preferences.setBool(SharedPreferencePath.isUserSigned, false);
        state =
            state.copyWith(isLoading: false, isError: false, response: result);
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }
}
