import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

final locationProvider = StateNotifierProvider<LocationNotifier, ResponseState>(
    (ref) => LocationNotifier());

class LocationInfo {
  final Position? position;
  final Placemark? place;
  LocationInfo({this.position, this.place});
}

class LocationNotifier extends StateNotifier<ResponseState> {
  LocationNotifier() : super(ResponseState(isLoading: false, isError: false));

  Future<void> getLocation({bool init = true}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        Placemark place = placemarks[0];
        final response = LocationInfo(position: position, place: place);
        state = state.copyWith(
            isLoading: false, isError: false, response: response);
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }
}
