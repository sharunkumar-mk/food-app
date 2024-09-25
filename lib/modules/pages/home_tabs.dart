import 'package:flutter/material.dart';
import 'package:food_app/models/item_model.dart';
import 'package:food_app/modules/widgets/item/item_card_list.dart';

class FeaturedTab extends StatelessWidget {
  final List<Item> items;
  const FeaturedTab({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ItemCardList(item: items[index]),
          );
        });
  }
}

class PopularTab extends StatelessWidget {
  final List<Item> items;
  const PopularTab({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ItemCardList(item: items[index]),
          );
        });
  }
}

class NewestTab extends StatelessWidget {
  final List<Item> items;

  const NewestTab({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ItemCardList(item: items[index]),
          );
        });
  }
}

class TrendingTab extends StatelessWidget {
  final List<Item> items;

  const TrendingTab({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ItemCardList(item: items[index]),
          );
        });
  }
}
