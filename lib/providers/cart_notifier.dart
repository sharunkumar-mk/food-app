import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/models/cart_item_model.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);
  List<CartItem> cartItemList = [];
  Future<void> addCartItem({required CartItem cartItem}) async {
    try {
      if (cartItemList.isEmpty ||
          cartItemList
              .every((element) => element.item.name != cartItem.item.name)) {
        cartItemList.add(cartItem);
      } else {
        final existingItem = cartItemList.firstWhere(
          (element) => element.item.name == cartItem.item.name,
          orElse: () => cartItem,
        );
        existingItem.itemCount += cartItem.itemCount;
      }
    } catch (e) {
      showLog(e.toString());
    }
  }

  Future<void> removeCartItem({required CartItem cartItem}) async {
    try {
      cartItemList
          .removeWhere((element) => element.item.name == cartItem.item.name);
    } catch (e) {
      showLog(e.toString());
    }
  }

  Future<void> updateItemCount(String itemName, int countChange) async {
    try {
      final itemIndex = cartItemList.indexWhere(
        (element) => element.item.name == itemName,
      );
      if (itemIndex != -1) {
        cartItemList[itemIndex].itemCount = countChange;
        if (cartItemList[itemIndex].itemCount <= 0) {
          cartItemList.removeAt(itemIndex);
        }
      }
    } catch (e) {
      showLog(e.toString());
    }
  }
}
