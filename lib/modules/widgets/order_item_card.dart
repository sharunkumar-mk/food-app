import 'package:flutter/material.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/modules/widgets/common_button.dart';
import 'package:gap/gap.dart';

class OrderItemCard extends StatelessWidget {
  final String? name;
  final String? date;
  final String? status;
  final double? price;
  final String? image;
  final bool upComming;
  final Function()? onFirstButtonPressed;
  final Function()? onSecondfButtonPressed;

  const OrderItemCard({
    super.key,
    this.name,
    this.date,
    this.price,
    this.status,
    this.image,
    this.upComming = false,
    this.onFirstButtonPressed,
    this.onSecondfButtonPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      height: 200,
      decoration: BoxDecoration(
          color: FoodAppColors.white, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: FadeInImage(
                                width: 85,
                                height: 85,
                                fit: BoxFit.cover,
                                placeholder: const AssetImage(
                                  "assets/icons/image-placeholder.png",
                                ),
                                image: NetworkImage(image!))),
                        const Gap(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              name ?? 'item name',
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "10 sept 2023",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: FoodAppColors.grey.withOpacity(.8)),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: upComming
                                          ? FoodAppColors.yellow
                                          : FoodAppColors.green),
                                ),
                                const Gap(5),
                                upComming
                                    ? const Text(
                                        "Order on Way",
                                        style: TextStyle(
                                            color: FoodAppColors.yellow,
                                            fontSize: 15),
                                      )
                                    : const Text(
                                        "Order Deliverd",
                                        style: TextStyle(
                                            color: FoodAppColors.green,
                                            fontSize: 15),
                                      ),
                              ],
                            ),
                            const Gap(20)
                          ],
                        )
                      ],
                    ),
                    Text(
                      price.toString(),
                      style: const TextStyle(
                          fontSize: 20,
                          color: FoodAppColors.red,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: CommonButton(
                        paddingHorizontal: 0,
                        backgroundColor:
                            upComming ? FoodAppColors.white : FoodAppColors.red,
                        foregroundColor:
                            upComming ? FoodAppColors.red : FoodAppColors.white,
                        paddingVertical: 12,
                        hasIcon: upComming ? false : true,
                        icon: Image.asset(
                          "assets/icons/refresh.png",
                          width: 25,
                          height: 25,
                          color: FoodAppColors.white,
                        ),
                        labelText: upComming ? 'Cancel' : 'Re-0rder',
                        onButtonPressed: onFirstButtonPressed ?? () {},
                      ),
                    ),
                    const Gap(20),
                    Expanded(
                      child: CommonButton(
                          paddingHorizontal: 0,
                          backgroundColor: upComming
                              ? FoodAppColors.red
                              : FoodAppColors.white,
                          foregroundColor: upComming
                              ? FoodAppColors.white
                              : FoodAppColors.red,
                          paddingVertical: 12,
                          hasIcon: upComming ? true : false,
                          icon: Image.asset(
                            "assets/icons/map.png",
                            width: 20,
                            height: 20,
                            color: FoodAppColors.white,
                          ),
                          labelText: upComming ? 'Track Order' : 'Get help',
                          onButtonPressed: onSecondfButtonPressed ?? () {}),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
