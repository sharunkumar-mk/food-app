import 'package:flutter/material.dart';
import 'package:food_app/constants/color_path.dart';

class CommonTabBar extends StatefulWidget {
  const CommonTabBar(
      {super.key,
      required this.widgetOptions,
      required this.widgetLabels,
      this.horizontalPadding = 0});

  final List<Widget> widgetOptions;
  final List<String> widgetLabels;
  final double horizontalPadding;

  @override
  State<CommonTabBar> createState() => _CommonTabBarState();
}

class _CommonTabBarState extends State<CommonTabBar>
    with SingleTickerProviderStateMixin {
  late final tabController =
      TabController(length: widget.widgetOptions.length, vsync: this);
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            for (var labels in widget.widgetLabels)
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = widget.widgetLabels.indexOf(labels);
                            tabController
                                .animateTo(widget.widgetLabels.indexOf(labels));
                          });
                        },
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                labels.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: selectedIndex ==
                                            widget.widgetLabels.indexOf(labels)
                                        ? FoodAppColors.primaryRed
                                        : FoodAppColors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    selectedIndex == widget.widgetLabels.indexOf(labels)
                        ? Container(
                            height: 2,
                            width: 75,
                            decoration: const BoxDecoration(
                                color: FoodAppColors.primaryRed),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
          ],
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: widget.widgetOptions,
          ),
        )
      ],
    );
  }
}
