import 'package:blue_rose_character_creator/src/character/ability.dart';

enum Degree {
  novice, journeyman, master
}

class Talent {
  final String name;
  final Degree degree;
  final Ability requiredAbility;
  final int requiredBonus;

  Talent(this.name, this.degree, {this.requiredAbility, this.requiredBonus=-1});
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