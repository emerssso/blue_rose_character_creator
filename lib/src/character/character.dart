import 'dart:math';
import 'package:blue_rose_character_creator/src/character/character_class.dart';
import 'package:blue_rose_character_creator/src/character/race.dart';
import 'package:blue_rose_character_creator/src/character/ability.dart';
import 'package:blue_rose_character_creator/src/character/calling_destiny_fate.dart';

/// Models a Blue Rose character
class Character {
  String name;
  Race race = Race.unknown;
  String background;
  CharacterClass characterClass = CharacterClass.unknown;
  int level;

  String calling;
  String destiny;
  String fate;
  bool destinyAscendant;

  Map<Ability, int> _abilities = new Map();

  int get accuracy => _abilities[Ability.accuracy] ?? 0;
  int get communication => _abilities[Ability.communication] ?? 0;
  int get constitution => _abilities[Ability.constitution] ?? 0;
  int get dexterity => _abilities[Ability.dexterity] ?? 0;
  int get fighting => _abilities[Ability.fighting] ?? 0;
  int get intelligence => _abilities[Ability.intelligence] ?? 0;
  int get perception => _abilities[Ability.perception] ?? 0;
  int get strength => _abilities[Ability.strength] ?? 0;
  int get willpower => _abilities[Ability.willpower] ?? 0;

  Character(
      {this.name, this.race, this.background, this.characterClass, this.level});

  void fillCharacterSheet() {
    fillAbilities();

    calling = callings[rng.nextInt(callings.length)];
    destiny = destinies[rng.nextInt(destinies.length)];
    fate = fates[rng.nextInt(fates.length)];
    destinyAscendant = rng.nextInt(2) == 1;
  }

  void fillAbilities() {
    List<int> bonuses =
        new List.generate(9, (i) => Xd6(3))
            .map((k) => rollToBonus[k])
            .toList();

    bonuses.sort((i, j) => j - i);

    List<Ability> statOrder = statPriorityListForClass(characterClass);

    for (int i = 0; i < statOrder.length; i++) {
      _abilities[statOrder[i]] = bonuses[i];
    }
  }

  bool get isFilled => _abilities.isNotEmpty;
}

var rng = new Random();

int d6() => rng.nextInt(6) + 1;

int Xd6(int times) =>
    new List.generate(times, (i) => d6()).fold(0, (i, j) => i + j);

Map<int, int> rollToBonus = new Map.unmodifiable(new Map.fromIterables(
    [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18],
    [-2, -1, -1, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4]));
