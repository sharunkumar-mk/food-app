import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:food_app/utils/services/firebase/firebase_repository.dart';

class ItemStreamNotifier extends StateNotifier<ResponseState> {
  ItemStreamNotifier(this.firebaseRepository)
      : super(ResponseState(isLoading: true, isError: false));
  final FirebaseRepository firebaseRepository;

  Future<void> getStreamItemDetails({bool init = true}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);
        final result = firebaseRepository.streamItemDetails();
        showLog(result.first.toString());
        state =
            state.copyWith(isLoading: false, isError: false, response: result);
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }

  // Future<void> getSingleUser({bool init = true, required String id}) async {
  //   try {
  //     if (init) {
  //       state = state.copyWith(isLoading: true, isError: false);
  //     }
  //     final result = await firebaseRepository.fetchSingleUserDetails(id);

  //     print(result);
  //     state =
  //         state.copyWith(isLoading: false, isError: false, response: result);
  //   } catch (e) {
  //     state = state.copyWith(
  //         isLoading: false, isError: true, errorMessage: e.toString());
  //   }
  // }
}
