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
  switch (cc) {
    case CharacterClass.adept:
      return constitution + 20 + d6();
    case CharacterClass.expert:
      return constitution + 15 + d6();
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
  switch (cc) {
    case CharacterClass.adept:
      return new List.unmodifiable(["Staves", "Brawling weapons"]);
    case CharacterClass.expert:
      return new List.unmodifiable(
          ["Bows", "Brawling weapons", "Light blades", "Staves"]);
    case CharacterClass.warrior:
    default:
      return new List();
  }
}

List<Talent> _adeptTalents = new List.unmodifiable([
  new Talent("Linguistics", Degree.novice,
      requirements: [new Requirement(Ability.intelligence, 1)]),
  new Talent("Lore", Degree.novice,
      requirements: [new Requirement(Ability.intelligence, 2)]),
  new Talent("Medicine", Degree.novice,
      requirements: [new Requirement(Ability.intelligence, 1)]),
  new Talent("Observation", Degree.novice,
      requirements: [new Requirement(Ability.perception, 2)])
]);

List<Talent> _expertTalents = new List.unmodifiable([
  new Talent("Animal training", Degree.novice),
  new Talent("Arcane potential", Degree.novice),
  new Talent("Carousing", Degree.novice,
      requirements: [
        new Requirement(Ability.communication, 1),
        new Requirement(Ability.constitution, 1)
      ]),
  new Talent("Contacts", Degree.novice,
      requirements: [new Requirement(Ability.communication, 2)]),
  new Talent("Intrigue", Degree.novice,
      requirements: [new Requirement(Ability.communication, 2)]),
  new Talent("Linguistics", Degree.novice,
      requirements: [new Requirement(Ability.intelligence, 1)]),
  new Talent("Medicine", Degree.novice,
      requirements: [new Requirement(Ability.intelligence, 1)]),
  new Talent("Oratory", Degree.novice),
  new Talent("Performance", Degree.novice),
  new Talent("Scouting", Degree.novice,
      requirements: [new Requirement(Ability.dexterity, 2)]),
  new Talent("Theivery", Degree.novice,
      requirements: [new Requirement(Ability.dexterity, 2)]),
]);

List<Talent> getTalentsFor(Character c) {
  switch (c.characterClass) {
    case CharacterClass.adept:
      Talent first = drawWhere(arcaneTalents, c.canTake);
      Talent second = drawWhere(arcaneTalents.where(c.canTake),
              (t) => t != first);
      Talent third = drawWhere(_adeptTalents, c.canTake);

      return _listOfNonNull([first, second, third]);

    case CharacterClass.expert:
      return _listOfNonNull([drawWhere(_expertTalents, c.canTake)]);

    case CharacterClass.warrior:
    default:
      return new List();
  }
}

List<String> getPowersFor(CharacterClass cc) {
  switch (cc) {
    case CharacterClass.adept:
      return new List.unmodifiable([
        "May use the Skillful Channeling arcane "
            "stunt for 1 SP instead of 2 & when using "
            "Powerful Channeling you get +1 free SP (must spend at least 1 SP)"
      ]);

    case CharacterClass.expert:
      return new List.unmodifiable([
        "Once per round, add 1d6 to the damage of a sucessful attack if your dex > your target's",
        "You are trained in Light Armor w/out need of the Armor Training talent"
      ]);

    case CharacterClass.warrior:
    default:
      return new List();
  }
}

List<T> _listOfNonNull<T>(List<T> ts) {
  List<T> result = new List();
  for (var t in ts) {
    if (t != null) result.add(t);
  }

  return result;
}
