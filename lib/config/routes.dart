import 'package:flutter/material.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/models/item_model.dart';
import 'package:food_app/models/otp_verification_model.dart';
import 'package:food_app/modules/pages/dashboard.dart';
import 'package:food_app/modules/pages/item_details.dart';
import 'package:food_app/modules/pages/menus/address.dart';
import 'package:food_app/modules/pages/menus/card.dart';
import 'package:food_app/modules/pages/menus/contact.dart';
import 'package:food_app/modules/pages/menus/gift.dart';
import 'package:food_app/modules/pages/menus/profile.dart';
import 'package:food_app/modules/pages/menus/settings.dart';
import 'package:food_app/modules/pages/order.dart';
import 'package:food_app/modules/pages/payment_method.dart';
import 'package:food_app/modules/pages/search.dart';
import 'package:food_app/modules/pages/tabs/cart.dart';
import 'package:food_app/modules/pages/tabs/home.dart';
import 'package:food_app/modules/pages/location.dart';
import 'package:food_app/modules/pages/otp_verify.dart';
import 'package:food_app/modules/pages/password_reset.dart';
import 'package:food_app/modules/pages/phone_signin.dart';
import 'package:food_app/modules/pages/sign_in.dart';
import 'package:food_app/modules/pages/sign_up.dart';
import 'package:food_app/modules/pages/splash.dart';
import 'package:food_app/modules/pages/tabs/notification.dart';
import 'package:food_app/modules/pages/track_order.dart';
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
      case dashboardScreen:
        return MaterialPageRoute(
          builder: (_) => const DashboardPage(),
        );

      case locationScreen:
        return MaterialPageRoute(
          builder: (_) => const LocationPage(),
        );

      case passwordResetScreen:
        return MaterialPageRoute(
          builder: (_) => const PasswordReset(),
        );

      case profileScreen:
        return MaterialPageRoute(
          builder: (_) => const ProfilePage(),
        );
      case addressScreen:
        return MaterialPageRoute(
          builder: (_) => const AddressPage(),
        );

      case cardScreen:
        return MaterialPageRoute(
          builder: (_) => const CardPage(),
        );

      case giftScreen:
        return MaterialPageRoute(
          builder: (_) => const GiftPage(),
        );
      case settingsScreen:
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
        );
      case contactScreen:
        return MaterialPageRoute(
          builder: (_) => const ContactPage(),
        );

      case itemDetailsScreen:
        Item item = settings.arguments as Item;
        return MaterialPageRoute(
          builder: (_) => ItemDetailsPage(item: item),
        );
      case cartScreen:
        return MaterialPageRoute(
          builder: (_) => const CartPage(),
        );
      case paymentMethodScreen:
        return MaterialPageRoute(
          builder: (_) => const PaymentMethod(),
        );

      case ordersScreen:
        return MaterialPageRoute(
          builder: (_) => const OrderPage(),
        );

      case orderTrackScreen:
        return MaterialPageRoute(
          builder: (_) => const OrderTrackPage(),
        );

      case notificationScreen:
        return MaterialPageRoute(
          builder: (_) => const NotificationPage(),
        );
      case searchScreen:
        return MaterialPageRoute(
          builder: (_) => const SearchPage(),
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
