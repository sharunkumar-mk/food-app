import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/models/item_model.dart';
import 'package:food_app/modules/widgets/item/common_rating.dart';

class ItemCardList extends StatelessWidget {
  final Item item;
  final VoidCallback? onItemPressed;
  const ItemCardList({super.key, required this.item, this.onItemPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(width: 1, color: FoodAppColors.grey.withOpacity(.2))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 75,
                  width: 100,
                  imageUrl: item.imageUrl!,
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/icons/image-placeholder.png"),
                  placeholder: (context, url) =>
                      const CupertinoActivityIndicator(radius: 10),
                )),
          )),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? 'Item nme',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 5),
                Text(
                  item.description ?? 'Item description',
                  style:
                      const TextStyle(color: FoodAppColors.grey, fontSize: 10),
                ),
                const SizedBox(height: 20),
                Text(
                  item.price.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Image.asset(
                      'assets/icons/time.png',
                      height: 15,
                      width: 15,
                      color: FoodAppColors.red,
                    ),
                    const Text('24 min')
                  ]),
                  CommonRating(rating: item.rating.toString())
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
