import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/models/cart_item_model.dart';
import 'package:food_app/models/item_model.dart';
import 'package:food_app/modules/widgets/common_appbar.dart';
import 'package:food_app/modules/widgets/common_button.dart';
import 'package:food_app/modules/widgets/common_plus_minus.dart';
import 'package:food_app/modules/widgets/item/common_rating.dart';
import 'package:food_app/providers/provider.dart';
import 'package:gap/gap.dart';

class ItemDetailsPage extends ConsumerStatefulWidget {
  final Item item;

  const ItemDetailsPage({super.key, required this.item});

  @override
  ItemDetailsPageState createState() => ItemDetailsPageState();
}

class ItemDetailsPageState extends ConsumerState<ItemDetailsPage> {
  int itemCount = 1;
  late String restaurantName;

  @override
  void initState() {
    getRestaurantDetails();
    super.initState();
  }

  getRestaurantDetails() {
    try {
      final restaurant =
          ref.read(restaurantNotifierProvider.notifier).restaurants.firstWhere(
                (element) => element.restaurantId == widget.item.restaurantId,
              );

      setState(() {
        restaurantName = restaurant.name ?? '';
      });
    } catch (e) {
      setState(() {
        restaurantName = '';
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .4,
                fit: BoxFit.cover,
                imageUrl: widget.item.imageUrl!,
                placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(strokeWidth: 1)),
                errorWidget: (context, url, error) => Image.asset(
                  fit: BoxFit.cover,
                  "assets/icons/image-placeholder.png",
                ),
              ),
              const CommonAppBar(
                title: '',
                hasTrailing: true,
                trailingWidget: Icon(Icons.badge),
              )
            ],
          ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.item.name ?? 'Item name',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.normal),
                ),
                Text(
                  widget.item.price.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/icons/map.png'),
                    Text(restaurantName),
                  ],
                ),
                CommonRating(rating: widget.item.rating.toString())
              ],
            ),
          ),
          Text(widget.item.description.toString())
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 30,
          left: 20,
          right: 20,
        ),
        child: SizedBox(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: CommonPlusMinus(
                      onItemCountChanged: (count) => itemCount = count)),
              const Gap(20),
              Expanded(
                flex: 2,
                child: Consumer(builder: (context, ref, child) {
                  return CommonButton(
                    labelText: 'Add to cart',
                    onButtonPressed: () {
                      ref.read(cartNotifierProvider.notifier).addCartItem(
                          cartItem: CartItem(
                              item: widget.item, itemCount: itemCount));
                      Navigator.pushReplacementNamed(context, cartScreen);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
