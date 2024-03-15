import 'package:flutter/material.dart';
import 'package:food_app/modules/pages/tabs/home.dart';

class CommonDrawer extends StatelessWidget {
  final List<MenuItems> menuItems;
  final VoidCallback? onButtonPressed;
  const CommonDrawer(
      {super.key, required this.menuItems, this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 80,
                  height: 80,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var items in menuItems)
                  GestureDetector(
                    onTap: items.destination != null
                        ? () {
                            Navigator.pushNamed(context, items.destination!);
                          }
                        : onButtonPressed,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Image.asset(items.image!),
                          const SizedBox(width: 10),
                          Text(items.name!)
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Divider(
              thickness: 1,
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text("Privacy Policy"),
                            Text("Support & FAQs"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/icons/moon.png'),
                            const SizedBox(width: 10),
                            const Text('Mode'),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Switch(
                          inactiveTrackColor: Colors.grey.withOpacity(.2),
                          inactiveThumbColor: Colors.white,
                          splashRadius: 0,
                          value: false,
                          onChanged: (value) {},
                        )
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
