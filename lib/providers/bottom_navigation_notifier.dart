import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottonNavigationNotifier extends StateNotifier<int> {
  BottonNavigationNotifier() : super(0);
  int selectedIndex = 0;
  updateSelectedIndex(int index) {
    selectedIndex = index;
  }
}
