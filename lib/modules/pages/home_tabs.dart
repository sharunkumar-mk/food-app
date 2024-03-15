import 'package:flutter/material.dart';
import 'package:food_app/models/item_model.dart';
import 'package:food_app/modules/widgets/item/item_card_list.dart';

class FeaturedTab extends StatelessWidget {
  final ItemModel? items;
  const FeaturedTab({super.key, this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items!.items!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ItemCardList(item: items!.items![index]),
          );
        });
  }
}

class PopularTab extends StatelessWidget {
  const PopularTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Popular tab'));
  }
}

class NewestTab extends StatelessWidget {
  const NewestTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Newesr tab"));
  }
}

class TrendingTab extends StatelessWidget {
  const TrendingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Trending tab"));
  }
}
