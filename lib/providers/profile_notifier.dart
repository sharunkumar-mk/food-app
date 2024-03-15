import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';
import 'package:food_app/utils/response_state.dart';

class ProfileNotifier extends StateNotifier<ResponseState> {
  ProfileNotifier() : super(ResponseState(isLoading: true, isError: false));
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance.ref();
  User? user;
  File? profilePhoto;
  String? mobileNumber;
  String? email;
  Future<void> getProfileDetails({bool init = true}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);
        final result = firebaseAuth.currentUser!;
        user = result;
        state =
            state.copyWith(isLoading: false, isError: false, response: result);
      }
    } catch (e) {
      showLog("ERROR ====>>>>>>$e");
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }

  Future<void> updateProfileDetails(
      {bool init = true, required Map updateUser}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);
        profilePhoto = updateUser['photo'];
        mobileNumber = updateUser['mobile'];
        email = updateUser['email'];

        if (mobileNumber != '') {
          // PhoneAuthCredential phoneAuthCredential=  PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode),

          // firebaseAuth.currentUser!.updatePhoneNumber();
        }

        if (profilePhoto != null) {
          final folderRef = storage.child(firebaseAuth.currentUser!.uid);
          final profileImgRef = folderRef.child('profile_photo');
          await profileImgRef.putFile(profilePhoto!);
          final imageURL = await profileImgRef.getDownloadURL();
          await firebaseAuth.currentUser!.updatePhotoURL(imageURL);
        }
        await firebaseAuth.currentUser!.updateDisplayName(updateUser['name']);
        final result = firebaseAuth.currentUser!;
        user = result;
        state =
            state.copyWith(isLoading: false, isError: false, response: result);
      }
    } catch (e) {
      showLog("ERROR ====>>>>>>$e");
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }
}
