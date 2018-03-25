import 'package:blue_rose_character_creator/src/character/ability.dart';
import 'package:blue_rose_character_creator/src/character/character.dart';
import 'package:blue_rose_character_creator/src/character/character_class.dart';
import 'package:blue_rose_character_creator/src/character/focus.dart' as focus;
import 'package:blue_rose_character_creator/src/character/weapons_group.dart';

enum Degree { novice, journeyman, master }

class Talent {
  final String name;
  final Degree degree;
  final List<Requirement> requirements;

  const Talent._init(this.name, {this.degree=Degree.novice,
    this.requirements = const []});

  Talent improve() {
    return new Talent._init(name, degree: improveDegree(degree),
        requirements: requirements);
  }
}

const animalTraining = const Talent._init("Animal training");
const animism = const Talent._init("Animism", requirements: const [
  const ClassRequirement(const [CharacterClass.adept])
]);
const arcanePotential =
const Talent._init("Arcane potential", requirements: const [
  const ClassRequirement(const [CharacterClass.expert, CharacterClass.warrior])
]);
const arcaneTraining =
const Talent._init("Arcane training", requirements: const [
  const ClassRequirement(const [CharacterClass.adept])
]);
const armorTraining = const Talent._init("Armor training", requirements: const [
  const ClassRequirement(const [CharacterClass.warrior])
]);
const archeryStyle = const Talent._init("Archery style", requirements: const [
  const WeaponsGroupsRequirement(const [WeaponsGroup.bows])
]);
const artificer = const Talent._init("Artificer", requirements: const [
  const ClassRequirement(const [CharacterClass.adept]),
  const AbilityRequirement(Ability.dexterity, 2),
  const FocusRequirement(const [focus.artisan, focus.crafting])
]);
const carousing = const Talent._init("Carousing", requirements: const [
  const AbilityRequirement(Ability.communication, 1),
  const AbilityRequirement(Ability.constitution, 1)
]);
const command = const Talent._init("Command", requirements: const [
  const ClassRequirement(const [CharacterClass.adept, CharacterClass.warrior]),
  const AbilityRequirement(Ability.communication, 2)
]);
const contacts = const Talent._init("Contacts",
    requirements: const [const AbilityRequirement(Ability.communication, 1)]);
const dualWeaponStyle = const Talent._init("Dual weapon style",
    requirements: const [const AbilityRequirement(Ability.dexterity, 2)]);
const healing = const Talent._init("Healing", requirements: const [
  const ClassRequirement(const [CharacterClass.adept])
]);
const horsemanship = const Talent._init("Horesemanship", requirements: const [
  const FocusRequirement(const [focus.riding])
]);
const inspire = const Talent._init("Inspire",
    requirements: const [const AbilityRequirement(Ability.communication, 2)]);
const intrigue = const Talent._init("Intrigue",
    requirements: const [const AbilityRequirement(Ability.communication, 2)]);
const linguistics = const Talent._init("Linguistics",
    requirements: const [const AbilityRequirement(Ability.intelligence, 1)]);
const lore = const Talent._init("Lore",
    requirements: const [const AbilityRequirement(Ability.intelligence, 2)]);
const medicine = const Talent._init("Medicine",
    requirements: const [const AbilityRequirement(Ability.intelligence, 1)]);
const meditative = const Talent._init("Meditative", requirements: const [
  const ClassRequirement(const [CharacterClass.adept])
]);
const mountedCombatStyle =
const Talent._init("Mounted combat style", requirements: const [
  const ClassRequirement(const [CharacterClass.warrior])
]);
const observation = const Talent._init("Observation",
    requirements: const [const AbilityRequirement(Ability.perception, 2)]);
const oratory = const Talent._init("Oratory", requirements: const [
  const FocusRequirement(const [focus.persuasion])
]);
const performance = const Talent._init("Performance", requirements: const [
  const FocusRequirement(const [focus.performance, focus.musicalLore])
]);
const poleWeaponStyle =
const Talent._init("Pole weapon style", requirements: const [
  const WeaponsGroupsRequirement(const [WeaponsGroup.polearms])
]);
const psychic = const Talent._init("Psychic", requirements: const [
  const ClassRequirement(const [CharacterClass.adept])
]);
const purifyingLight =
const Talent._init("Purifying light", requirements: const [
  const AbilityRequirement(Ability.willpower, 2),
  const FocusRequirement(const [focus.faith])
]);
const quickReflexes = const Talent._init("Quick reflexes",
    requirements: const [const AbilityRequirement(Ability.dexterity, 2)]);
