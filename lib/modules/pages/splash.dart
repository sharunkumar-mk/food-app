import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/constants/shared_preference_path.dart';
import 'package:food_app/providers/provider.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends ConsumerState<SplashPage> {
  initCheckUp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final isUserNotFirstTime =
        preferences.getBool(SharedPreferencePath.isUserNotFirstTime);
    if (isUserNotFirstTime == true) {
      ref.read(signInNotifierProvider.notifier).checkUserSigned();
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, walkThroughScreen);
      });
    }
  }

  @override
  void initState() {
    initCheckUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ResponseState>(signInNotifierProvider,
        (ResponseState? previous, ResponseState next) {
      if (next.isLoading!) {
      } else if (next.isError!) {
        showMessage(context, next.errorMessage!);
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          if (next.response == true) {
            Navigator.pushReplacementNamed(context, dashboardScreen);
          } else {
            Navigator.pushReplacementNamed(context, signInScreen);
          }
        });
      }
    });
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          "assets/images/splashBG.png",
          fit: BoxFit.cover,
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
