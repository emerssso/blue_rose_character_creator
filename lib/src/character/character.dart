import 'dart:math';
import 'package:blue_rose_character_creator/src/character/benefit.dart';
import 'package:blue_rose_character_creator/src/character/character_class.dart';
import 'package:blue_rose_character_creator/src/character/dice.dart';
import 'package:blue_rose_character_creator/src/character/focus.dart';
import 'package:blue_rose_character_creator/src/character/race.dart';
import 'package:blue_rose_character_creator/src/character/ability.dart';
import 'package:blue_rose_character_creator/src/character/calling_destiny_fate.dart';
import 'package:blue_rose_character_creator/src/character/talent.dart';

/// Models a Blue Rose character
class Character {
  final Race race;
  final String background;
  final CharacterClass characterClass;
  final int level;

  final String calling;
  final String destiny;
  final String fate;
  final bool destinyAscendant;

  final Map<Ability, int> _abilities = new Map();
  final Map<Ability, List<Focus>> focuses = new Map();
  final List<String> weaponsGroups = new List();
  final List<String> powers = new List();
  final List<Talent> talents = new List();

  int get accuracy => _abilities[Ability.accuracy] ?? 0;
  int get communication => _abilities[Ability.communication] ?? 0;
  int get constitution => _abilities[Ability.constitution] ?? 0;
  int get dexterity => _abilities[Ability.dexterity] ?? 0;
  int get fighting => _abilities[Ability.fighting] ?? 0;
  int get intelligence => _abilities[Ability.intelligence] ?? 0;
  int get perception => _abilities[Ability.perception] ?? 0;
  int get strength => _abilities[Ability.strength] ?? 0;
  int get willpower => _abilities[Ability.willpower] ?? 0;

  int get health => getHealthFor(characterClass, constitution);
  int get speed => 10 + dexterity; //TODO: Consider Rhydan complications
  int get defense => 10 + dexterity;

  Character(this.race, this.characterClass, {this.background, this.level}) :
        calling = drawCalling(),
        destiny = drawDestiny(),
        fate = drawFate(),
        destinyAscendant = coinFlip() {
    _fillAbilities();
    applyRacialBenefits(this);
    applyClassBenefits(this);
  }

  void _fillAbilities() {
    List<int> bonuses =
        new List.generate(9, (i) => Xd6(3))
            .map((k) => rollToAbilityBonus[k])
            .toList();

    bonuses.sort((i, j) => j - i);

    List<Ability> statOrder = statPriorityListForClass(characterClass);

    for (int i = 0; i < statOrder.length; i++) {
      _abilities[statOrder[i]] = bonuses[i];
    }
  }

  bool get isFilled => _abilities.isNotEmpty;

  void addFocus(Focus focus) {
    focuses[focus.ability] ??= new List();
    focuses[focus.ability].add(focus);
  }

  void increase(Ability ability) => _abilities[ability]++;

  int getAbilityBonus(Ability ability) => _abilities[ability];

  bool canTake(Talent talent) =>
      _abilities[talent.requiredAbility] >= talent.requiredBonus &&
          talents.where((has) => has.name == talent.name).isEmpty;
}

Map<int, int> rollToAbilityBonus = new Map.unmodifiable(new Map.fromIterables(
    [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18],
    [-2, -1, -1, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4]));