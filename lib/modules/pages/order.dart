import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/constants/route_path.dart';

import 'package:food_app/modules/widgets/common_tabbar.dart';
import 'package:food_app/modules/widgets/order_item_card.dart';
import 'package:food_app/providers/provider.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';

class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({super.key});

  @override
  OrderPageState createState() => OrderPageState();
}

class OrderPageState extends ConsumerState<OrderPage> {
  List<Widget> widgets = [const PreOrders(), const UpcomingOrders()];
  List<String> widgetLabels = ['Pre-Orders', 'Upcoming'];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(orderNotifierProvider.notifier)
          .getOrderDetails(userid: FirebaseAuth.instance.currentUser!.uid);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:
              CommonTabBar(widgetOptions: widgets, widgetLabels: widgetLabels)),
    );
  }
}

class PreOrders extends StatelessWidget {
  const PreOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final orderList = ref.read(orderNotifierProvider.notifier).preOrders;
        final state = ref.watch(orderNotifierProvider);
        return state.isLoading!
            ? const Center(child: CupertinoActivityIndicator())
            : state.isError!
                ? Text(state.errorMessage.toString())
                : orderList.isEmpty
                    ? const Center(child: Text('Empty order'))
                    : ListView.builder(
                        itemCount: orderList.length,
                        itemBuilder: (context, index) {
                          return OrderItemCard(
                              onFirstButtonPressed: () {
                                showLog('object');
                              },
                              onSecondfButtonPressed: () {
                                showLog('object2');
                              },
                              price: orderList[index].itemPrice,
                              image: orderList[index].itemImage,
                              name: orderList[index].itemName);
                        });
      },
    );
  }
}

class UpcomingOrders extends StatelessWidget {
  const UpcomingOrders({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final orderList =
            ref.read(orderNotifierProvider.notifier).upCommingOrders;
        final state = ref.watch(orderNotifierProvider);
        return state.isLoading!
            ? const Center(child: CupertinoActivityIndicator())
            : state.isError!
                ? Text(state.errorMessage.toString())
                : orderList.isEmpty
                    ? const Center(child: Text('No pending orders'))
                    : ListView.builder(
                        itemCount: orderList.length,
                        itemBuilder: (context, index) {
                          return OrderItemCard(
                              onFirstButtonPressed: () {},
                              onSecondfButtonPressed: () {
                                Navigator.pushNamed(context, orderTrackScreen);
                              },
                              upComming: true,
                              price: orderList[index].itemPrice,
                              image: orderList[index].itemImage,
                              name: orderList[index].itemName);
                        });
      },
    );
  }
}
