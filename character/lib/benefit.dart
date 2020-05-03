import 'ability.dart';
import 'character.dart';
import 'dice.dart';
import 'focus.dart';
import 'race.dart';
import 'weapons_group.dart';

///Models a benefit from a race as an operation to apply it to a character.
typedef Benefit = void Function(Character);

///Returns a random benefit for the passed race
Benefit randomBenefitFor(Race race) {
  var benefits = _raceBenefits[race];
  if(benefits == null) throw "Benefits requested for Unknown race";
  return _randomBenefitFrom(benefits);
}

Benefit _randomBenefitFrom(Map<int, Benefit> benefits) =>
    benefits[2.d6] ?? _emptyBenefit;

const _raceBenefits = {
  Race.human: _humanBenefits,
  Race.nightPerson: _nightPeopleBenefits,
  Race.rhydan: _rhydanBenefits,
  Race.seaFolk: _seaFolkBenefits,
  Race.vata: _vataBenefits,
};

//Used if benefit goes wrong some how
void _emptyBenefit(Character c) => throw "Empty Benefit applied!";

//shorthand operations for reused benefits
void _accuracy(Character c) => c.increase(Ability.accuracy);

void _communication(Character c) => c.increase(Ability.communication);

void _constitution(Character c) => c.increase(Ability.constitution);

void _dexterity(Character c) => c.increase(Ability.dexterity);

void _fighting(Character c) => c.increase(Ability.fighting);

void _intelligence(Character c) => c.increase(Ability.intelligence);

void _perception(Character c) => c.increase(Ability.perception);

void _strength(Character c) => c.increase(Ability.strength);

void _willpower(Character c) => c.increase(Ability.willpower);

void _brawling(Character c) => c.addFocus(brawling);

void _naturalWeapon(Character c) => c.addFocus(naturalWeapon);

void _deception(Character c) => c.addFocus(deception);

void _persuasion(Character c) => c.addFocus(persuasion);

void _stamina(Character c) => c.addFocus(stamina);

void _searching(Character c) => c.addFocus(searching);

void _smelling(Character c) => c.addFocus(smelling);

void _psychic(Character c) => c.addFocus(psychicPerception);

void _hearing(Character c) => c.addFocus(hearing);

void _seeing(Character c) => c.addFocus(seeing);

void _stealth(Character c) => c.addFocus(stealth);

void _acrobatics(Character c) => c.addFocus(acrobatics);

void _intimidation(Character c) => c.addFocus(intimidation);

void _naturalLore(Character c) => c.addFocus(naturalLore);

void _historicalLore(Character c) => c.addFocus(historicalLore);

void _culturalLore(Character c) => c.addFocus(culturalLore);

void _bludgeons(Character c) => c.weaponsGroups.add(WeaponsGroup.brawling);

void _polearms(Character c) => c.weaponsGroups.add(WeaponsGroup.polearms);

void _lightBlades(Character c) => c.weaponsGroups.add(WeaponsGroup.lightBlades);

const _humanBenefits = {
  2: _intelligence,
  3: _stamina,
  4: _stamina,
  5: _searching,
  6: _deception,
  7: _constitution,
  8: _constitution,
  9: _persuasion,
  10: _brawling,
  11: _brawling,
  12: _strength,
};

const _nightPeopleBenefits = {
  2:  _constitution,
  3: _smelling,
  4: _smelling,
  5: _stealth,
  6: _intimidation,
  7: _fighting,
  8: _fighting,
  9: _bludgeons,
  10: _brawling,
  11: _brawling,
  12: _willpower,
};

const _rhydanBenefits = {
  2: _dexterity,
  3: _smelling,
  4: _smelling,
  5: _stealth,
  6: _intimidation,
  7: _perception,
  8: _perception,
  9: _psychic,
  10: _naturalWeapon,
  11: _naturalWeapon,
  12:  _willpower,
};

const _seaFolkBenefits = {
  2: _accuracy,
  3: _naturalLore,
  4: _naturalLore,
  5: _hearing,
  6: _polearms,
  7: _dexterity,
  8: _dexterity,
  9: _historicalLore,
  10: _acrobatics,
  11: _acrobatics,
  12: _perception
};

const _vataBenefits = {
  2: _communication,
  3: _culturalLore,
  4: _culturalLore,
  5: _seeing,
  6: _lightBlades,
  7: _accuracy,
  8: _accuracy,
  9: _historicalLore,
  10: _persuasion,
  11: _persuasion,
  12: _perception,
};
