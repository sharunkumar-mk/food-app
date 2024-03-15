import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:food_app/utils/services/firebase/firebase_repository.dart';

class ItemNotifier extends StateNotifier<ResponseState> {
  ItemNotifier(this.firebaseRepository)
      : super(ResponseState(isLoading: true, isError: false));

  final FirebaseRepository firebaseRepository;

  Future<void> getItems({bool init = true}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);
      }
      final result = await firebaseRepository.getItems();
      state =
          state.copyWith(isLoading: false, isError: false, response: result);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }
}
