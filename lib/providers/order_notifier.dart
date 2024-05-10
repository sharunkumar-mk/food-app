import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:food_app/utils/services/firebase/firebase_repository.dart';

class OrderNotifier extends StateNotifier<ResponseState> {
  OrderNotifier(this.firebaseRepository)
      : super(ResponseState(isLoading: true, isError: false));

  final FirebaseRepository firebaseRepository;
  List<OrderItem> preOrders = [];
  List<OrderItem> upCommingOrders = [];
  OrderModel? orderModel;

  Future<void> placeOrder({bool init = true, order, required userid}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);
      }
      final result =
          await firebaseRepository.fetchPlaceOrder(body: order, userID: userid);

      state =
          state.copyWith(isLoading: false, isError: false, response: result);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }

  Future<void> getOrderDetails({bool init = true, required userid}) async {
    try {
      if (init) {
        state = state.copyWith(isLoading: true, isError: false);
      }
      final result = await firebaseRepository.fetchOrderDetails(userid);
      orderModel = result;
      for (var order in result.orders!) {
        if (order.status == 'pending') {
          upCommingOrders.addAll(order.items);
        } else {
          preOrders.addAll(order.items);
        }
      }

      state =
          state.copyWith(isLoading: false, isError: false, response: result);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }
}
