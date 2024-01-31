import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/providers/location_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(locationProvider);
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text("Delivey to"),
                  Row(
                    children: [
                      Image.asset("assets/icons/location.png"),
                      const Text("state.response.place.name.toString()")
                    ],
                  )
                ],
              ),
              Image.asset(
                "assets/icons/user.png",
                width: 64,
                height: 64,
              )
            ],
          )
        ],
      ),
    ));
  }
}
