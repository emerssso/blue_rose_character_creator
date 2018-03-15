import 'package:blue_rose_character_creator/src/character/ability.dart';

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

class Requirement {
  final Ability ability;
  final int bonus;

  Requirement(this.ability, this.bonus);
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