import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/constants/api_constants.dart';
import 'package:food_app/providers/location_provider.dart';
import 'package:food_app/providers/provider.dart';
import 'package:food_app/providers/stream_provider.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class OrderTrackPage extends ConsumerStatefulWidget {
  const OrderTrackPage({super.key});

  @override
  OrderTrackPageState createState() => OrderTrackPageState();
}

class OrderTrackPageState extends ConsumerState<OrderTrackPage> {
  late GoogleMapController googleMapController;
  late Position position;
  LocationInfo? userLocationInfo;
  static const LatLng sourceLocation = LatLng(10.5369921, 76.2640595);
  static const LatLng destinationLocation = LatLng(10.562449, 76.3559012);

  LocationData? currentLocation;

  List<LatLng> polylineCoordinates = [];
  // StreamSubscription<LocationData>? locationSubscription;

  // void getCurrentLocation() async {
  //   try {
  //     Location location = Location();
  //     currentLocation = await location.getLocation();
  //     getPolylinePoints();
  //     locationSubscription = location.onLocationChanged.listen((newLoc) {
  //       setState(() {
  //         currentLocation = newLoc;
  //         print(currentLocation);
  //         googleMapController.animateCamera(
  //           CameraUpdate.newCameraPosition(
  //             CameraPosition(
  //                 zoom: 13.5,
  //                 target: LatLng(newLoc.latitude!, newLoc.longitude!)),
  //           ),
  //         );
  //         getPolylinePoints();
  //       });
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  getUserLocation() {
    userLocationInfo = ref.read(locationNotifierProvider.notifier).locationInfo;
    getPolylinePoints();
  }

  void getPolylinePoints() async {
    // if (userLocationInfo != null) {
    try {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleMapApi,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(
            destinationLocation.latitude, destinationLocation.longitude),
      );
      if (result.points.isNotEmpty) {
        setState(() {
          polylineCoordinates.clear();
          for (var point in result.points) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          }
        });
      }
    } catch (e) {
      print('ERROR ==>>>>$e');
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserLocation();
    });

    super.initState();
  }

  @override
  void dispose() {
    // locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(firebaseStreamProvider);

    // state.when(
    //   data: (docs) {
    //     boyLocationInfo =
    //         LatLng(docs['geoPoint'].latitude, docs['geoPoint'].longitude);
    //     getPolylinePoints();
    //     setState(() {});
    //   },
    //   error: (error, stackTrace) {
    //     // Handle error
    //     showLog('Error: $error');
    //   },
    //   loading: () {
    //     // Handle loading state
    //     showLog('Loading...');
    //   },
    // );

    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: userLocationInfo != null
                  ? GoogleMap(
                      onMapCreated: (controller) {
                        googleMapController = controller;
                      },
                      markers: {
                        const Marker(
                          markerId: MarkerId("Source"),
                          position: sourceLocation,
                          icon: BitmapDescriptor.defaultMarker,
                        ),
                        Marker(
                            markerId: const MarkerId('Boy Location'),
                            position: const LatLng(
                                10.554872467382213, 76.31773277312651),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueYellow)),
                        const Marker(
                          markerId: MarkerId('destination'),
                          position: destinationLocation,
                          icon: BitmapDescriptor.defaultMarker,
                        ),
                      },
                      initialCameraPosition: CameraPosition(
                          target: LatLng(userLocationInfo!.position!.latitude,
                              userLocationInfo!.position!.longitude),
                          zoom: 11),
                      polylines: {
                        Polyline(
                            polylineId: const PolylineId("route"),
                            points: polylineCoordinates,
                            color: Colors.blue,
                            width: 4),
                      },
                    )
                  : const Text('null value')),

          Expanded(
              child: state.when(data: (docs) {
            setState(() {});
            return Text(docs['id'].toString());
          }, error: (e, s) {
            return Text(e.toString());
          }, loading: () {
            return const Center(child: CircularProgressIndicator());
          }))
          // StreamBuilder(
          //     stream: state.r,
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState ==
          //           ConnectionState.waiting) {
          //         return const CircularProgressIndicator();
          //       } else if (snapshot.hasError) {
          //         return Text(snapshot.error.toString());
          //       } else {
          //         return const Text("data");
          //       }
          //     }))
        ],
      ),
    );
  }
}
