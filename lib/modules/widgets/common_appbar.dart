import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasTrailing;
  final Widget? trailingWidget;
  const CommonAppBar(
      {super.key,
      this.title = 'Title',
      this.hasTrailing = false,
      this.trailingWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        children: [
          const Gap(10),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title),
              ],
            ),
          ),
          hasTrailing ? trailingWidget! : const Gap(50)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
