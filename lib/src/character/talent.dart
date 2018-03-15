import 'package:blue_rose_character_creator/src/character/ability.dart';
import 'package:blue_rose_character_creator/src/character/character.dart';

enum Degree {
  novice, journeyman, master
}

class Talent {
  final String name;
  final Degree degree;
  final List<Requirement> requirements;

  Talent(this.name, this.degree, {List<Requirement> requirements}) :
      requirements = requirements != null
          ? new List.unmodifiable(requirements)
          : new List.unmodifiable([]) {}
}

List<Talent> arcaneTalents = new List.unmodifiable([
  new Talent("Animism", Degree.novice),
  new Talent("Arcane Training", Degree.novice),
  new Talent("Healing", Degree.novice),
  new Talent("Meditative", Degree.novice),
  new Talent("Shaping", Degree.novice),
  new Talent("Psychic", Degree.novice),
  new Talent("Visionary", Degree.novice),
  new Talent("Wild Arcane", Degree.novice),
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
}

///Requirement that the character have a minimum bonus for an ability.
class AbilityRequirement extends Requirement {
  final Ability ability;
  final int bonus;

  AbilityRequirement(this.ability, this.bonus);

  @override
  bool isMetBy(Character character) => character.abilities[ability] >= bonus;
}

///Requirement that requires that the character have one of the groups listed
class WeaponsGroupsRequirement extends Requirement {
  final List<String> weaponsGroups;

  WeaponsGroupsRequirement(this.weaponsGroups);

  @override
  bool isMetBy(Character character) {
    for(var group in weaponsGroups) {
      if(character.weaponsGroups.contains(group)) {
        return true;
      }
    }

    return false;
  }
}