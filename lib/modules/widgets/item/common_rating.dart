import 'package:flutter/material.dart';
import 'package:food_app/constants/color_path.dart';

class CommonRating extends StatelessWidget {
  final String rating;
  const CommonRating({super.key, this.rating = '0'});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 25,
      decoration: BoxDecoration(
          color: FoodAppColors.green, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            maxLines: 1,
            overflow: TextOverflow.clip,
            rating,
            style: const TextStyle(color: FoodAppColors.white),
          ),
          Image.asset(
            'assets/icons/star.png',
            width: 20,
            height: 20,
            color: FoodAppColors.white,
          )
        ],
      ),
    );
  }
}
