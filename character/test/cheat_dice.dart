import 'dart:math';

import 'package:blue_rose_character/dice.dart';
import 'package:mockito/mockito.dart';

class FakeRandom implements Random {
  List<bool> nextBools = [];
  List<double> nextDoubles = [];
  List<int> nextInts = [];

  T _pop<T>(List<T> list) {
    assert(list.isNotEmpty);
    var next = list[0];
    list.removeAt(0);
    return next;
  }

  @override
  bool nextBool() {
    if (nextBools.isEmpty) {
      throw 'You must set FakeRandom#nextBools before calling nextBool()';
    }

    return _pop(nextBools);
  }

  @override
  double nextDouble() {
    if (nextDoubles.isEmpty) {
      throw 'You must add doubles to FakeRandom#nextDoubles before calling '
          'nextDouble()';
    }

    return _pop(nextDoubles);
  }

  @override
  int nextInt(int max) {
    if (nextInts.isEmpty) {
      throw 'You must add ints to FakeRandom#nextInts before calling '
          'nextInt()';
    }

    var next = _pop(nextInts);
    if(next >= max) {
      throw 'Next int $next greater than max $max';
    }

    return next;
  }
}
