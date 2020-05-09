import 'dart:math';

import 'package:blue_rose_character/dice.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    rng = _MockRandom();
  });

  group('Dice', () {
    group('d', () {
      test('returns 1 if 0 rolled on single die', () {
        when(rng.nextInt(6)).thenReturn(0);
        expect(1.d(6), equals(1));
      });

      test('returns sum of die rolls (rng value +1 per die)', () {
        var count = 0;
        when(rng.nextInt(6)).thenAnswer((i) => count++);
        expect(2.d(6), equals(3));
      });
    });
  });

  group('flipCoin', () {
    test('returns true on 1', () {
      when(rng.nextInt(2)).thenReturn(1);
      expect(flipCoin(), isTrue);
    });

    test('returns false on 0', () {
      when(rng.nextInt(2)).thenReturn(0);
      expect(flipCoin(), isFalse);
    });
  });

  group('drawFrom', () {
    test('returns null for null dek', () {
      expect(drawFrom(null), isNull);
    });

    test('returns null for empty dek', () {
      expect(drawFrom([]), isNull);
    });

    test('returns first from singleton deck', () {
      expect(drawFrom(['a']), equals('a'));
    });

    test('returns rolled index from deck', () {
      when(rng.nextInt(3)).thenReturn(2);
      expect(drawFrom(['a', 'b', 'c']), equals('c'));
    });
  });

  group('drawWhere', () {
    test('returns null for null', () {
      expect(drawWhere(null, (_) => true), isNull);
    });

    test('returns null for no matches', () {
      expect(
        drawWhere(['a', 'b', 'bc'], (String c) => c.contains('d')),
        isNull,
      );
    });

    test('returns random member if found', () {
      when(rng.nextInt(2)).thenReturn(1);
      expect(
        drawWhere(['a', 'b', 'bc'], (String c) => c.contains('b')),
        equals('bc'),
      );
    });
  });

  group('drawWithoutRepeats', () {
    test('returns null for null', () {
      expect(drawWithoutRepeats(null, null), isNull);
    });

    test('returns null if repeats contains deck', () {
      expect(drawWithoutRepeats(['a'], ['a']), isNull);
    });

    test('returns draw from unrepeated deck', () {
      expect(drawWithoutRepeats(['a', 'b'], ['a']), equals('b'));
    });
  });

  group('drawN', () {
    test('returns null for null', () {
      expect(drawN(1, null), isNull);
    });

    test('returns empty if deck is empty', () {
      expect(drawN(1, []), equals([]));
    });

    test('returns deck if deck is smaller than n', () {
      expect(drawN(3, ['a', 'b']), equals(['a', 'b']));
    });

    test('returns random subset of deck if N < deck size', () {
      when(rng.nextInt(3)).thenReturn(1);
      expect(drawN(1, ['a', 'b', 'c']), equals(['b']));
    });
  });

  group('drawNWhere', () {
    test('returns random members if found', () {
      when(rng.nextInt(2)).thenReturn(1);
      expect(
        drawNWhere(2, ['a', 'b', 'bc'], (String c) => c.contains('b')),
        equals(['b', 'bc']),
      );
    });
  });
}

class _MockRandom extends Mock implements Random {}
