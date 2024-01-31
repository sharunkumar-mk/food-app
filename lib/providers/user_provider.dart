import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/utils/response_state.dart';

final userNotifierProvider = StateNotifierProvider<UserNotifier, ResponseState>(
  (ref) => UserNotifier(ResponseState.initial()),
);

class UserNotifier extends StateNotifier<ResponseState> {
  UserNotifier(super.state);

  // Method to fetch Firebase data and update the state accordingly
  Future<void> fetchData({bool init = true}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);
      }
      final result = await fetchFirebaseData();
      state =
          state.copyWith(response: result, isLoading: false, isError: false);
    } catch (e) {
      state = state.copyWith(
          isError: true, errorMessage: e.toString(), isLoading: false);
    }
  }

  // Future<dynamic> fetchFirebaseData() async {
  //   // Replace this with actual Firebase data fetching logic
  //   await Future.delayed(const Duration(seconds: 2)); // Simulated delay
  //   return ['Data 1', 'Data 2', 'Data 3']; // Simulated data
  // }

  // Future<List<String>>
  Future<UserModel> fetchFirebaseData() async {
    try {
      // Replace 'your_collection' with the name of your Firestore collection
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('myCollections').get();

      // Mapping query snapshot to List<UserModel>
      List<UserModel> userList = querySnapshot.docs.map((doc) {
        // Replace with your UserModel instantiation logic based on doc data
        return UserModel(
          // Example assuming UserModel has fields 'name' and 'age'
          name: doc['name'] ?? '',
        );
      }).toList();
      return compute(userModelFromJson, userList);
    } catch (error) {
      // print('Error fetching data: $error');
      rethrow;
    }
  }
}
