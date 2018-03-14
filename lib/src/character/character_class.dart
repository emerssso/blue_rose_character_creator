import 'dart:math';
/// Models the three Blue Rose Classes as an enum

import 'package:blue_rose_character_creator/src/character/ability.dart';
import 'package:blue_rose_character_creator/src/character/character.dart';
import 'package:blue_rose_character_creator/src/character/dice.dart';
import 'package:blue_rose_character_creator/src/character/talent.dart';

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

int getHealthFor(CharacterClass cc, int constitution) {
  switch(cc) {
    case CharacterClass.adept:
      return constitution + 20 + d6();
    case CharacterClass.expert:
    case CharacterClass.warrior:
    default:
      return 1;
  }
}

applyClassBenefits(Character character) {
  character.weaponsGroups.addAll(getWeaponsGroupsFor(character.characterClass));
  character.powers.addAll(getPowersFor(character.characterClass));
  character.talents.addAll(getTalentsFor(character));
}

List<String> getWeaponsGroupsFor(CharacterClass cc) {
  switch(cc) {
    case CharacterClass.adept:
      return new List.unmodifiable(["Staves", "Brawling weapons"]);
    case CharacterClass.expert:
    case CharacterClass.warrior:
    default:
      return new List();
  }
}

List<Talent> _arcaneTalents = new List.unmodifiable([
  new Talent("Animism", Degree.novice),
  new Talent("Arcane Training", Degree.novice),
  new Talent("Healing", Degree.novice),
  new Talent("Meditative", Degree.novice),
  new Talent("Shaping", Degree.novice),
  new Talent("Psychic", Degree.novice),
  new Talent("Visionary", Degree.novice),
  new Talent("Wild Arcane", Degree.novice),
]);

List<Talent> _adeptTalents = new List.unmodifiable([
  new Talent("Linguistics", Degree.novice,
      requiredAbility: Ability.intelligence, requiredBonus: 1),
  new Talent("Lore", Degree.novice,
      requiredAbility: Ability.intelligence, requiredBonus: 2),
  new Talent("Medecine", Degree.novice,
      requiredAbility: Ability.intelligence, requiredBonus: 1),
  new Talent("Observation", Degree.novice,
      requiredAbility: Ability.perception, requiredBonus: 2)
]);

List<Talent> getTalentsFor(Character c) {
  switch(c.characterClass) {
    case CharacterClass.adept:
      Talent first = drawFrom(_arcaneTalents);
      Talent second = drawFrom(_arcaneTalents);

      while(first == second) {
        second = drawFrom(_arcaneTalents);
      }

      Talent third;
      do {
        third = drawFrom(_adeptTalents);
      } while(!c.canTake(third));

      return new List.from([first, second, third]);
    case CharacterClass.expert:
    case CharacterClass.warrior:
    default:
      return new List();
  }
}

List<String> getPowersFor(CharacterClass cc) {
  switch(cc) {
    case CharacterClass.adept:
      return new List.from(["may use the Skillful Channeling arcane stunt for "
          "1 SP instead of 2 & when using Powerful Channeling you get "
          "+1 free SP (must spend at least 1 SP)"]);
    case CharacterClass.expert:
    case CharacterClass.warrior:
    default:
      return new List();
  }
}

