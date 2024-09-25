import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/models/cart_item_model.dart';

final cartProviderTest = StateProvider<List<CartItem>>((ref) {
  return [];
});
