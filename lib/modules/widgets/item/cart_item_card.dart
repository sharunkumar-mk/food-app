import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/models/cart_item_model.dart';
import 'package:food_app/modules/widgets/common_plus_minus.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final Function(int)? onChange;
  const CartItemCard({
    super.key,
    required this.cartItem,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
          color: FoodAppColors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Flexible(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  imageUrl: cartItem.item.imageUrl!,
                  placeholder: (context, url) =>
                      const CupertinoActivityIndicator(radius: 10),
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/icons/image-placeholder.png"),
                )),
          )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartItem.item.name!),
                  Text(
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    '₹${cartItem.item.price!}',
                  ),
                  const Text("24")
                ],
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 40,
                  width: 100,
                  child: CommonPlusMinus(
                      itemCount: cartItem.itemCount,
                      hasBorder: true,
                      onItemCountChanged: (count) {
                        onChange!(count);
                      }),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
