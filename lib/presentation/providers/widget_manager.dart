import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetIndexNotifier extends StateNotifier<int> {
  WidgetIndexNotifier() : super(0);

  void goToNextWidget() {
    if (state < 2) state++;
  }

  void goToPreviousWidget() {
    if (state > 0) state--;
  }
}

final widgetIndexProvider =
    StateNotifierProvider<WidgetIndexNotifier, int>((ref) {
  return WidgetIndexNotifier();
});
