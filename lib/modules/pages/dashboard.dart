import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/modules/pages/order.dart';
import 'package:food_app/modules/pages/tabs/bag.dart';
import 'package:food_app/modules/pages/tabs/favourite.dart';
import 'package:food_app/modules/pages/tabs/home.dart';
import 'package:food_app/modules/pages/tabs/notification.dart';
import 'package:food_app/modules/pages/tabs/premium.dart';
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
    PremiumPage(),
    OrderPage(),
    NotificationPage()
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
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: widgetOptions,
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          BackdropFilter(filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5)),
          Container(
            decoration: BoxDecoration(
                color: FoodAppColors.white.withOpacity(.2),
                gradient:
                    const LinearGradient(colors: [Colors.black, Colors.white])),
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
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    state.selectedIndex = 0;
                                    tabController
                                        .animateTo(state.selectedIndex);
                                  });
                                },
                                icon: Image.asset(
                                  "assets/icons/home.png",
                                  width: 25,
                                  color: Colors.grey,
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    state.selectedIndex = 1;
                                    tabController
                                        .animateTo(state.selectedIndex);
                                  });
                                },
                                icon: Image.asset(
                                  "assets/icons/heart.png",
                                  width: 25,
                                  color: Colors.grey,
                                )),
                          ]),
                    ),
                    const SizedBox(
                      width: 45,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  state.selectedIndex = 3;
                                  tabController.animateTo(state.selectedIndex);
                                });
                              },
                              icon: Image.asset(
                                "assets/icons/bag.png",
                                width: 25,
                                color: Colors.grey,
                              )),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  state.selectedIndex = 4;
                                  tabController.animateTo(state.selectedIndex);
                                });
                              },
                              icon: Image.asset(
                                "assets/icons/notification.png",
                                width: 25,
                                color: Colors.grey,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: FoodAppColors.white),
              child: IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: Image.asset(
                    "assets/icons/premium.png",
                    width: 25,
                    color: FoodAppColors.red,
                  )),
            ),
          )
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
