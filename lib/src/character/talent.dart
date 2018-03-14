import 'package:blue_rose_character_creator/src/character/ability.dart';

enum Degree {
  novice, journeyman, master
}

class Talent {
  final String name;
  final Degree degree;
  final Ability requiredAbility;
  final int requiredBonus;

  Talent(this.name, this.degree, {this.requiredAbility, this.requiredBonus});
}