import 'ability.dart';
import 'character.dart';
import 'dice.dart';
import 'race.dart';
import 'talent.dart';
import 'weapons_group.dart';

/// Models the three Blue Rose Classes as an enum
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
  List<Ability> primary;
  List<Ability> secondary;

  switch (cc) {
    case CharacterClass.warrior:
      primary = List.from(_warriorPrimary);
      secondary = List.from(_warriorSecondary);
      break;

    case CharacterClass.expert:
      primary = List.from(_expertPrimary);
      secondary = List.from(_expertSecondary);
      break;

    case CharacterClass.adept:
      primary = List.from(_adeptPrimary);
      secondary = List.from(_adeptSecondary);
      break;

    case CharacterClass.unknown:
      primary = List<Ability>();
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
      return constitution + 20 + d6;

    case CharacterClass.expert:
      return constitution + 15 + d6;

    case CharacterClass.warrior:
      return constitution + 30 + d6;

    default:
      return 1;
  }
}

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
