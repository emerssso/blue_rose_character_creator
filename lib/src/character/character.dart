import 'dart:math';
import 'package:blue_rose_character_creator/src/character/character_class.dart';
import 'package:blue_rose_character_creator/src/character/race.dart';
import 'package:blue_rose_character_creator/src/character/stat.dart';

/// Models a Blue Rose character
class Character {
  String name;
  Race race = Race.unknown;
  String background;

  CharacterClass characterClass = CharacterClass.unknown;
  int level;

  Map<Stat, int> stats = new Map();

  int get accuracy => stats[Stat.accuracy];
  int get communication => stats[Stat.communication];
  int get constitution => stats[Stat.constitution];
  int get dexterity => stats[Stat.dexterity];
  int get fighting => stats[Stat.fighting];
  int get intelligence => stats[Stat.intelligence];
  int get perception => stats[Stat.perception];
  int get strength => stats[Stat.strength];
  int get willpower => stats[Stat.willpower];

  Character({this.name, this.race, this.background,
    this.characterClass, this.level});

  void fillCharacterSheet() {
    List<int> bonuses = new List
        .generate(9, (i) => Xd6(3))
        .map((k) => rollToBonus[k]).toList();

    bonuses.sort((i,j) => j - i);

    List<Stat> statOrder = statPriorityListForClass(characterClass);

    for(int i = 0; i < statOrder.length; i++) {
      stats[statOrder[i]] = bonuses[i];
    }
  }
}

var rng = new Random();

int d6() {
  return rng.nextInt(6) + 1;
}

int Xd6(int times) {
  return new List.generate(times, (i) => d6()).fold(0, (i, j) => i + j);
}

Map<int, int> rollToBonus = new Map.unmodifiable(
    new Map.fromIterables(
        [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18], 
        [-2,-1,-1,0,0,0,1,1,1,2,2,2,3,3,3,4]));