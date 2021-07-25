import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeStateNotifier = StateNotifierProvider<TimeStateNotifier, List<int>>((_) {
  return TimeStateNotifier();
});

class TimeStateNotifier extends StateNotifier<List<int>> {
  TimeStateNotifier() : super([0, 0, 0, 0, 0, 0]);

  void updateTime(int num) {
    final val = state;
    if (val[0] == 0) {
      val.removeAt(0);
      val.add(num);
      state = val;
    }
  }

  void deleteTime() {
    final array = state;
    array.removeLast();
    array.insert(0, 0);
    state = array;
  }
}