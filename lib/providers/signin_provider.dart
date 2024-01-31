import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/models/auth_model.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:google_sign_in/google_sign_in.dart';

final signInNotifierProvider =
    StateNotifierProvider<SignInNotifier, ResponseState>(
        (ref) => SignInNotifier());

class SignInNotifier extends StateNotifier<ResponseState> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  SignInNotifier() : super(ResponseState(isLoading: false, isError: false));

  Future<void> signInWithEmailAndPassword(
      {bool init = true, AuthModel? authModel}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);

        final user = await firebaseAuth.signInWithEmailAndPassword(
            email: authModel!.email!, password: authModel.password!);
        state =
            state.copyWith(isLoading: false, isError: false, response: user);
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }

  Future<void> sendPasswordResetEmail(
      {bool init = true, required String email}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);
        await firebaseAuth.sendPasswordResetEmail(email: email);
        state = state.copyWith(isLoading: false, isError: false);
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }

  Future<void> signInWithGoogle({bool init = true}) async {
    const List<String> scopes = <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ];

    final GoogleSignIn googleSignIn = GoogleSignIn(
      // Optional clientId
      clientId: 'your-client_id.apps.googleusercontent.com',
      scopes: scopes,
    );

    try {
      if (init) {
        // final GoogleSignInAccount? googleSignInAccount =
        //     await googleSignIn.signIn();

        // if (googleSignInAccount == null) return;

        // final GoogleSignInAuthentication googleSignInAuthentication =
        //     await googleSignInAccount.authentication;

        // final AuthCredential authCredential = GoogleAuthProvider.credential(
        //     accessToken: googleSignInAuthentication.accessToken,
        //     idToken: googleSignInAuthentication.idToken);

        // final UserCredential userCredential =
        //     await firebaseAuth.signInWithCredential(authCredential);
        // final user = userCredential.user;
        // state =
        //     state.copyWith(isLoading: false, isError: false, response: user);
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
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
