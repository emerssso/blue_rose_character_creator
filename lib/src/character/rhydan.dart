import 'package:blue_rose_character_creator/src/character/ability.dart';
import 'package:blue_rose_character_creator/src/character/character.dart';

enum Rhy {
  ape,
  badger,
  bear,
  boar,
  cat,
  crocodile,
  dog,
  dolphin,
  hawk,
  owl,
  horse,
  lizard,
  raccoon,
  raven,
  snake,
  weasel,
  wolf
}

String rhyToString(Rhy rhy) {
  switch(rhy) {
    case Rhy.ape:
      return "Ape";
    case Rhy.badger:
      return "Badger";
    case Rhy.bear:
      return "Bear";
    case Rhy.boar:
      return "Boar";
    case Rhy.cat:
      return "Cat";
    case Rhy.crocodile:
      return "Crocodile";
    case Rhy.dog:
      return "Dog";
    case Rhy.dolphin:
      return "Dolphin";
    case Rhy.hawk:
      return "Hawk";
    case Rhy.owl:
      return "Owl";
    case Rhy.horse:
      return "Horse";
    case Rhy.lizard:
      return "Lizard";
    case Rhy.raccoon:
      return "Raccoon";
    case Rhy.raven:
      return "Raven";
    case Rhy.snake:
      return "Snake";
    case Rhy.weasel:
      return "Weasel";
    case Rhy.wolf:
      return "Wolf";
    default:
      return "Rhydan Type";
  }
}

class RhydanBonuses {
  final Map<Ability, int> abilityBonuses;
  final List<Weapon> attacks;
  final List<String> powers;

  RhydanBonuses._internal(
      this.abilityBonuses, this.attacks, this.powers);
}

class Weapon {
  final String name;
  final Ability ability;
  final int dice;
  final int dieSize;
  final int modifier;

  Weapon._internal(this.name, this.ability, this.dice, this.modifier,
      {this.dieSize = 6});

  String toString() => "$name (${nameOf(ability)}) ${dice}d$dieSize" +
      (modifier > 0 ? "+$modifier" : "");
}

final _bite0 = new Weapon._internal("Bite", Ability.accuracy, 1, 0);
final _bite1 = new Weapon._internal("Bite", Ability.accuracy, 1, 1);
final _bite2 = new Weapon._internal("Bite", Ability.accuracy, 2, 0);
final _claw1 = new Weapon._internal("Claw", Ability.fighting, 1, 0);
final _claw2 = new Weapon._internal("Claw", Ability.fighting, 2, 0);
final _claw3 = new Weapon._internal("Claw", Ability.fighting, 1, 0, dieSize: 3);
final _gore = new Weapon._internal("Gore", Ability.fighting, 2, 0);
final _slam = new Weapon._internal("Slam", Ability.accuracy, 1, 0);
final _kick = new Weapon._internal("Kick", Ability.accuracy, 1, 0);

void applyRhydanBonuses(Character character) {
  if(character.rhydanType == null) {
    return;
  }

  var bonuses = _getBonusesForRhydan(character.rhydanType);

  for(var ability in bonuses.abilityBonuses.keys) {
    character.abilities[ability] += bonuses.abilityBonuses[ability];
  }

  character.weapons.addAll(bonuses.attacks);
  character.powers.addAll(bonuses.powers);
}

