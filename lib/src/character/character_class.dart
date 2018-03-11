import 'dart:math';
/// Models the three Blue Rose Classes as an enum

import 'package:blue_rose_character_creator/src/character/stat.dart';

enum CharacterClass { warrior, expert, adept, unknown }

String characterClassToString(CharacterClass cc) {
  switch (cc) {
    case CharacterClass.warrior:
      return "Warrior";
    case CharacterClass.expert:
      return "Expert";
    case CharacterClass.adept:
      return "Adept";
    default:
      return "Unknown";
  }
}

List<Stat> warriorPrimary = [
  Stat.constitution,
  Stat.dexterity,
  Stat.fighting,
  Stat.strength
];
List<Stat> warriorSecondary = [
  Stat.accuracy,
  Stat.communication,
  Stat.intelligence,
  Stat.perception,
  Stat.willpower
];

List<Stat> expertPrimary = [
  Stat.accuracy,
  Stat.communication,
  Stat.dexterity,
  Stat.perception
];
List<Stat> expertSecondary = [
  Stat.constitution,
  Stat.fighting,
  Stat.intelligence,
  Stat.strength,
  Stat.willpower
];

List<Stat> adeptPrimary = [
  Stat.accuracy,
  Stat.intelligence,
  Stat.perception,
  Stat.willpower
];
List<Stat> adeptSecondary = [
  Stat.communication,
  Stat.constitution,
  Stat.dexterity,
  Stat.fighting,
  Stat.strength
];

//Stat,Adept,Warrior,Expert
//Accuracy,1,2,1
//Communication,2,2,1
//Constitution,2,1,2
//Dexterity,2,1,1
//Fighting,2,1,2
//Intelligence,1,2,2
//Perception,1,2,1
//Strength,2,1,2
//Willpower,1,2,2

Random rng = new Random();

List<Stat> statPriorityListForClass(CharacterClass cc) {
  List<Stat> primary;
  List<Stat> secondary;

  switch (cc) {
    case CharacterClass.warrior:
     primary = new List.from(warriorPrimary);
     secondary = new List.from(warriorSecondary);
     break;
    case CharacterClass.expert:
      primary = new List.from(expertPrimary);
      secondary = new List.from(expertSecondary);
      break;
    case CharacterClass.adept:
      primary = new List.from(adeptPrimary);
      secondary = new List.from(adeptSecondary);
      break;
    case CharacterClass.unknown:
      primary = new List<Stat>();
      secondary = primary;
  }

  primary.shuffle(rng);
  secondary.shuffle(rng);

  primary.addAll(secondary);

  return primary;
}
