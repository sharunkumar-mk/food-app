import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CommonLocation extends StatelessWidget {
  final String? name;
  final String? country;
  const CommonLocation({super.key, this.name, this.country});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset("assets/icons/map.png"),
        const SizedBox(width: 10),
        Expanded(
            child: Row(
          children: [
            Text(name ?? ''),
            const Gap(5),
            Text(country ?? ''),
          ],
        ))
      ],
    );
  }
}
