import 'dart:math';
/// Models the three Blue Rose Classes as an enum

import 'package:blue_rose_character_creator/src/character/ability.dart';

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
      return "Class";
  }
}

List<Ability> warriorPrimary = [
  Ability.constitution,
  Ability.dexterity,
  Ability.fighting,
  Ability.strength
];
List<Ability> warriorSecondary = [
  Ability.accuracy,
  Ability.communication,
  Ability.intelligence,
  Ability.perception,
  Ability.willpower
];

List<Ability> expertPrimary = [
  Ability.accuracy,
  Ability.communication,
  Ability.dexterity,
  Ability.perception
];
List<Ability> expertSecondary = [
  Ability.constitution,
  Ability.fighting,
  Ability.intelligence,
  Ability.strength,
  Ability.willpower
];

List<Ability> adeptPrimary = [
  Ability.accuracy,
  Ability.intelligence,
  Ability.perception,
  Ability.willpower
];
List<Ability> adeptSecondary = [
  Ability.communication,
  Ability.constitution,
  Ability.dexterity,
  Ability.fighting,
  Ability.strength
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

List<Ability> statPriorityListForClass(CharacterClass cc) {
  List<Ability> primary;
  List<Ability> secondary;

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
      primary = new List<Ability>();
      secondary = primary;
  }

  primary.shuffle(rng);
  secondary.shuffle(rng);

  primary.addAll(secondary);

  return primary;
}
