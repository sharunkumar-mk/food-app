import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/modules/widgets/common_button.dart';
import 'package:food_app/providers/location_provider.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends ConsumerStatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends ConsumerState<LocationPage> {
  late Position currentPosition;
  String currentAddress = '';

  Future<void> requestLocationPermisssion() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      print('permisstion denied');
    } else if (permission == LocationPermission.deniedForever) {
      print("permission denied for ever");
    } else {
      // getCurrentLocation();
      ref.read(locationProvider.notifier).getLocation();
      // ignore: use_build_context_synchronously
    }
  }

  // Future<void> getCurrentLocation() async {
  //   try {
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);

  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       position.latitude,
  //       position.longitude,
  //     );

  //     Placemark place = placemarks[0];
  //     setState(() {
  //       currentAddress = "${place.name}, ${place.locality}, ${place.country}";
  //       print(currentAddress);
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    ref.listen<ResponseState>(locationProvider,
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
        // Navigator.pop(context);
        showMessage(context, 'Location allowed');
        Navigator.pushReplacementNamed(context, homeScreen);

        // Navigator.pop(context);
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
              "assets/icons/location.png",
              height: 24,
              width: 24,
            ),
            labelText: 'Use current location',
            onButtonPressed: () {
              requestLocationPermisssion();
            }),
      ],
    ));
  }
}
