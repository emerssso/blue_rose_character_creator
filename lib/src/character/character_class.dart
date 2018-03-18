import 'dart:math';

/// Models the three Blue Rose Classes as an enum

import 'package:blue_rose_character_creator/src/character/ability.dart';
import 'package:blue_rose_character_creator/src/character/character.dart';
import 'package:blue_rose_character_creator/src/character/dice.dart';
import 'package:blue_rose_character_creator/src/character/race.dart';
import 'package:blue_rose_character_creator/src/character/talent.dart';
import 'package:blue_rose_character_creator/src/character/weapons_group.dart';

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

const List<Ability> _warriorPrimary = const [
  Ability.constitution,
  Ability.dexterity,
  Ability.fighting,
  Ability.strength
];
const List<Ability> _warriorSecondary = const [
  Ability.accuracy,
  Ability.communication,
  Ability.intelligence,
  Ability.perception,
  Ability.willpower
];

const List<Ability> _expertPrimary = const [
  Ability.accuracy,
  Ability.communication,
  Ability.dexterity,
  Ability.perception
];
const List<Ability> _expertSecondary = const [
  Ability.constitution,
  Ability.fighting,
  Ability.intelligence,
  Ability.strength,
  Ability.willpower
];

const List<Ability> _adeptPrimary = const [
  Ability.accuracy,
  Ability.intelligence,
  Ability.perception,
  Ability.willpower
];
const List<Ability> _adeptSecondary = const [
  Ability.communication,
  Ability.constitution,
  Ability.dexterity,
  Ability.fighting,
  Ability.strength
];

List<Ability> statPriorityListForClass(CharacterClass cc) {
  List<Ability> primary;
  List<Ability> secondary;

  switch (cc) {
    case CharacterClass.warrior:
      primary = new List.from(_warriorPrimary);
      secondary = new List.from(_warriorSecondary);
      break;

    case CharacterClass.expert:
      primary = new List.from(_expertPrimary);
      secondary = new List.from(_expertSecondary);
      break;

    case CharacterClass.adept:
      primary = new List.from(_adeptPrimary);
      secondary = new List.from(_adeptSecondary);
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
      return constitution + 30 + d6();

    default:
      return 1;
  }
}

applyClassBenefits(Character character) {
  character.weaponsGroups.addAll(getWeaponsGroupsFor(character));
  character.powers.addAll(getPowersFor(character.characterClass));
  character.talents.addAll(getTalentsFor(character));
}

const _warriorWeaponsGroups = const [
  WeaponsGroup.axes,
  WeaponsGroup.bludgeons,
  WeaponsGroup.bows,
  WeaponsGroup.lightBlades,
  WeaponsGroup.polearms,
  WeaponsGroup.staves
];

List<WeaponsGroup> getWeaponsGroupsFor(Character c) {
  if (c.race == Race.rhydan) {
    return new List.unmodifiable([]);
  }

  switch (c.characterClass) {
    case CharacterClass.adept:
      return new List.unmodifiable(
          [WeaponsGroup.staves, WeaponsGroup.brawling]);

    case CharacterClass.expert:
      return new List.unmodifiable([
        WeaponsGroup.bows,
        WeaponsGroup.brawling,
        WeaponsGroup.lightBlades,
        WeaponsGroup.staves
      ]);

    case CharacterClass.warrior:
      return new List.unmodifiable(
          drawN(_warriorWeaponsGroups, 3)..add(WeaponsGroup.brawling));

    default:
      return new List.unmodifiable([]);
  }
}

final _adeptTalents = new List<Talent>.unmodifiable([
  new Talent("Linguistics", Degree.novice,
      requirements: [new AbilityRequirement(Ability.intelligence, 1)]),
  new Talent("Lore", Degree.novice,
      requirements: [new AbilityRequirement(Ability.intelligence, 2)]),
  new Talent("Medicine", Degree.novice,
      requirements: [new AbilityRequirement(Ability.intelligence, 1)]),
  new Talent("Observation", Degree.novice,
      requirements: [new AbilityRequirement(Ability.perception, 2)])
]);

