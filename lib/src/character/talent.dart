import 'package:blue_rose_character_creator/src/character/ability.dart';
import 'package:blue_rose_character_creator/src/character/character.dart';

enum Degree {
  novice, journeyman, master
}

class Talent {
  final String name;
  final Degree degree;
  final List<Requirement> requirements;

  const Talent(this.name, this.degree, {List<Requirement> requirements}) :
        requirements = requirements ?? const [];
}

const animism = const Talent("Animism", Degree.novice);
const arcaneTraining = const Talent("Arcane training", Degree.novice);
const healing = const Talent("Healing", Degree.novice);
const meditative = const Talent("Meditative", Degree.novice);
const shaping = const Talent("Shaping", Degree.novice);
const psychic = const Talent("Psychic", Degree.novice);
const visionary = const Talent("Visionary", Degree.novice);
const wildArcane = const Talent("Wild arcane", Degree.novice);
const arcanePotential = const Talent("Arcane potential", Degree.novice);

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
  switch(degree) {
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
  final List<String> weaponsGroups;

  const WeaponsGroupsRequirement(this.weaponsGroups);

  @override
  bool isMetBy(Character character) => 
      _anyIntersection(weaponsGroups, character.weaponsGroups);
}

bool _anyIntersection<T>(List<T> first, List<T> second) => 
    first.map(second.contains).fold(false, (a, b) => a || b);
