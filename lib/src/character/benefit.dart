import 'package:blue_rose_character_creator/src/character/ability.dart';
import 'package:blue_rose_character_creator/src/character/character.dart';
import 'package:blue_rose_character_creator/src/character/dice.dart';
import 'package:blue_rose_character_creator/src/character/focus.dart';
import 'package:blue_rose_character_creator/src/character/race.dart';

///Models a benefit from a race as an operation to apply it to a character.
typedef void Benefit(Character);

///Returns a random benefit for the passed race
Benefit randomBenefitFor(Race race) => _randomBenefitFrom(_benefitsFor(race));

Benefit _randomBenefitFrom(Map<int, Benefit> benefits) =>
    benefits[Xd6(2)] ?? _emptyBenefit;

// ignore: missing_return
Map<int, Benefit> _benefitsFor(Race race) {
    switch(race) {
        case Race.human: return _humanBenefits;
        case Race.nightPerson: return _nightPeopleBenefits;
        case Race.rhydan: return _rhydanBenefits;
        case Race.seaFolk: return _seaFolkBenefits;
        case Race.vata: return _vataBenefits;
        case Race.unknown: throw "Benefits requested for Unknown race";
    }
}

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

void _brawling(Character c) =>
    c.addFocus(new Focus(Ability.accuracy, "Brawling"));
void _naturalWeapon(Character c) =>
    c.addFocus(new Focus(Ability.accuracy, "Natural weapon (pick one)"));
void _deception(Character c) =>
    c.addFocus(new Focus(Ability.communication, "Deception"));
void _persuasion(Character c) =>
    c.addFocus(new Focus(Ability.communication, "Persuasion"));
void _stamina(Character c) =>
    c.addFocus(new Focus(Ability.constitution, "Stamina"));
void _searching(Character c) =>
    c.addFocus(new Focus(Ability.perception, "Searching"));
void _smelling(Character c) =>
    c.addFocus(new Focus(Ability.perception, "Smelling"));
void _psychic(Character c) =>
    c.addFocus(new Focus(Ability.perception, "Psychic"));
void _hearing(Character c) =>
    c.addFocus(new Focus(Ability.perception, "Hearing"));
void _seeing(Character c) =>
    c.addFocus(new Focus(Ability.perception, "Seeing"));
void _stealth(Character c) =>
    c.addFocus(new Focus(Ability.dexterity, "Stealth"));
void _acrobatics(Character c) =>
    c.addFocus(new Focus(Ability.dexterity, "Acrobatics"));
void _intimidation(Character c) =>
    c.addFocus(new Focus(Ability.strength, "Intimidation"));
void _naturalLore(Character c) =>
    c.addFocus(new Focus(Ability.intelligence, "Natural lore"));
void _historicalLore(Character c) =>
    c.addFocus(new Focus(Ability.intelligence, "Historical lore"));
void _culturalLore(Character c) =>
    c.addFocus(new Focus(Ability.intelligence, "Cultural lore"));

void _bludgeons(Character c) => c.weaponsGroups.add("Bludgeons");
void _polearms(Character c) => c.weaponsGroups.add("Polearms");
void _lightBlades(Character c) => c.weaponsGroups.add("Light blades");

Map<int, Benefit> _humanBenefits = new Map.unmodifiable(new Map.fromIterables(
    [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    [
      _intelligence,
      _stamina,
      _stamina,
      _searching,
      _deception,
      _constitution,
      _constitution,
      _persuasion,
      _brawling,
      _brawling,
      _strength,
    ]));

Map<int, Benefit> _nightPeopleBenefits = new Map.unmodifiable(
    new Map.fromIterables(
        [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
        [
          _constitution,
          _smelling,
          _smelling,
          _stealth,
          _intimidation,
          _fighting,
          _fighting,
          _bludgeons,
          _brawling,
          _brawling,
          _willpower,
        ]));

Map<int, Benefit> _rhydanBenefits = new Map.unmodifiable(new Map.fromIterables(
    [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    [
      _dexterity,
      _smelling,
      _smelling,
      _stealth,
      _intimidation,
      _perception,
      _perception,
      _psychic,
      _naturalWeapon,
      _naturalWeapon,
      _willpower
    ]));

Map<int, Benefit> _seaFolkBenefits = new Map.unmodifiable(new Map.fromIterables(
    [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    [
      _accuracy,
      _naturalLore,
      _naturalLore,
      _hearing,
      _polearms,
      _dexterity,
      _dexterity,
      _historicalLore,
      _acrobatics,
      _acrobatics,
      _perception
    ]));

Map<int, Benefit> _vataBenefits = new Map.unmodifiable(new Map.fromIterables(
[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
[
  _communication,
  _culturalLore,
  _culturalLore,
  _seeing,
  _lightBlades,
  _accuracy,
  _accuracy,
  _historicalLore,
  _persuasion,
  _persuasion,
  _perception
]));
