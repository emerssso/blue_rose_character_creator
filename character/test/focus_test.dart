import 'package:blue_rose_character/ability.dart';
import 'package:blue_rose_character/character_class.dart';
import 'package:blue_rose_character/dice.dart';
import 'package:blue_rose_character/focus.dart';
import 'package:test/test.dart';

import 'cheat_dice.dart';

void main() {
  var fake = FakeRandom();
  setUp(() {
    rng = fake;
  });

  group('levelFocuses', () {
    test('returns existing if level 1', () {
      var existing = {
        Ability.fighting: [axes, lances],
      };

      expect(levelFocuses(existing, CharacterClass.warrior, level: 1),
          equals(existing));
    });

    test('adds focus for primary ability on even levels', () {
      var existing = {
        Ability.fighting: [axes, lances]
      };
      fake.nextInts = [1]; // second focus in constitutionFocuses

      expect(
          levelFocuses(existing, CharacterClass.warrior, level: 2),
          equals({
            ...existing,
            Ability.constitution: [rowing]
          }));
    });

    test('adds focus for secondary ability on odd levels', () {
      var existing = {
        Ability.fighting: [axes, lances]
      };
      fake.nextInts = [1, 0]; // second focus in constitutionFocuses

      expect(
          levelFocuses(existing, CharacterClass.warrior, level: 3),
          equals({
            ...existing,
            Ability.constitution: [rowing],
            Ability.accuracy: [arcane],
          }));
    });

    test('improves focuses when over level 10', () {
      var existing = {
        Ability.fighting: [axes, lances]
      };
      fake.nextInts = List.generate(12, (_) => 0);

      expect(
          levelFocuses(existing, CharacterClass.warrior, level: 12),
          equals({
            ...existing,
            Ability.constitution: [rowing, running, stamina, swimming, drinking.improve()],
            Ability.accuracy: [bows, brawling, lightBlades, arcane.improve()],
          }));
    });

    test('adds focuses if there are no more to improve', () {
      var existing = {
        Ability.fighting: [axes, lances]
      };
      fake.nextInts = List.generate(24, (_) => 0);

      expect(
          levelFocuses(existing, CharacterClass.warrior, level: 21),
          equals({
            Ability.fighting: [lances, axes.improve()],
            Ability.constitution: [drinking.improve(), rowing.improve(), running.improve(), stamina.improve(), swimming.improve()],
            Ability.accuracy: [arcane.improve(), bows.improve(), brawling.improve(), lightBlades.improve(), staves],
          }));
    });
  });
}
