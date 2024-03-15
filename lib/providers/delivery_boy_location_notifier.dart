import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:food_app/utils/services/firebase/firebase_repository.dart';

class DeliveryBoyLocationNotifier extends StateNotifier<ResponseState> {
  DeliveryBoyLocationNotifier(this.firebaseRepository)
      : super(ResponseState(isLoading: true, isError: false));

  final FirebaseRepository firebaseRepository;

  Future<void> getDeliveryLocation(
      {bool init = true, required String id}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);
      }
      final result = firebaseRepository.fetchDeliveryBoyDetails(id: id);
      state =
          state.copyWith(isLoading: false, isError: false, response: result);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }
}

// final firebaseStreamProvider = StreamProvider<List<DocumentSnapshot>>((ref) {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final collection = firestore.collection('delivery');
//   return collection.snapshots().map((snapshot) => snapshot.docs);
// });

