import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmail(
      {required String email, required String password}) async {
    return await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<String> testFun() async {
    return "sucess";
  }
}
