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

  const Talent._init(this.name,
      {this.degree = Degree.novice, this.requirements = const []});

  Talent improve() {
    return Talent._init(name,
        degree: improveDegree(degree), requirements: requirements);
  }
}

const animalTraining = Talent._init("Animal training");
const animism = Talent._init("Animism", requirements: [
  ClassRequirement([CharacterClass.adept])
]);
const arcanePotential = Talent._init("Arcane potential", requirements: [
  ClassRequirement([CharacterClass.expert, CharacterClass.warrior])
]);
const arcaneTraining = Talent._init("Arcane training", requirements: [
  ClassRequirement([CharacterClass.adept])
]);
const armorTraining = Talent._init("Armor training", requirements: [
  ClassRequirement([CharacterClass.warrior])
]);
const archeryStyle = Talent._init("Archery style", requirements: [
  WeaponsGroupsRequirement([WeaponsGroup.bows])
]);
const artificer = Talent._init("Artificer", requirements: [
  ClassRequirement([CharacterClass.adept]),
  AbilityRequirement(Ability.dexterity, 2),
  FocusRequirement([focus.artisan, focus.crafting])
]);
const carousing = Talent._init("Carousing", requirements: [
  AbilityRequirement(Ability.communication, 1),
  AbilityRequirement(Ability.constitution, 1)
]);
const command = Talent._init("Command", requirements: [
  ClassRequirement([CharacterClass.adept, CharacterClass.warrior]),
  AbilityRequirement(Ability.communication, 2)
]);
const contacts = Talent._init("Contacts",
    requirements: [AbilityRequirement(Ability.communication, 1)]);
const dualWeaponStyle = Talent._init("Dual weapon style",
    requirements: [AbilityRequirement(Ability.dexterity, 2)]);
const healing = Talent._init("Healing", requirements: [
  ClassRequirement([CharacterClass.adept])
]);
const horsemanship = Talent._init("Horesemanship", requirements: [
  FocusRequirement([focus.riding])
]);
const inspire = Talent._init("Inspire",
    requirements: [AbilityRequirement(Ability.communication, 2)]);
const intrigue = Talent._init("Intrigue",
    requirements: [AbilityRequirement(Ability.communication, 2)]);
const linguistics = Talent._init("Linguistics",
    requirements: [AbilityRequirement(Ability.intelligence, 1)]);
const lore = Talent._init("Lore",
    requirements: [AbilityRequirement(Ability.intelligence, 2)]);
const medicine = Talent._init("Medicine",
    requirements: [AbilityRequirement(Ability.intelligence, 1)]);
const meditative = Talent._init("Meditative", requirements: [
  ClassRequirement([CharacterClass.adept])
]);
const mountedCombatStyle = Talent._init("Mounted combat style", requirements: [
  ClassRequirement([CharacterClass.warrior])
]);
const observation = Talent._init("Observation",
    requirements: [AbilityRequirement(Ability.perception, 2)]);
const oratory = Talent._init("Oratory", requirements: [
  FocusRequirement([focus.persuasion])
]);
const performance = Talent._init("Performance", requirements: [
  FocusRequirement([focus.performance, focus.musicalLore])
]);
const poleWeaponStyle = Talent._init("Pole weapon style", requirements: [
  WeaponsGroupsRequirement([WeaponsGroup.polearms])
]);
const psychic = Talent._init("Psychic", requirements: [
  ClassRequirement([CharacterClass.adept])
]);
const purifyingLight = Talent._init("Purifying light", requirements: [
  AbilityRequirement(Ability.willpower, 2),
  FocusRequirement([focus.faith])
]);
const quickReflexes = Talent._init("Quick reflexes",
    requirements: [AbilityRequirement(Ability.dexterity, 2)]);
const scouting = Talent._init("Scouting", requirements: [
  ClassRequirement([CharacterClass.expert]),
  AbilityRequirement(Ability.dexterity, 2)
]);
const shaping = Talent._init("Shaping", requirements: [
  ClassRequirement([CharacterClass.adept])
]);
const singleWeaponStyle = Talent._init("Single weapon style", requirements: [
  ClassRequirement([CharacterClass.expert, CharacterClass.warrior])
]);
const thievery = Talent._init("Thievery", requirements: [
  ClassRequirement([CharacterClass.expert]),
  AbilityRequirement(Ability.dexterity, 2)
]);
const thrownWeaponStyle = Talent._init("Thrown weapon style", requirements: [
  ClassRequirement([CharacterClass.expert, CharacterClass.warrior]),
  WeaponsGroupsRequirement(
      [WeaponsGroup.axes, WeaponsGroup.lightBlades, WeaponsGroup.polearms])
]);
const toothAndClaw = Talent._init("Tooth and claw", requirements: [
  WeaponsGroupsRequirement([WeaponsGroup.naturalWeapons])
]);
const twoHandedStyle = Talent._init("Two-handed style", requirements: [
  ClassRequirement([CharacterClass.warrior]),
  AbilityRequirement(Ability.strength, 3),
  WeaponsGroupsRequirement([
    WeaponsGroup.axes,
    WeaponsGroup.bludgeons,
    WeaponsGroup.heavyBlades,
    WeaponsGroup.polearms
  ])
]);
const unarmedStyle = Talent._init("Unarmed style", requirements: [
  WeaponsGroupsRequirement([WeaponsGroup.brawling])
]);
const visionary = Talent._init("Visionary", requirements: [
  ClassRequirement([CharacterClass.adept])
]);
const weaponAndShieldStyle =
Talent._init("Weapon and shield style", requirements: [
  ClassRequirement([CharacterClass.warrior]),
  AbilityRequirement(Ability.strength, 2)
]);
const wildArcane = Talent._init("Wild arcane");

final arcaneTalents = List<Talent>.unmodifiable([
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
