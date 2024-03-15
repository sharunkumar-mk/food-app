import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/models/item_model.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:food_app/utils/services/firebase/firebase_repository.dart';

class ItemNotifier extends StateNotifier<ResponseState> {
  ItemNotifier(this.firebaseRepository)
      : super(ResponseState(isLoading: true, isError: false));

  final FirebaseRepository firebaseRepository;
  ItemModel? itemModel;

  Future<void> getItemsDetails({bool init = true}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);
      }
      final result = await firebaseRepository.fetchItemDetails();
      itemModel = result;

      state =
          state.copyWith(isLoading: false, isError: false, response: result);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }
}
