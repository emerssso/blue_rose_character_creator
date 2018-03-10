import 'package:blue_rose_character_creator/src/character/character_class.dart';
import 'package:blue_rose_character_creator/src/character/race.dart';

/// Models a Blue Rose character
class Character {
  String name;
  Race race = Race.unknown;
  String background;

  CharacterClass characterClass = CharacterClass.unknown;
  int level;

  int accuracy;
  int communication;
  int constitution;
  int dexterity;
  int fighting;
  int intelligence;
  int perception;
  int strength;
  int willpower;

  Character({this.name, this.race, this.background,
    this.characterClass, this.level,
    this.accuracy, this.communication, this.constitution, this.fighting,
    this.intelligence, this.perception, this.strength, this.willpower});
}