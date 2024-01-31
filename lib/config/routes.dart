import 'package:flutter/material.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/models/otp_verification_model.dart';
import 'package:food_app/modules/pages/home.dart';
import 'package:food_app/modules/pages/location.dart';
import 'package:food_app/modules/pages/otp_verify.dart';
import 'package:food_app/modules/pages/password_reset.dart';
import 'package:food_app/modules/pages/phone_signin.dart';
import 'package:food_app/modules/pages/sign_in.dart';
import 'package:food_app/modules/pages/sign_up.dart';
import 'package:food_app/modules/pages/splash.dart';
import 'package:food_app/modules/pages/walk_through.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );

      case walkThroughScreen:
        return MaterialPageRoute(
          builder: (_) => const WalkThroughPage(),
        );

      case signInScreen:
        return MaterialPageRoute(
          builder: (_) => const SignInPage(),
        );

      case phoneSigninScreen:
        return MaterialPageRoute(
          builder: (_) => const PhoneSignInPage(),
        );

      case otpScreen:
        OtpModel otpModel = settings.arguments as OtpModel;

        return MaterialPageRoute(
          builder: (_) => OtpVerifyPage(
            otpModel: otpModel,
          ),
        );

      case signUpScreen:
        return MaterialPageRoute(
          builder: (_) => const SignUpPage(),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );

      case locationScreen:
        return MaterialPageRoute(
          builder: (_) => const LocationPage(),
        );

      case passwordResetScreen:
        return MaterialPageRoute(
          builder: (_) => const PasswordReset(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route found for the name $settings.name',
              ),
            ),
          ),
        );
    }
  }
}
