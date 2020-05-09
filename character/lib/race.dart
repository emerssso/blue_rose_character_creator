import 'ability.dart';
import 'benefit.dart';
import 'character.dart';
import 'dice.dart';
import 'focus.dart';
import 'talent.dart';
import 'weapons_group.dart';

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

  _fixedBenefits[character.race](character);
}

//contains benefits that always apply to a character of a specific race.
const _fixedBenefits = {
  Race.human: _humanBenefits,
  Race.nightPerson: _nightPeopleBenefits,
  Race.rhydan: _rhydanBenefits,
  Race.seaFolk: _seaFolkBenefits,
  Race.vata:  _vataBenefits,
};

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
    character.addFocus(flipCoin() ? first : second);
