import 'package:flutter/material.dart';
import 'package:food_app/constants/color_path.dart';

class CommonGiftCard extends StatelessWidget {
  const CommonGiftCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 250,
          height: 100,
          decoration: BoxDecoration(
            color: FoodAppColors.yellow,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Positioned(
            right: 0,
            bottom: 5,
            child: Image.asset("assets/images/burger.png")),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Gift Voucher",
                style: TextStyle(fontSize: 14, color: FoodAppColors.white),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Burger King",
                    style: TextStyle(color: FoodAppColors.white),
                  ),
                  Text(
                    "Great Monday",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: FoodAppColors.white),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
