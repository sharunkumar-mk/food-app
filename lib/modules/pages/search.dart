import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/constants/shared_preference_path.dart';
import 'package:food_app/models/item_model.dart';
import 'package:food_app/modules/widgets/common_header.dart';
import 'package:food_app/modules/widgets/common_search.dart';
import 'package:food_app/modules/widgets/common_section_header.dart';
import 'package:food_app/modules/widgets/item/item_card_list.dart';
import 'package:food_app/providers/location_provider.dart';
import 'package:food_app/providers/provider.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends ConsumerState<SearchPage> {
  List<String> recentSearches = [];
  TextEditingController searchTextEditingController = TextEditingController();
  List<Item> itemLists = [];
  List<Item> filteredItem = [];
  bool showMessage = false;
  String? image;
  LocationInfo? locationInfo;

  Future<List<String>> getRecentSearches() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> searches =
        preferences.getStringList(SharedPreferencePath.recentSearches) ?? [];
    setState(() {
      recentSearches = searches;
    });
    return searches;
  }

  Future<void> addRecentSearches({required String searchQuery}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (recentSearches.contains(searchQuery)) {
      return;
    } else {
      recentSearches.insert(0, searchQuery.toLowerCase());
    }
    preferences.setStringList(
        SharedPreferencePath.recentSearches, recentSearches.take(5).toList());
  }

  @override
  void initState() {
    getRecentSearches();

    image = ref.read(profileNotifierProvider.notifier).user!.photoURL;
    locationInfo = ref.read(locationNotifierProvider.notifier).locationInfo!;
    itemLists = ref.read(itemNotifierProvider.notifier).itemModel!.items!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CommonHeader(
                  photoURL: image,
                  locationInfo: locationInfo,
                ),
                const Gap(20),
                CommonSearch(
                    onChanged: (value) {
                      showMessage = true;
                      if (value == '') {
                        setState(() {
                          showMessage = false;
                          filteredItem = [];
                        });
                      } else {
                        setState(() {
                          filteredItem = itemLists
                              .where((element) => element.name!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      }
                    },
                    onFieldSubmitted: (value) {
                      addRecentSearches(searchQuery: value);
                    },
                    controller: searchTextEditingController),
              ],
            ),
          ),
          filteredItem.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                      itemCount: filteredItem.length,
                      itemBuilder: (context, index) {
                        return ItemCardList(item: filteredItem[index]);
                      }),
                )
              : showMessage
                  ? const Text("No item found")
                  : const SizedBox.shrink(),
          const Gap(20),
          const CommonSectionHeader(
              header: 'Recently Search', subHeader: 'Clear'),
          const Gap(20),
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              for (var item in recentSearches)
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: FoodAppColors.grey.withOpacity(.2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                              color: FoodAppColors.grey,
                              width: 20,
                              height: 20,
                              "assets/icons/repeat.png"),
                          const Gap(5),
                          Text(
                              style: const TextStyle(
                                color: FoodAppColors.grey,
                              ),
                              item),
                        ],
                      )),
                )
            ],
          ),
          const Gap(20),
          const CommonSectionHeader(
              header: 'Popular Restaurants', subHeader: 'View more')
        ],
      ),
    ));
  }
}
