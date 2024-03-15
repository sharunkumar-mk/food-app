import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/modules/widgets/common_location.dart';
import 'package:food_app/providers/location_provider.dart';

class CommonHeader extends StatelessWidget {
  final String? photoURL;
  final VoidCallback? onButtonPressed;
  final LocationInfo? locationInfo;

  const CommonHeader(
      {super.key, this.photoURL, this.onButtonPressed, this.locationInfo});

  @override
  Widget build(BuildContext context) {
    ImageProvider imageVariable = const AssetImage("assets/images/man.png");

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Delivey to",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            locationInfo != null
                ? CommonLocation(
                    name: locationInfo!.place!.name!,
                    country: locationInfo!.place!.country!,
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
      GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, profileScreen);
          },
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                imageUrl: photoURL ?? '',
                placeholder: (context, url) => Image(image: imageVariable),
                errorWidget: (context, url, error) =>
                    Image(image: imageVariable),
              ),
            ),
          ))
    ]);
  }
}
