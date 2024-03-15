import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/models/item_model.dart';
import 'package:food_app/modules/pages/home_tabs.dart';
import 'package:food_app/modules/widgets/common_button.dart';
import 'package:food_app/modules/widgets/common_header.dart';
import 'package:food_app/modules/widgets/common_search.dart';
import 'package:food_app/modules/widgets/item/item_card_grid.dart';
import 'package:food_app/modules/widgets/common_drawer.dart';
import 'package:food_app/modules/widgets/common_gift_card.dart';
import 'package:food_app/modules/widgets/common_tabbar.dart';
import 'package:food_app/modules/widgets/common_section_header.dart';
import 'package:food_app/providers/provider.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';
import 'package:food_app/utils/response_state.dart';

import 'package:gap/gap.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  List<MenuItems> menuItems = [
    MenuItems(
        image: 'assets/icons/user.png',
        name: 'Profile',
        destination: profileScreen),
    MenuItems(
        image: 'assets/icons/map.png',
        name: 'Address Book',
        destination: addressScreen),
    MenuItems(
        image: 'assets/icons/card.png',
        name: 'My Cards',
        destination: cardScreen),
    MenuItems(
        image: 'assets/icons/gift.png',
        name: 'Gift Voucher',
        destination: giftScreen),
    MenuItems(
        image: 'assets/icons/setting.png',
        name: 'Settings',
        destination: settingsScreen),
    MenuItems(
        image: 'assets/icons/chat.png',
        name: 'Contact Us',
        destination: contactScreen),
    MenuItems(
      image: 'assets/icons/sign-out.png',
      name: 'Logout',
    ),
  ];

  List<Map<String, dynamic>> snacksItems = [
    {'name': 'Pizza', 'icons': 'assets/icons/pizza.png'},
    {'name': 'Burger', 'icons': 'assets/icons/burger.png'},
    {'name': 'Salad', 'icons': 'assets/icons/salad.png'},
    {'name': 'Hot dog', 'icons': 'assets/icons/hot-dog.png'},
    {'name': 'Fries', 'icons': 'assets/icons/french-fries.png'},
    {'name': 'Sandwich', 'icons': 'assets/icons/sandwich.png'},
    {'name': 'Taco', 'icons': 'assets/icons/taco.png'},
  ];

  onButtonPressed({Item? item, required String type}) {
    if (type == 'ITEM_DETAILS') {
      Navigator.pushNamed(context, itemDetailsScreen, arguments: item);
    } else if (type == 'SIGN_OUT') {
      ref.read(signInNotifierProvider.notifier).userSignOut();
    } else if (type == 'SEARCH') {
      Navigator.pushNamed(context, searchScreen);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(locationNotifierProvider.notifier).getLocation();
      final res = ref.read(locationNotifierProvider.notifier).locationInfo;
      print(res);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ResponseState>(signInNotifierProvider,
        (ResponseState? previous, ResponseState next) {
      if (next.isLoading!) {
        showProgress(context);
      } else if (next.isError!) {
        Navigator.pop(context);
        showMessage(context, next.errorMessage!);
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context, signInScreen, (route) => false);
          showMessage(context, 'User Logout');
        });
      }
    });

    final state = ref.watch(itemNotifierProvider);
    final location = ref.watch(locationNotifierProvider);
    return Scaffold(
        drawer: CommonDrawer(
            menuItems: menuItems,
            onButtonPressed: () {
              onButtonPressed(type: 'SIGN_OUT');
            }),
        body: SafeArea(
            child: state.isLoading!
                ? const Center(
                    child: CupertinoActivityIndicator(radius: 10),
                  )
                : state.isError!
                    ? Text(state.errorMessage.toString())
                    : RefreshIndicator(
                        onRefresh: () {
                          return ref
                              .read(itemNotifierProvider.notifier)
                              .getItemsDetails();
                        },
                        child: CustomScrollView(slivers: [
                          SliverToBoxAdapter(
                              child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    CommonHeader(
                                      photoURL: ref
                                          .read(
                                              profileNotifierProvider.notifier)
                                          .user!
                                          .photoURL,
                                      locationInfo: location.response,
                                    ),
                                    const Gap(20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                              onTap: () {
                                                onButtonPressed(type: 'SEARCH');
                                              },
                                              child: const CommonSearch(
                                                enabled: false,
                                              )),
                                        ),
                                        const Gap(10),
                                        CommonButton(
                                            paddingVertical: 5,
                                            paddingHorizontal: 10,
                                            hasIconOnly: true,
                                            onButtonPressed: () {},
                                            icon: Image.asset(
                                              "assets/icons/sort.png",
                                              width: 40,
                                              height: 40,
                                              color: FoodAppColors.white,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(30),
                              const CommonSectionHeader(
                                  header: 'Popular Near You',
                                  subHeader: 'View more'),
                              const Gap(20),
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 270,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              state.response.items.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                ItemCardGrid(
                                                  onItemPressed: () {
                                                    onButtonPressed(
                                                        type: 'ITEM_DETAILS',
                                                        item: state.response
                                                            .items[index]);
                                                  },
                                                  item: state
                                                      .response.items[index],
                                                ),
                                                const Gap(20)
                                              ],
                                            );
                                          }),
                                    ),
                                    const SizedBox(height: 30),
                                    SizedBox(
                                      height: 120,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snacksItems.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    width: 75,
                                                    height: 75,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            FoodAppColors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Image.asset(
                                                          snacksItems[index]
                                                              ['icons']),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(snacksItems[index]
                                                      ['name'])
                                                ],
                                              ),
                                              const Gap(10)
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              const CommonSectionHeader(
                                  header: 'Recommended',
                                  subHeader: 'View more'),
                              const SizedBox(height: 20),
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 270,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              state.response.items.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                ItemCardGrid(
                                                  item: state
                                                      .response.items[index],
                                                ),
                                                const Gap(20)
                                              ],
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                          const SliverToBoxAdapter(child: SizedBox(height: 30)),
                          SliverToBoxAdapter(
                            child: SingleChildScrollView(
                                clipBehavior: Clip.none,
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      for (var i = 0; i <= 10; i++)
                                        const Row(
                                          children: [
                                            CommonGiftCard(),
                                            SizedBox(width: 20)
                                          ],
                                        ),
                                    ],
                                  ),
                                )),
                          ),
                          const SliverToBoxAdapter(child: SizedBox(height: 30)),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .85,
                              child: CommonTabBar(widgetOptions: [
                                FeaturedTab(
                                  items: state.response,
                                ),
                                const PopularTab(),
                                const NewestTab(),
                                const TrendingTab(),
                              ], widgetLabels: const [
                                'Featured',
                                'Popular',
                                'Newest',
                                'Trending',
                              ]),
                            ),
                          )
                        ]),
                      )));
  }
}

class MenuItems {
  String? image;
  String? name;
  String? destination;
  MenuItems({this.image, this.name, this.destination});
}
