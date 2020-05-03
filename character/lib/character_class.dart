import 'dart:math';

import 'ability.dart';
import 'character.dart';
import 'dice.dart';
import 'race.dart';
import 'talent.dart';
import 'weapons_group.dart';

/// The three Blue Rose character classes
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

List<Ability> primaryFor(CharacterClass cc) {
  switch (cc) {
    case CharacterClass.warrior:
      return _warriorPrimary;
    case CharacterClass.expert:
      return _expertPrimary;
    case CharacterClass.adept:
      return _adeptPrimary;
    default:
      return const [];
  }
}

List<Ability> secondaryFor(CharacterClass cc) {
  switch (cc) {
    case CharacterClass.warrior:
      return _warriorSecondary;
    case CharacterClass.expert:
      return _expertSecondary;
    case CharacterClass.adept:
      return _adeptSecondary;
    default:
      return const [];
  }
}

const List<Ability> _warriorPrimary = [
  Ability.constitution,
  Ability.dexterity,
  Ability.fighting,
  Ability.strength
];
const List<Ability> _warriorSecondary = [
  Ability.accuracy,
  Ability.communication,
  Ability.intelligence,
  Ability.perception,
  Ability.willpower
];

const List<Ability> _expertPrimary = [
  Ability.accuracy,
  Ability.communication,
  Ability.dexterity,
  Ability.perception
];
const List<Ability> _expertSecondary = [
  Ability.constitution,
  Ability.fighting,
  Ability.intelligence,
  Ability.strength,
  Ability.willpower
];

const List<Ability> _adeptPrimary = [
  Ability.accuracy,
  Ability.intelligence,
  Ability.perception,
  Ability.willpower
];
const List<Ability> _adeptSecondary = [
  Ability.communication,
  Ability.constitution,
  Ability.dexterity,
  Ability.fighting,
  Ability.strength
];

List<Ability> statPriorityListForClass(CharacterClass cc) {
  var primary = List.of(primaryFor(cc));
  var secondary = List.of(secondaryFor(cc));
  primary.shuffle(rng);
  secondary.shuffle(rng);

  return primary..addAll(secondary);
}

int getHealthFor(CharacterClass cc, {int constitution = 0, int level = 1}) =>
    (_baseHealth[cc] ?? 1) + (level * constitution) + max(level, 10).d6;

const _baseHealth = {
  CharacterClass.adept: 20,
  CharacterClass.expert: 15,
  CharacterClass.warrior: 30,
};

applyClassBenefits(Character character) {
  character.weaponsGroups.addAll(getWeaponsGroupsFor(character));
  character.powers.addAll(getPowersFor(character.characterClass));
  character.talents.addAll(getTalentsFor(character));
}

const _warriorWeaponsGroups = [
  WeaponsGroup.axes,
  WeaponsGroup.bludgeons,
  WeaponsGroup.bows,
  WeaponsGroup.lightBlades,
  WeaponsGroup.polearms,
  WeaponsGroup.staves
];

List<WeaponsGroup> getWeaponsGroupsFor(Character c) {
  if (c.race == Race.rhydan) {
    return const [];
  }

  switch (c.characterClass) {
    case CharacterClass.adept:
      return const [WeaponsGroup.staves, WeaponsGroup.brawling];

    case CharacterClass.expert:
      return const [
        WeaponsGroup.bows,
        WeaponsGroup.brawling,
        WeaponsGroup.lightBlades,
        WeaponsGroup.staves
      ];

    case CharacterClass.warrior:
      return List.unmodifiable(
          drawN(3, _warriorWeaponsGroups)..add(WeaponsGroup.brawling));

    default:
      return const [];
  }
}

const _adeptTalents = [linguistics, lore, medicine, observation];

const _expertTalents = [
  arcanePotential,
  animalTraining,
  carousing,
  contacts,
  intrigue,
  linguistics,
  medicine,
  oratory,
  performance,
  scouting,
  thievery
];

const _warriorTalents = [arcanePotential, carousing, quickReflexes];

const _styleTalents = [
  archeryStyle,
  dualWeaponStyle,
  singleWeaponStyle,
  thrownWeaponStyle,
  twoHandedStyle,
  unarmedStyle,
  weaponAndShieldStyle
];

List<Talent> getTalentsFor(Character c) {
  switch (c.characterClass) {
    case CharacterClass.adept:
      Talent first = drawWhere(arcaneTalents, c.canTake);

      final safeSecond = (Talent talent) =>
          c.canTake(talent) &&
          talent != first &&
          _notBothWeirdArcaneTalents(first, talent);

      Talent second = drawWhere(arcaneTalents, safeSecond);
      Talent third = drawWhere(_adeptTalents, c.canTake);

      return _listOfNonNull([first, second, third]);

    case CharacterClass.expert:
      return _listOfNonNull([drawWhere(_expertTalents, c.canTake)]);

    case CharacterClass.warrior:
      if (c.race == Race.rhydan) {
        return [
          drawFrom(_warriorTalents),
          armorTraining,
          toothAndClaw,
        ];
      }

      return _listOfNonNull([
        drawWhere(_warriorTalents, c.canTake),
        drawWhere(_styleTalents, c.canTake),
        armorTraining
      ]);

    default:
      return const [];
  }
}

// These two talents work badly together, so we just make sure characters can't
// have both
const _weirdArcaneTalents = [arcaneTraining, wildArcane];

bool _notBothWeirdArcaneTalents(Talent one, Talent two) =>
    !_weirdArcaneTalents.contains(one) || !_weirdArcaneTalents.contains(two);

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
      return const [];

    default:
      return const [];
  }
}

List<T> _listOfNonNull<T>(List<T> ts) {
  List<T> result = List();
  for (var t in ts) {
    if (t != null) result.add(t);
  }

  return List.unmodifiable(result);
}