const scouting = const Talent._init("Scouting", requirements: const [
  const ClassRequirement(const [CharacterClass.expert]),
  const AbilityRequirement(Ability.dexterity, 2)
]);
const shaping = const Talent._init("Shaping", requirements: const [
  const ClassRequirement(const [CharacterClass.adept])
]);
const singleWeaponStyle =
const Talent._init("Single weapon style", requirements: const [
  const ClassRequirement(const [CharacterClass.expert, CharacterClass.warrior])
]);
const thievery = const Talent._init("Thievery", requirements: const [
  const ClassRequirement(const [CharacterClass.expert]),
  const AbilityRequirement(Ability.dexterity, 2)
]);
const thrownWeaponStyle =
const Talent._init("Thrown weapon style", requirements: const [
  const ClassRequirement(const [CharacterClass.expert, CharacterClass.warrior]),
  const WeaponsGroupsRequirement(const [
    WeaponsGroup.axes,
    WeaponsGroup.lightBlades,
    WeaponsGroup.polearms
  ])
]);
const toothAndClaw = const Talent._init("Tooth and claw", requirements: const [
  const WeaponsGroupsRequirement(const [WeaponsGroup.naturalWeapons])
]);
const twoHandedStyle = const Talent._init(
    "Two-handed style", requirements: const [
  const ClassRequirement(const [CharacterClass.warrior]),
  const AbilityRequirement(Ability.strength, 3),
  const WeaponsGroupsRequirement(const [
    WeaponsGroup.axes,
    WeaponsGroup.bludgeons,
    WeaponsGroup.heavyBlades,
    WeaponsGroup.polearms
  ])
]);
const unarmedStyle = const Talent._init("Unarmed style", requirements: const [
  const WeaponsGroupsRequirement(const [WeaponsGroup.brawling])
]);
const visionary = const Talent._init("Visionary", requirements: const [
  const ClassRequirement(const [CharacterClass.adept])
]);
const weaponAndShieldStyle = const Talent._init("Weapon and shield style", requirements: const [
  const ClassRequirement(const [CharacterClass.warrior]),
  const AbilityRequirement(Ability.strength, 2)
]);
const wildArcane = const Talent._init("Wild arcane");

final arcaneTalents = new List<Talent>.unmodifiable([
  animism,
  arcaneTraining,
  healing,
  meditative,
  shaping,
  psychic,
  visionary,
  wildArcane,
]);

String degreeToString(Degree degree) {
  switch (degree) {
    case Degree.novice:
      return "Novice";
    case Degree.journeyman:
      return "Journeyman";
    case Degree.master:
      return "Master";
    default:
      return "";
  }
}

Degree improveDegree(Degree old) {
  switch(old) {
    case Degree.novice:
      return Degree.journeyman;
    case Degree.journeyman:
      return Degree.master;
    default:
      throw "You cannot improve on $old";
  }
}

abstract class Requirement {
  bool isMetBy(Character character);

  const Requirement();
}

///Requirement that the character have a minimum bonus for an ability.
class AbilityRequirement extends Requirement {
  final Ability ability;
  final int bonus;

  const AbilityRequirement(this.ability, this.bonus);

  @override
  bool isMetBy(Character character) => character.abilities[ability] >= bonus;
}

///Requirement that requires that the character have one of the groups listed
class WeaponsGroupsRequirement extends Requirement {
  final List<WeaponsGroup> weaponsGroups;

  const WeaponsGroupsRequirement(this.weaponsGroups);

  @override
  bool isMetBy(Character character) =>
      _anyIntersection(weaponsGroups, character.weaponsGroups);
}

bool _anyIntersection<T>(List<T> first, List<T> second) =>
    first.map(second.contains).fold(false, (a, b) => a || b);

///Requirement that the character have one of the classes listed
class ClassRequirement extends Requirement {
  final List<CharacterClass> classes;

  const ClassRequirement(this.classes);

  @override
  bool isMetBy(Character character) =>
      classes.contains(character.characterClass);
}

class FocusRequirement extends Requirement {
  final List<focus.Focus> focuses;

  const FocusRequirement(this.focuses);

  @override
  bool isMetBy(Character character) => focuses.any(character.hasFocus);
}
