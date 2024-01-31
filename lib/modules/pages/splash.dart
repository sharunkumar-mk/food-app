import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/constants/secure_storage_path.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    initCheckUp();

    // isFirstTime(context);
    super.initState();
  }

  initCheckUp() async {
    final firstTime = await isFirstTime();
    final userSigned = await isUserSigned();
    await Future.delayed(const Duration(seconds: 1));
    if (!firstTime) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, walkThroughScreen);
    } else if (userSigned) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, signInScreen);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, signInScreen);
    }
  }

  Future<bool> isFirstTime() async {
    final isFirstTime =
        await secureStorage.read(key: SecureStoragePath.firstTime);
    return isFirstTime != null && isFirstTime == 'false';
  }

  Future<bool> isUserSigned() async {
    final isUserSigned =
        await secureStorage.read(key: SecureStoragePath.isUserSigned);
    return isUserSigned != null && isUserSigned == 'true';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          "assets/images/splashBG.png",
          fit: BoxFit.fill,
        ),
        Center(
          child: Image.asset(
            "assets/images/logo.png",
            width: 150,
            height: 150,
          ),
        ),
      ],
    ));
  }
}
