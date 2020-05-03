import 'ability.dart';
import 'character.dart';
import 'character_class.dart';
import 'focus.dart' as focus;
import 'weapons_group.dart';

enum Degree { novice, journeyman, master }

class Talent {
  final String name;
  final Degree degree;
  final List<Requirement> requirements;

  const Talent._(this.name,
      {this.degree = Degree.novice, this.requirements = const []});

  Talent improve() {
    return Talent._(name,
        degree: improveDegree(degree), requirements: requirements);
  }

  @override
  String toString() => '$name (${degreeToString(degree)})';
}

const animalTraining = Talent._("Animal training");
const animism = Talent._("Animism", requirements: [
  ClassRequirement([CharacterClass.adept])
]);
const arcanePotential = Talent._("Arcane potential", requirements: [
  ClassRequirement([CharacterClass.expert, CharacterClass.warrior])
]);
const arcaneTraining = Talent._("Arcane training", requirements: [
  ClassRequirement([CharacterClass.adept])
]);
const armorTraining = Talent._("Armor training", requirements: [
  ClassRequirement([CharacterClass.warrior])
]);
const archeryStyle = Talent._("Archery style", requirements: [
  WeaponsGroupsRequirement([WeaponsGroup.bows])
]);
const artificer = Talent._("Artificer", requirements: [
  ClassRequirement([CharacterClass.adept]),
  AbilityRequirement(Ability.dexterity, 2),
  FocusRequirement([focus.artisan, focus.crafting])
]);
const carousing = Talent._("Carousing", requirements: [
  AbilityRequirement(Ability.communication, 1),
  AbilityRequirement(Ability.constitution, 1)
]);
const command = Talent._("Command", requirements: [
  ClassRequirement([CharacterClass.adept, CharacterClass.warrior]),
  AbilityRequirement(Ability.communication, 2)
]);
const contacts = Talent._("Contacts",
    requirements: [AbilityRequirement(Ability.communication, 1)]);
const dualWeaponStyle = Talent._("Dual weapon style",
    requirements: [AbilityRequirement(Ability.dexterity, 2)]);
const healing = Talent._("Healing", requirements: [
  ClassRequirement([CharacterClass.adept])
]);
const horsemanship = Talent._("Horesemanship", requirements: [
  FocusRequirement([focus.riding])
]);
const inspire = Talent._("Inspire",
    requirements: [AbilityRequirement(Ability.communication, 2)]);
const intrigue = Talent._("Intrigue",
    requirements: [AbilityRequirement(Ability.communication, 2)]);
const linguistics = Talent._("Linguistics",
    requirements: [AbilityRequirement(Ability.intelligence, 1)]);
const lore = Talent._("Lore",
    requirements: [AbilityRequirement(Ability.intelligence, 2)]);
const medicine = Talent._("Medicine",
    requirements: [AbilityRequirement(Ability.intelligence, 1)]);
const meditative = Talent._("Meditative", requirements: [
  ClassRequirement([CharacterClass.adept])
]);
const mountedCombatStyle = Talent._("Mounted combat style", requirements: [
  ClassRequirement([CharacterClass.warrior])
]);
const observation = Talent._("Observation",
    requirements: [AbilityRequirement(Ability.perception, 2)]);
const oratory = Talent._("Oratory", requirements: [
  FocusRequirement([focus.persuasion])
]);
const performance = Talent._("Performance", requirements: [
  FocusRequirement([focus.performance, focus.musicalLore])
]);
const poleWeaponStyle = Talent._("Pole weapon style", requirements: [
  WeaponsGroupsRequirement([WeaponsGroup.polearms])
]);
const psychic = Talent._("Psychic", requirements: [
  ClassRequirement([CharacterClass.adept])
]);
const purifyingLight = Talent._("Purifying light", requirements: [
  AbilityRequirement(Ability.willpower, 2),
  FocusRequirement([focus.faith])
]);
const quickReflexes = Talent._("Quick reflexes",
    requirements: [AbilityRequirement(Ability.dexterity, 2)]);
const scouting = Talent._("Scouting", requirements: [
  ClassRequirement([CharacterClass.expert]),
  AbilityRequirement(Ability.dexterity, 2)
]);
const shaping = Talent._("Shaping", requirements: [
  ClassRequirement([CharacterClass.adept])
]);
const singleWeaponStyle = Talent._("Single weapon style", requirements: [
  ClassRequirement([CharacterClass.expert, CharacterClass.warrior])
]);
const thievery = Talent._("Thievery", requirements: [
  ClassRequirement([CharacterClass.expert]),
  AbilityRequirement(Ability.dexterity, 2)
]);
const thrownWeaponStyle = Talent._("Thrown weapon style", requirements: [
  ClassRequirement([CharacterClass.expert, CharacterClass.warrior]),
  WeaponsGroupsRequirement(
      [WeaponsGroup.axes, WeaponsGroup.lightBlades, WeaponsGroup.polearms])
]);
const toothAndClaw = Talent._("Tooth and claw", requirements: [
  WeaponsGroupsRequirement([WeaponsGroup.naturalWeapons])
]);
const twoHandedStyle = Talent._("Two-handed style", requirements: [
  ClassRequirement([CharacterClass.warrior]),
  AbilityRequirement(Ability.strength, 3),
  WeaponsGroupsRequirement([
    WeaponsGroup.axes,
    WeaponsGroup.bludgeons,
    WeaponsGroup.heavyBlades,
    WeaponsGroup.polearms
  ])
]);
const unarmedStyle = Talent._("Unarmed style", requirements: [
  WeaponsGroupsRequirement([WeaponsGroup.brawling])
]);
const visionary = Talent._("Visionary", requirements: [
  ClassRequirement([CharacterClass.adept])
]);
const weaponAndShieldStyle = Talent._("Weapon and shield style", requirements: [
  ClassRequirement([CharacterClass.warrior]),
  AbilityRequirement(Ability.strength, 2)
]);
const wildArcane = Talent._("Wild arcane");

const arcaneTalents = <Talent>[
  animism,
  arcaneTraining,
  healing,
  meditative,
  shaping,
  psychic,
  visionary,
  wildArcane,
];

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
  switch (old) {
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
