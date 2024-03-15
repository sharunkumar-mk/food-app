import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/models/cart_item_model.dart';
import 'package:food_app/providers/bottom_navigation_notifier.dart';
import 'package:food_app/providers/cart_notifier.dart';
import 'package:food_app/providers/delivery_boy_location_notifier.dart';
import 'package:food_app/providers/item_notifier.dart';
import 'package:food_app/providers/item_stream_provider.dart';
import 'package:food_app/providers/location_provider.dart';
import 'package:food_app/providers/order_notifier.dart';
import 'package:food_app/providers/restaurant_notifier.dart';
import 'package:food_app/providers/signin_notifier.dart';
import 'package:food_app/providers/signup_notifier.dart';
import 'package:food_app/providers/profile_notifier.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:food_app/utils/services/firebase/firebase_repository.dart';

// final firebaseServicesProvider = Provider<FirebaseServices>((ref) {
//   return FirebaseServices(FirebaseFirestore.instance);
// });

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseRespositoryProvider = Provider<FirebaseRepository>((ref) {
  return FirebaseRepository();
});

final locationNotifierProvider =
    StateNotifierProvider<LocationNotifier, ResponseState>(
        (ref) => LocationNotifier());

final signUpNotifierProvider =
    StateNotifierProvider.autoDispose<SignUpNotifier, ResponseState>((ref) =>
        SignUpNotifier(
            firebaseRepository: ref.watch(firebaseRespositoryProvider),
            firebaseAuth: ref.watch(firebaseAuthProvider)));

final signInNotifierProvider =
    StateNotifierProvider.autoDispose<SignInNotifier, ResponseState>(
        (ref) => SignInNotifier(firebaseAuth: ref.watch(firebaseAuthProvider)));

final profileNotifierProvider =
    StateNotifierProvider<ProfileNotifier, ResponseState>(
        (ref) => ProfileNotifier());

final itemNotifierProvider = StateNotifierProvider<ItemNotifier, ResponseState>(
    (ref) => ItemNotifier(ref.watch(firebaseRespositoryProvider)));

final orderNotifierProvider =
    StateNotifierProvider.autoDispose<OrderNotifier, ResponseState>(
        (ref) => OrderNotifier(ref.watch(firebaseRespositoryProvider)));

final restaurantNotifierProvider =
    StateNotifierProvider<RestaurantNotifier, ResponseState>(
        (ref) => RestaurantNotifier(ref.watch(firebaseRespositoryProvider)));

final deliveryBoyLocationNotifierProvider =
    StateNotifierProvider<DeliveryBoyLocationNotifier, ResponseState>((ref) =>
        DeliveryBoyLocationNotifier(ref.watch(firebaseRespositoryProvider)));

final itemStreamNotifier =
    StateNotifierProvider<ItemStreamNotifier, ResponseState>(
        (ref) => ItemStreamNotifier(ref.watch(firebaseRespositoryProvider)));

final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>(
        (ref) => CartNotifier());

final bottomNavigationNotifierProvider =
    StateNotifierProvider<BottonNavigationNotifier, int>(
        (ref) => BottonNavigationNotifier());
