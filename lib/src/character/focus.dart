import 'package:blue_rose_character_creator/src/character/ability.dart';

///Models a single character focus: i.e. Dexterity(Horseback riding)
class Focus {
  ///Ability focus applies to
  final Ability ability;

  /**
   * String describing focus domain, i.e. "horseback riding".
   * The part in parentheses in game notation.
   */
  final String domain;

  ///If the focus has been improved (+2 -> +3)
  final bool improved;

  ///Bonus applied by the focus
  int get bonus => improved ? 3 : 2;

  const Focus(this.ability, this.domain, {this.improved=false});
}
