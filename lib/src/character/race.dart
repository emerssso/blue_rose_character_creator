import 'package:blue_rose_character_creator/src/character/ability.dart';
import 'package:blue_rose_character_creator/src/character/benefit.dart';
import 'package:blue_rose_character_creator/src/character/character.dart';
import 'package:blue_rose_character_creator/src/character/dice.dart';
import 'package:blue_rose_character_creator/src/character/focus.dart';
import 'package:blue_rose_character_creator/src/character/talent.dart';
import 'package:blue_rose_character_creator/src/character/weapons_group.dart';

enum Race { human, nightPerson, rhydan, seaFolk, vata, unknown }

String raceToString(Race race) {
  switch (race) {
    case Race.human:
      return "Human";
    case Race.nightPerson:
      return "Night Person";
    case Race.rhydan:
      return "Rhydan";
    case Race.seaFolk:
      return "Sea-folk";
    case Race.vata:
      return "Vata";
    case Race.unknown:
    default:
      return "Race";
  }
}

///Applies all racial benefits to the passed character based on it's race.
void applyRacialBenefits(Character character) {
  Benefit firstBenefit = randomBenefitFor(character.race);
  Benefit secondBenefit = randomBenefitFor(character.race);

  while (firstBenefit == secondBenefit) {
    secondBenefit = randomBenefitFor(character.race);
  }

  firstBenefit(character);
  secondBenefit(character);

  _applyFixedBenefits(character);
}

void _applyFixedBenefits(Character character) {
  _fixedBenefits[character.race](character);
}

//contains benefits that always apply to a character of a specific race.
Map<Race, Benefit> _fixedBenefits = Map.unmodifiable(Map.fromIterables([
  Race.human,
  Race.nightPerson,
  Race.rhydan,
  Race.seaFolk,
  Race.vata
], [
  _humanBenefits,
  _nightPeopleBenefits,
  _rhydanBenefits,
  _seaFolkBenefits,
  _vataBenefits
]));

void _humanBenefits(Character character) {
  character.increase(drawFrom(Ability.values));

  addRandomFocus(riding, swimming, character);
}

void _nightPeopleBenefits(Character character) {
  character.increase(Ability.strength);

  addRandomFocus(stamina, might, character);

  character.powers.add("Dark sight (30 yards in darkness), "
      "but you are blinded for one round when exposed to daylight");
}

void _rhydanBenefits(Character character) {
  addRandomFocus(
      naturalLore,
      drawWithoutRepeats(
          perceptionFocuses, character.focuses[Ability.perception] ?? const []),
      character);

  character.weaponsGroups.add(WeaponsGroup.naturalWeapons);
  character.weaponsGroups.add(WeaponsGroup.brawling);

  character.talents.add(psychic);
}

void _seaFolkBenefits(Character character) {
  character.increase(Ability.constitution);
  character.addFocus(swimming);
  character.powers.add("Dark sight (20 yards in darkness)");
  character.powers.add("Can hold breath "
      "${60 + 6 * character.constitution} rounds");
  character.powers.add(" swim at your Speed as a minor action (twice"
      "your Speed as a major action)");
}

void _vataBenefits(Character character) {
  character.talents.add(drawWhere(arcaneTalents, (t) => t != wildArcane));

  //TODO: improve once backgrounds are added
  character.powers.add("Dark sight (20 yards for vata'an, 30 for vata'sha), "
      "vata'sha are blinded for one round in sudden daylight");

  character.powers.add("Constitution is considered 2 points higher "
      "for any of the recovery formulas");
}

void addRandomFocus(Focus first, Focus second, Character character) =>
    character.addFocus(coinFlip() ? first : second);
