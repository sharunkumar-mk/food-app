import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/modules/widgets/common_appbar.dart';
import 'package:food_app/modules/widgets/common_bottom_sheet.dart';
import 'package:food_app/modules/widgets/common_button.dart';
import 'package:food_app/modules/widgets/common_textfield.dart';
import 'package:food_app/providers/provider.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends ConsumerState<ProfilePage> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController mobileEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  ImageProvider imageVariable = const AssetImage("assets/images/man.png");

  late String imageURL;
  bool buttonActive = false;
  File? file;
  File? profilePhoto;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  String? oldMobileNumber;

  @override
  void initState() {
    imageURL = ref.read(profileNotifierProvider.notifier).user!.photoURL ?? '';
    nameEditingController.text =
        ref.read(profileNotifierProvider.notifier).user!.displayName ?? '';
    emailEditingController.text =
        ref.read(profileNotifierProvider.notifier).user!.email ?? '';
    mobileEditingController.text =
        ref.read(profileNotifierProvider.notifier).user!.phoneNumber ?? '';
    oldMobileNumber = mobileEditingController.text.trim();
    super.initState();
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    emailEditingController.dispose();
    mobileEditingController.dispose();
    super.dispose();
  }

  onButtonPressed({required String type, BuildContext? context}) async {
    if (type == 'UPDATE_PROFILE') {
      if (file != null) {
        final compressedImage = await FlutterImageCompress.compressWithFile(
          file!.path,
          minWidth: 100,
          minHeight: 100,
          quality: 100,
        );
        profilePhoto = await file!.writeAsBytes(compressedImage!);
      }

      if (oldMobileNumber != mobileEditingController.text.trim()) {
        await phoneNumberVerify();
        if (!context!.mounted) return;
        Navigator.pushNamed(context, otpScreen);
        // ref.read(signUpNotifierProvider.notifier).verifyPhoneNumber(
        //     phoneNumber: mobileEditingController.text.trim());
      }

      // if (formKey.currentState!.validate()) {
      //   await ref
      //       .read(profileNotifierProvider.notifier)
      //       .updateProfileDetails(updateUser: {
      //     'name': nameEditingController.text.trim(),
      //     'photo': profilePhoto,
      //     'mobile': mobileEditingController.text.trim(),
      //     'email': emailEditingController.text.trim(),
      //   });
      // }
    } else if (type == 'SELECT_IMAGE') {
      showImageChooseBottomSheet();
    }
  }

  Future<void> phoneNumberVerify() async {
    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: mobileEditingController.text.trim(),
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  showImageChooseBottomSheet() {
    CommonBottomSheet commonBottomSheet = CommonBottomSheet(
        childWidget: SelectImage(
          onImageChanged: (profilePhoto) {
            setState(() {
              Navigator.pop(context);
              file = File(profilePhoto.path);
              imageVariable = FileImage(File(profilePhoto.path));
              buttonActive = true;
            });
          },
        ),
        context: context,
        title: 'SELECT IMAGE');
    commonBottomSheet.show();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ResponseState>(profileNotifierProvider,
        (ResponseState? previous, ResponseState next) {
      if (next.isLoading!) {
        showProgress(context);
      } else if (next.isError!) {
        showLog(next.errorMessage!);
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        showMessage(context, 'profile Updated');
        Navigator.pop(context);
      }
    });

    ref.listen<ResponseState>(signUpNotifierProvider,
        (ResponseState? previous, ResponseState next) {
      if (next.isLoading!) {
        showProgress(context);
      } else if (next.isError!) {
        showLog(next.errorMessage!);
        Navigator.pop(context);
      } else {
        Navigator.pushNamed(context, otpScreen);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CommonAppBar(
              hasTrailing: false,
              title: 'Edit Profile',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: file != null
                          ? Image(
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                              image: imageVariable,
                            )
                          : CachedNetworkImage(
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              imageUrl: imageURL,
                              errorListener: (value) {
                                showLog(value.toString());
                              },
                              placeholder: (context, url) =>
                                  const CupertinoActivityIndicator(radius: 10),
                              errorWidget: (context, url, error) => Image(
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  image: imageVariable),
                            ),
                    ),
                    Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: GestureDetector(
                            onTap: () {
                              onButtonPressed(
                                  type: 'SELECT_IMAGE', context: context);
                            },
                            child: Image.asset(
                              "assets/icons/camera.png",
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            const Gap(40),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CommonTextField(
                          onChanged: (p0) {
                            setState(() {
                              buttonActive = true;
                            });
                          },
                          labelText: 'Name',
                          hintText: 'Name',
                          textEditingController: nameEditingController),
                      const Gap(20),
                      CommonTextField(
                          onChanged: (value) {
                            setState(() {
                              buttonActive = true;
                            });
                          },
                          labelText: 'Mobile Number',
                          hintText: 'Mobile Number',
                          textEditingController: mobileEditingController),
                      const Gap(20),
                      CommonTextField(
                          validator: (value) => emailValidator(value),
                          onChanged: (value) {
                            setState(() {
                              buttonActive = true;
                            });
                          },
                          labelText: 'Email Address',
                          hintText: 'Email Address',
                          textEditingController: emailEditingController),
                      const Gap(30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Expanded(
              child: CommonButton(
                backgroundColor: FoodAppColors.white,
                foregroundColor: FoodAppColors.black,
                labelText: 'Cancel',
                onButtonPressed: () {},
              ),
            ),
            const Gap(20),
            Expanded(
                child: CommonButton(
                    isActive: buttonActive,
                    labelText: 'Update',
                    onButtonPressed: () {
                      onButtonPressed(type: 'UPDATE_PROFILE');
                    }))
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class SelectImage extends StatelessWidget {
  final Function(XFile)? onImageChanged;
  const SelectImage({super.key, this.onImageChanged});

  onButtonPressed({required source}) async {
    XFile? image = await ImagePicker().pickImage(source: source);
    onImageChanged!(image!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100, top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CommonButton(
                  onButtonPressed: () {
                    onButtonPressed(source: ImageSource.camera);
                  },
                  hasIcon: true,
                  icon: const Row(
                    children: [Icon(Icons.camera), Text(' Camera')],
                  )),
              CommonButton(
                  onButtonPressed: () {
                    onButtonPressed(source: ImageSource.gallery);
                  },
                  hasIcon: true,
                  icon: const Row(
                    children: [Icon(Icons.photo_sharp), Text(' Gallery')],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
