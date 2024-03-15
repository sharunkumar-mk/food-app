import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/models/cart_item_model.dart';
import 'package:food_app/modules/widgets/common_appbar.dart';
import 'package:food_app/modules/widgets/common_button.dart';
import 'package:food_app/modules/widgets/common_textbutton.dart';
import 'package:food_app/providers/location_provider.dart';
import 'package:food_app/providers/provider.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';
import 'package:food_app/utils/response_state.dart';
import 'package:gap/gap.dart';

class PaymentMethod extends ConsumerStatefulWidget {
  const PaymentMethod({super.key});

  @override
  PaymentMethodState createState() => PaymentMethodState();
}

class PaymentMethodState extends ConsumerState<PaymentMethod> {
  String? selectedValue;
  List<CartItem> cartItemList = [];
  List<Map<String, dynamic>> orderList = [];
  late LocationInfo locationInfo;
  FirebaseAuth auth = FirebaseAuth.instance;

  onButtonPressed(context) {
    ref
        .read(orderNotifierProvider.notifier)
        .placeOrder(userid: auth.currentUser!.uid, order: {
      "userId": auth.currentUser!.uid,
      "deliveryAddress": "address",
      "totalPrice": 100,
      "restaurantId": "011",
      "timestamp": Timestamp.now(),
      "items": orderList,
      "status": "pending",
      "location": GeoPoint(
          locationInfo.position!.latitude, locationInfo.position!.longitude)
    });
  }

  @override
  void initState() {
    cartItemList = ref.read(cartNotifierProvider.notifier).cartItemList;
    locationInfo = ref.read(locationNotifierProvider.notifier).locationInfo!;
    addItemCartItem();
    super.initState();
  }

  addItemCartItem() {
    for (var itemModel in cartItemList) {
      orderList.add({
        "itemId": itemModel.item.itemId,
        "itemName": itemModel.item.name,
        "itemImage": itemModel.item.imageUrl,
        "itemPrice": itemModel.item.price,
        "quantity": itemModel.itemCount,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ResponseState>(orderNotifierProvider,
        (ResponseState? previous, ResponseState next) {
      if (next.isLoading!) {
        showProgress(context);
      } else if (next.isError!) {
        Navigator.pop(context);
        showMessage(context, next.errorMessage!);
      } else {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: Container(
                      height: 350,
                      decoration: BoxDecoration(
                          color: FoodAppColors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset("assets/icons/checkmark.png"),
                          const Text(
                            "Order Place Successfully",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                                "You Placed the order successfully. you will get order within 45 minutes.Enjoy your food.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: FoodAppColors.grey)),
                          ),
                          CommonTextButton(
                            onButtonPressed: () {},
                            labelText: 'Keep Browsing',
                          )
                        ],
                      )));
            });
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CommonAppBar(title: 'Payment Method'),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: FoodAppColors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        RadioListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          title: const Text("Debit/Credit card"),
                          value: "Option 1",
                          groupValue: selectedValue,
                          onChanged: (v) {
                            setState(() {
                              selectedValue = v;
                            });
                          },
                        ),
                        SizedBox(
                          height: 400,
                          child: ListView.builder(
                              clipBehavior: Clip.none,
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: FoodAppColors.red.withOpacity(.5),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    width: 300,
                                  ),
                                );
                              }),
                        ),
                        const Gap(10),
                        TextButton.icon(
                            style: const ButtonStyle(
                                splashFactory: NoSplash.splashFactory,
                                foregroundColor: MaterialStatePropertyAll(
                                    FoodAppColors.red)),
                            onPressed: () {},
                            icon: const Icon(Icons.add),
                            label: const Text('Add new card'))
                      ],
                    ),
                  ),
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: FoodAppColors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: RadioListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: const Text("Cash on Delivery"),
                      value: "Option 2",
                      groupValue: selectedValue,
                      onChanged: (v) {
                        setState(() {
                          selectedValue = v;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
        child: CommonButton(
          onButtonPressed: () {
            onButtonPressed(context);
          },
          labelText: 'Confirm Order',
        ),
      ),
    );
  }
}
