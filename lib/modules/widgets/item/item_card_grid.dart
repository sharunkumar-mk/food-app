import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/models/item_model.dart';
import 'package:food_app/modules/widgets/item/common_rating.dart';

class ItemCardGrid extends StatelessWidget {
  final Item item;
  final double width;
  final double height;
  final VoidCallback? onItemPressed;
  const ItemCardGrid({
    super.key,
    required this.item,
    this.height = 265,
    this.width = 250,
    this.onItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onItemPressed,
      child: Ink(
        child: Container(
          height: height,
          width: width,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  width: 1, color: FoodAppColors.grey.withOpacity(.2))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: item.imageUrl ?? '',
                        placeholder: (context, url) => const Center(
                            child: CupertinoActivityIndicator(radius: 10)),
                        errorWidget: (context, url, error) => Image.asset(
                          fit: BoxFit.cover,
                          "assets/icons/image-placeholder.png",
                        ),
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.name ?? 'Item name',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                          ),
                          Expanded(
                              child: Text(item.description ?? 'Description')),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.price.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      CommonRating(rating: item.rating.toString())
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