RhydanBonuses _getBonusesForRhydan(Rhy type) {
  var _emptyList = new List.unmodifiable([]);

  switch (type) {
    case Rhy.ape:
      return new RhydanBonuses._internal(
          new Map.unmodifiable(new Map.fromIterables(
              [Ability.constitution, Ability.dexterity, Ability.strength],
              [1, 1, 2])),
          _emptyList,
          new List.unmodifiable(["Hands"]));

    case Rhy.badger:
      return new RhydanBonuses._internal(
          new Map.unmodifiable(new Map.fromIterables(
              [Ability.constitution, Ability.perception, Ability.strength],
              [2, 1, 1])),
          new List.from([_bite1, _claw1]),
          new List.unmodifiable(["Tough (AR 1)"]));

    case Rhy.bear:
      return new RhydanBonuses._internal(
          new Map.unmodifiable(new Map.fromIterables(
              [Ability.constitution, Ability.strength], [3, 3])),
          new List.unmodifiable([_bite1, _claw2]),
          _emptyList);

    case Rhy.boar:
      return new RhydanBonuses._internal(
          new Map.unmodifiable(new Map.fromIterables(
              [Ability.constitution, Ability.strength], [2, 2])),
          new List.unmodifiable([_gore]),
          _emptyList);

    case Rhy.cat:
      return new RhydanBonuses._internal(
          new Map.unmodifiable(new Map.fromIterables(
              [Ability.dexterity, Ability.perception], [2, 1])),
          new List.unmodifiable([_bite1, _claw1]),
          new List.unmodifiable(["Nightvision"]));

    case Rhy.crocodile:
      return new RhydanBonuses._internal(
          new Map.unmodifiable(new Map.fromIterables(
              [Ability.constitution, Ability.strength], [2, 2])),
          new List.unmodifiable([_bite2]),
          new List.unmodifiable(["Tough hide (AR 2)", "Swimming speed 10"]));

    case Rhy.dog:
      return new RhydanBonuses._internal(
          new Map.unmodifiable(new Map.fromIterables(
              [Ability.constitution, Ability.dexterity], [2, 1])),
          new List.unmodifiable([_bite1, _claw1]),
          _emptyList);

    case Rhy.dolphin:
      return new RhydanBonuses._internal(
          new Map.unmodifiable(new Map.fromIterables(
              [Ability.constitution, Ability.dexterity, Ability.strength],
              [1, 1, 1])),
          new List.unmodifiable([_slam]),
          new List.unmodifiable(
              ["Echolocation", "Hold breath for Con x 10 minutes"]));

    case Rhy.hawk:
      return new RhydanBonuses._internal(
          new Map.unmodifiable(new Map.fromIterables(
              [Ability.dexterity, Ability.perception, Ability.strength],
              [2, 1, -1])),
          new List.unmodifiable([_bite0, _claw1]),
          new List.unmodifiable(["Nightvision"]));

    case Rhy.owl:
      return new RhydanBonuses._internal(
          new Map.unmodifiable(new Map.fromIterables(
              [Ability.dexterity, Ability.perception, Ability.strength],
              [2, 1, -1])),
          new List.unmodifiable([_bite0, _claw1]),
          new List.unmodifiable(["Nightvision"]));

    case Rhy.horse:
      return new RhydanBonuses._internal(
          new Map.unmodifiable(new Map.fromIterables(
              [Ability.constitution, Ability.strength], [2, 2])),
          new List.unmodifiable([_kick]),
          _emptyList);

    case Rhy.lizard:
      return new RhydanBonuses._internal(
          new Map.unmodifiable(new Map.fromIterables(
              [Ability.constitution, Ability.strength], [2, 1])),
          new List.unmodifiable([_bite2]),
          new List.unmodifiable(["Nightvision"]));

    case Rhy.raccoon:
      return new RhydanBonuses._internal(
          new Map.unmodifiable(new Map.fromIterables(
              [Ability.dexterity, Ability.perception, Ability.strength],
              [2, 1, -2])),
          new List.unmodifiable([_bite0, _claw3]),
          new List.unmodifiable(["Nightvision"]));

    case Rhy.raven:
      return new RhydanBonuses._internal(
          new Map.unmodifiable(new Map.fromIterables(
              [Ability.dexterity, Ability.perception, Ability.strength],
              [3, 1, -2])),
          new List.unmodifiable([_bite0, _claw1]),
          new List.unmodifiable(["Nightvision", "can speak"]));

    case Rhy.snake:
      return new RhydanBonuses._internal(
          new Map.unmodifiable(new Map.fromIterables(
              [Ability.dexterity, Ability.perception, Ability.strength],
              [2, 1, 1])),
          new List.unmodifiable([_bite1]),
          new List.unmodifiable(["Nightvision"]));

    case Rhy.weasel:
      return new RhydanBonuses._internal(
          new Map.unmodifiable(new Map.fromIterables(
              [Ability.dexterity, Ability.perception, Ability.strength],
              [3, 1, -1])),
          new List.unmodifiable([_bite0]),
          new List.unmodifiable(["Nightvision"]));

    case Rhy.wolf:
      return new RhydanBonuses._internal(
          new Map.unmodifiable(new Map.fromIterables([
            Ability.constitution,
            Ability.dexterity,
            Ability.perception,
            Ability.strength
          ], [
            1,
            1,
            1,
            1
          ])),
          new List.unmodifiable([_bite1]),
          new List.unmodifiable(["Nightvision"]));
    default:
      throw "Unrecognized rhy-type: $type";
  }
}

int getBaseSpeed(Rhy type) {
  switch (type) {
    case Rhy.badger:
    case Rhy.snake:
    case Rhy.crocodile:
      return 8;

    case Rhy.boar:
      return 11;

    case Rhy.cat:
    case Rhy.dog:
    case Rhy.raven:
    case Rhy.wolf:
      return 12;

    case Rhy.hawk:
    case Rhy.owl:
    case Rhy.horse:
      return 14;

    case Rhy.ape:
    case Rhy.bear:
    case Rhy.dolphin:
    case Rhy.lizard:
    case Rhy.raccoon:
    case Rhy.weasel:
    default:
      return 10;
  }
}
