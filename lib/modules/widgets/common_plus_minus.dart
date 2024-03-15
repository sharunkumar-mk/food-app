import 'package:flutter/material.dart';
import 'package:food_app/constants/color_path.dart';

class CommonPlusMinus extends StatefulWidget {
  final bool hasBorder;
  final int itemCount;

  final void Function(int) onItemCountChanged;

  const CommonPlusMinus({
    super.key,
    required this.onItemCountChanged,
    this.hasBorder = false,
    this.itemCount = 1,
  });

  @override
  State<CommonPlusMinus> createState() => _CommonPlusMinusState();
}

class _CommonPlusMinusState extends State<CommonPlusMinus> {
  late int itemCount;

  @override
  void initState() {
    itemCount = widget.itemCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: FoodAppColors.white,
          borderRadius: BorderRadius.circular(10),
          border:
              widget.hasBorder ? Border.all(color: FoodAppColors.red) : null),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                if (itemCount <= 1) {
                  setState(() {
                    itemCount = 1;
                  });
                } else {
                  setState(() {
                    itemCount--;
                    widget.onItemCountChanged(itemCount);
                  });
                }
              },
              child: Image.asset(
                "assets/icons/minus.png",
                width: 20,
                height: 20,
                color: FoodAppColors.red,
              )),
          Text(
            itemCount.toString(),
            style: const TextStyle(fontSize: 20),
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  itemCount++;
                  widget.onItemCountChanged(itemCount);
                });
              },
              child: Image.asset(
                "assets/icons/plus.png",
                color: FoodAppColors.red,
                width: 20,
                height: 20,
              )),
        ],
      ),
    );
  }
}
