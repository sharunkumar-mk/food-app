import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/modules/widgets/common_appbar.dart';
import 'package:food_app/modules/widgets/common_button.dart';
import 'package:food_app/modules/widgets/item/cart_item_card.dart';
import 'package:food_app/providers/provider.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends ConsumerState<CartPage> {
  late int? selectedIndex;
  @override
  void initState() {
    selectedIndex =
        ref.read(bottomNavigationNotifierProvider.notifier).selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartNotifierProvider);
    return Scaffold(
        appBar: CommonAppBar(
            title: 'My cart', hasLeading: selectedIndex == 3 ? false : true),
        body: cart.isEmpty
            ? const Center(child: Text('Cart empty'))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Dismissible(
                                onDismissed: (direction) {
                                  ref
                                      .read(cartNotifierProvider.notifier)
                                      .removeCartItem(cartItem: cart[index]);
                                },
                                direction: DismissDirection.endToStart,
                                secondaryBackground: Container(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              width: 1,
                                              color: FoodAppColors.primaryRed)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          "assets/icons/bin.png",
                                          color: FoodAppColors.primaryRed,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                background: Container(
                                  color: Colors.blue,
                                  alignment: Alignment.centerLeft,
                                  child: const Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                key: Key(cart[index].toString()),
                                child: CartItemCard(
                                  cartItem: cart[index],
                                  onChange: (value) {
                                    ref
                                        .read(cartNotifierProvider.notifier)
                                        .updateItemCount(
                                            cart[index].item.name!, value);
                                  },
                                )),
                          );
                        }),
                  ),
                ],
              ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
          child: cart.isEmpty
              ? const SizedBox.shrink()
              : CommonButton(
                  labelText: 'Checkout',
                  onButtonPressed: () {
                    Navigator.pushNamed(context, paymentMethodScreen);
                  },
                ),
        ));
  }

  // @override
  // Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
