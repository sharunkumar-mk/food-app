import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_app/constants/color_path.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/constants/secure_storage_path.dart';

class WalkThroughPage extends StatefulWidget {
  const WalkThroughPage({super.key});

  @override
  State<WalkThroughPage> createState() => _WalkThroughPageState();
}

class _WalkThroughPageState extends State<WalkThroughPage> {
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    int currentPage = 0;

    onPageForward() {
      if (currentPage == 3) {
        Navigator.pushReplacementNamed(context, homeScreen);
      } else {
        pageController.nextPage(
            duration: const Duration(milliseconds: 1), curve: Curves.ease);
      }
    }

    final List<Widget> walkThroughScreens = [
      WalkthroughScreen(
        image: "assets/images/walk1.png",
        title: "Search Your\nFavorite ",
        subTitle: "Food",
        description: "Discover the foods from over\nall nearby restaurants.",
        onPageForward: onPageForward,
      ),
      WalkthroughScreen(
        image: "assets/images/walk1.png",
        title: "Browse Your",
        subTitle: "\nMenu",
        description: "description 1",
        onPageForward: onPageForward,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, signInScreen);
                secureStorage.write(
                    key: SecureStoragePath.firstTime, value: 'false');
              },
              child: const Text('Skip'))
        ],
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: walkThroughScreens.length,
        itemBuilder: (context, index) {
          return walkThroughScreens[index];
        },
        onPageChanged: (page) {
          currentPage = page;
        },
      ),
    );
  }
}

class WalkthroughScreen extends StatelessWidget {
  const WalkthroughScreen(
      {super.key,
      required this.title,
      required this.description,
      this.onPageForward,
      this.isLastPage = false,
      required this.image,
      required this.subTitle});

  final String title;
  final String subTitle;
  final String description;
  final VoidCallback? onPageForward;
  final bool isLastPage;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(image: AssetImage(image)),
        const SizedBox(
          height: 40,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: FoodAppColors.black,
              ),
              text: title,
              children: [
                TextSpan(
                    style: const TextStyle(color: FoodAppColors.red),
                    text: subTitle)
              ]),
        ),
        const SizedBox(height: 20),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(color: FoodAppColors.grey),
              text: description,
            )),
        const SizedBox(height: 40),
        Expanded(
            child: GestureDetector(
                onTap: () =>
                    Navigator.pushReplacementNamed(context, signInScreen),
                child: const Image(
                    image: AssetImage('assets/icons/slide_icon.png')))),
      ],
    );
  }
}
