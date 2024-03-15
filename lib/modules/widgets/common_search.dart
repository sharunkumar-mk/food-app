import 'package:flutter/material.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:gap/gap.dart';

class CommonSearch extends StatelessWidget {
  final bool enabled;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;

  final TextEditingController? controller;
  const CommonSearch(
      {super.key,
      this.enabled = true,
      this.controller,
      this.onFieldSubmitted,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 25, maxWidth: 50),
            prefixIcon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Gap(10),
                Image.asset(
                  width: 20,
                  height: 30,
                  "assets/icons/search.png",
                  color: FoodAppColors.grey.withOpacity(.5),
                ),
                const Gap(15),
                VerticalDivider(
                  width: 1,
                  color: FoodAppColors.grey.withOpacity(.5),
                )
              ],
            ),
            border: InputBorder.none,
          ),
        ));
  }
}
