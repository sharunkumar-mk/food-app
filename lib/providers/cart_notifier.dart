import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/models/cart_item_model.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);
  List<CartItem> cartItemList = [];
  addCartItem({required CartItem cartItem}) {
    try {
      if (cartItemList.isEmpty ||
          cartItemList
              .every((element) => element.item.name != cartItem.item.name)) {
        cartItemList.add(cartItem);
        state = cartItemList;
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

  removeCartItem({required CartItem cartItem}) {
    try {
      cartItemList
          .removeWhere((element) => element.item.name == cartItem.item.name);
      state = cartItemList;
    } catch (e) {
      showLog(e.toString());
    }
  }

  updateItemCount(String itemName, int countChange) {
    try {
      final itemIndex = cartItemList.indexWhere(
        (element) => element.item.name == itemName,
      );
      if (itemIndex != -1) {
        cartItemList[itemIndex].itemCount = countChange;
        state = cartItemList;
        if (cartItemList[itemIndex].itemCount <= 0) {
          cartItemList.removeAt(itemIndex);
          state = cartItemList;
        }
      }
    } catch (e) {
      showLog(e.toString());
    }
  }
}
