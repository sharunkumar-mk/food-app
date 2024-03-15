import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/modules/widgets/common_button.dart';
import 'package:food_app/providers/provider.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends ConsumerStatefulWidget {
  const LocationPage({super.key});

  @override
  LocationPageState createState() => LocationPageState();
}

class LocationPageState extends ConsumerState<LocationPage> {
  Future<void> requestLocationPermisssion() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      showLog('permisstion denied');
    } else if (permission == LocationPermission.deniedForever) {
      showLog("permission denied for ever");
    } else {
      ref.read(locationNotifierProvider.notifier).getLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ResponseState>(locationNotifierProvider,
        (ResponseState? previous, ResponseState next) {
      if (next.isLoading!) {
        showDialog(
            context: context,
            builder: (context) {
              return const Center(child: CircularProgressIndicator());
            });
      } else if (next.isError!) {
        showMessage(context, next.errorMessage!);
      } else {
        showMessage(context, 'Location allowed');
        Navigator.pushReplacementNamed(context, homeScreen);
      }
    });
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/locationBG.png"),
        CommonButton(
            hasIcon: true,
            icon: Image.asset(
              "assets/icons/map.png",
              height: 24,
              width: 24,
              color: FoodAppColors.white,
            ),
            labelText: 'Use current location',
            onButtonPressed: () {
              requestLocationPermisssion();
            }),
      ],
    ));
  }
}
