import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/modules/pages/order.dart';
import 'package:food_app/modules/pages/tabs/cart.dart';
import 'package:food_app/modules/pages/tabs/favourite.dart';
import 'package:food_app/modules/pages/tabs/home.dart';
import 'package:food_app/modules/pages/tabs/notification.dart';

import 'package:food_app/providers/provider.dart';
import 'package:geolocator/geolocator.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends ConsumerState<DashboardPage>
    with SingleTickerProviderStateMixin {
  static const List<Widget> widgetOptions = <Widget>[
    HomePage(),
    FavouritePage(),
    OrderPage(),
    CartPage(),
    NotificationPage()
  ];

  List<String> bottomMenuIcons = [
    "home.png",
    "heart.png",
    "bag.png",
    "cart.png",
    "notification.png"
  ];

  late final tabController =
      TabController(length: widgetOptions.length, vsync: this);

  @override
  void initState() {
    requestLocationPermisssion();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileNotifierProvider.notifier).getProfileDetails();
      ref.read(restaurantNotifierProvider.notifier).getRestaurantDetails();
      ref.read(itemNotifierProvider.notifier).getItemsDetails();
      ref
          .read(bottomNavigationNotifierProvider.notifier)
          .updateSelectedIndex(3);
      // tabController.animateTo(
      //     ref.read(bottomNavigationNotifierProvider.notifier).selectedIndex);
    });
    super.initState();
  }

  Future<void> requestLocationPermisssion() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Geolocator.openLocationSettings();
    } else if (permission == LocationPermission.deniedForever) {
      Geolocator.openLocationSettings();
    } else {
      ref.read(locationNotifierProvider.notifier).getLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bottomNavigationNotifierProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Builder(builder: (context) {
          return TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: widgetOptions,
          );
        }),
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          BackdropFilter(filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5)),
          Container(
            decoration: const BoxDecoration(
              color: FoodAppColors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (var icon in bottomMenuIcons)
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      state.selectedIndex =
                                          bottomMenuIcons.indexOf(icon);
                                      tabController
                                          .animateTo(state.selectedIndex);
                                    });
                                  },
                                  icon: Image.asset(
                                    "assets/icons/$icon",
                                    width: 25,
                                    color: state.selectedIndex ==
                                            bottomMenuIcons.indexOf(icon)
                                        ? FoodAppColors.primaryRed
                                        : FoodAppColors.grey,
                                  )),
                          ]),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavItems {
  final String active;
  final String inActive;
  NavItems({required this.active, required this.inActive});
}