final _expertTalents = new List<Talent>.unmodifiable([
  new Talent("Animal training", Degree.novice),
  new Talent("Arcane potential", Degree.novice),
  new Talent("Carousing", Degree.novice, requirements: [
    new AbilityRequirement(Ability.communication, 1),
    new AbilityRequirement(Ability.constitution, 1)
  ]),
  new Talent("Contacts", Degree.novice,
      requirements: [new AbilityRequirement(Ability.communication, 2)]),
  new Talent("Intrigue", Degree.novice,
      requirements: [new AbilityRequirement(Ability.communication, 2)]),
  new Talent("Linguistics", Degree.novice,
      requirements: [new AbilityRequirement(Ability.intelligence, 1)]),
  new Talent("Medicine", Degree.novice,
      requirements: [new AbilityRequirement(Ability.intelligence, 1)]),
  new Talent("Oratory", Degree.novice),
  new Talent("Performance", Degree.novice),
  new Talent("Scouting", Degree.novice,
      requirements: [new AbilityRequirement(Ability.dexterity, 2)]),
  new Talent("Theivery", Degree.novice,
      requirements: [new AbilityRequirement(Ability.dexterity, 2)]),
]);

final _warriorTalents = new List<Talent>.unmodifiable([
  new Talent("Arcane potential", Degree.novice),
  new Talent("Carousing", Degree.novice, requirements: [
    new AbilityRequirement(Ability.communication, 1),
    new AbilityRequirement(Ability.constitution, 1)
  ]),
  new Talent("Quick reflexes", Degree.novice,
      requirements: [new AbilityRequirement(Ability.dexterity, 2)])
]);

final _styleTalents = new List<Talent>.unmodifiable([
  new Talent("Archery style", Degree.novice, requirements: [
    new WeaponsGroupsRequirement(["Bows"])
  ]),
  new Talent("Dual weapon style", Degree.novice,
      requirements: [new AbilityRequirement(Ability.dexterity, 1)]),
  new Talent("Single weapon style", Degree.novice,
      requirements: [new AbilityRequirement(Ability.perception, 1)]),
  new Talent("Thrown weapon style", Degree.novice, requirements: [
    new WeaponsGroupsRequirement(["Axes", "Light blades", "Polearms"])
  ]),
  new Talent("Two-handed weapon style", Degree.novice, requirements: [
    new AbilityRequirement(Ability.strength, 2),
    new WeaponsGroupsRequirement(
        ["Axes", "Bludgeons", "Heavy blades", "Polearms"])
  ]),
  new Talent("Unarmed style", Degree.novice),
  new Talent("Weapon and shield style", Degree.novice,
      requirements: [new AbilityRequirement(Ability.strength, 1)])
]);

List<Talent> getTalentsFor(Character c) {
  switch (c.characterClass) {
    case CharacterClass.adept:
      Talent first = drawWhere(arcaneTalents, c.canTake);
      Talent second =
          drawWhere(arcaneTalents.where(c.canTake), (t) => t != first);
      Talent third = drawWhere(_adeptTalents, c.canTake);

      return _listOfNonNull([first, second, third]);

    case CharacterClass.expert:
      return _listOfNonNull([drawWhere(_expertTalents, c.canTake)]);

    case CharacterClass.warrior:
      if (c.race == Race.rhydan) {
        return [
          drawFrom(_warriorTalents),
          new Talent("Armor training", Degree.novice),
          new Talent("Tooth and claw", Degree.novice),
        ];
      }

      return _listOfNonNull([
        drawWhere(_warriorTalents, c.canTake),
        drawWhere(_styleTalents, c.canTake),
        new Talent("Armor training", Degree.novice)
      ]);

    default:
      return _emptyList;
  }
}

const _emptyList = const [];

List<String> getPowersFor(CharacterClass cc) {
  switch (cc) {
    case CharacterClass.adept:
      return const [
        "May use the Skillful Channeling arcane "
            "stunt for 1 SP instead of 2 & when using "
            "Powerful Channeling you get +1 free SP (must spend at least 1 SP)"
      ];

    case CharacterClass.expert:
      return const [
        "Once per round, add 1d6 to the damage of a sucessful attack "
            "if your dex > your target's",
        "You are trained in Light Armor w/out need of the Armor Training talent"
      ];

    case CharacterClass.warrior:
      return _emptyList;

    default:
      return _emptyList;
  }
}

List<T> _listOfNonNull<T>(List<T> ts) {
  List<T> result = new List();
  for (var t in ts) {
    if (t != null) result.add(t);
  }

  return new List.unmodifiable(result);
}
