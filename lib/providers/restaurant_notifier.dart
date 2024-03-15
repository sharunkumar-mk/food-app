import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/models/restaurant_model.dart';

import 'package:food_app/utils/response_state.dart';
import 'package:food_app/utils/services/firebase/firebase_repository.dart';

class RestaurantNotifier extends StateNotifier<ResponseState> {
  RestaurantNotifier(this.firebaseRepository)
      : super(ResponseState(isLoading: true, isError: false));

  final FirebaseRepository firebaseRepository;

  List<Restaurant> restaurants = [];

  Future<void> getRestaurantDetails({bool init = true, id}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);
      }
      final result = await firebaseRepository.fetchRestaurantDetails();

      restaurants = result.restaurants!;

      state =
          state.copyWith(isLoading: false, isError: false, response: result);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }
}
