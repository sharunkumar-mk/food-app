import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:food_app/constants/firebase_path.dart';
import 'package:food_app/models/delivery_boy_model.dart';
import 'package:food_app/models/item_model.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/models/restaurant_model.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/utils/services/firebase/firebase_api_services.dart';

class FirebaseRepository {
  FirebaseApiServices firebaseServices =
      FirebaseApiServices(FirebaseFirestore.instance);

  fetchCreateUser({required body, required id}) async {
    await firebaseServices.createDocument(
      collection: FirebasePath.userCollection,
      data: body,
      idKey: 'userId',
      id: id,
    );
  }

  Future<ItemModel> fetchUserDetails() async {
    var result = await firebaseServices.readCollection(
        collection: FirebasePath.userCollection, id: 'OcOCLm6f54VYi3TskHD9');
    return compute(menuItemModelFromjson, result);
  }

  Future<OrderModel> fetchPlaceOrder({required body, userID}) async {
    var result = await firebaseServices.createDocument(
        collection:
            '${FirebasePath.userCollection}/$userID${FirebasePath.ordersCollection}',
        data: body,
        idKey: 'orderId');
    return compute(orderModelFromjson, result);
  }

  Future<OrderModel> fetchOrderDetails(userID) async {
    var result = await firebaseServices.readCollection(
      collection:
          '${FirebasePath.userCollection}/$userID${FirebasePath.ordersCollection}',
    );
    return compute(orderModelFromjson, result);
  }

  Future<UserModel> getItems() async {
    var result = await firebaseServices.readCollection(
        collection: FirebasePath.userCollection);
    return compute(userModelFromJson, result);
  }

  Future<RestaurantModel> fetchRestaurantDetails() async {
    var result = await firebaseServices.readCollection(
        collection: FirebasePath.restaurantsCollection);

    return compute(restaurantModelFromJson, result);
  }

  Future<ItemModel> fetchItemDetails() async {
    var result = await firebaseServices.readCollection(
        collection: FirebasePath.menuCollection);
    return compute(menuItemModelFromjson, result);
  }

  Future<Stream<DeliveryBoy>> fetchDeliveryBoyDetails(
      {required String id}) async {
    final result = firebaseServices
        .streamService(
          id: id,
          collection: 'delivery_boys',
        )
        .map((snapshot) => deliveryBoyFormJson(snapshot.data()!));
    return result;
  }

  Stream<ItemModel> streamItemDetails() {
    final result = firebaseServices
        .streamService(
          id: "",
          collection: '/restaurants/QsJB3Sw3cI5oCiyEUz8J/menu',
        )
        .map((snapshot) => menuItemModelFromjson(snapshot.data()!));
    return result;
  }
}
