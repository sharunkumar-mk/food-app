import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasTrailing;
  final Widget? trailingWidget;
  final bool hasLeading;
  const CommonAppBar({
    super.key,
    this.title = 'Title',
    this.hasTrailing = false,
    this.trailingWidget,
    this.hasLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          hasLeading
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios))
              : const SizedBox.shrink(),
          Center(child: Text(title)),
          hasTrailing
              ? Align(alignment: Alignment.centerRight, child: trailingWidget)
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
