import 'ability.dart';
import 'character.dart';

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
  switch (rhy) {
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

  const RhydanBonuses._internal(this.abilityBonuses, this.attacks, this.powers);
}

class Weapon {
  final String name;
  final Ability ability;
  final int dice;
  final int dieSize;
  final int modifier;

  const Weapon._internal(this.name, this.ability, this.dice, this.modifier,
      {this.dieSize = 6});

  String toString() =>
      "$name (${abilityToString(ability)}) ${dice}d$dieSize" +
      (modifier > 0 ? "+$modifier" : "");
}

const _bite0 = Weapon._internal("Bite", Ability.accuracy, 1, 0);
const _bite1 = Weapon._internal("Bite", Ability.accuracy, 1, 1);
const _bite2 = Weapon._internal("Bite", Ability.accuracy, 2, 0);
const _claw1 = Weapon._internal("Claw", Ability.fighting, 1, 0);
const _claw2 = Weapon._internal("Claw", Ability.fighting, 2, 0);
const _claw3 = Weapon._internal("Claw", Ability.fighting, 1, 0, dieSize: 3);
const _gore = Weapon._internal("Gore", Ability.fighting, 2, 0);
const _slam = Weapon._internal("Slam", Ability.accuracy, 1, 0);
const _kick = Weapon._internal("Kick", Ability.accuracy, 1, 0);

void applyRhydanBonuses(Character character) {
  if (character.rhydanType == null) {
    return;
  }

  var bonuses = _getBonusesForRhydan(character.rhydanType);

  for (var ability in bonuses.abilityBonuses.keys) {
    character.abilities[ability] += bonuses.abilityBonuses[ability];
  }

  character.weapons.addAll(bonuses.attacks);
  character.powers.addAll(bonuses.powers);
}

RhydanBonuses _getBonusesForRhydan(Rhy type) {
  switch (type) {
    case Rhy.ape:
      return RhydanBonuses._internal(
          Map.unmodifiable(Map.fromIterables(
              [Ability.constitution, Ability.dexterity, Ability.strength],
              [1, 1, 2])),
          [],
          const ["Hands"]);

    case Rhy.badger:
      return RhydanBonuses._internal(
          Map.unmodifiable(Map.fromIterables(
              [Ability.constitution, Ability.perception, Ability.strength],
              [2, 1, 1])),
          List.from([_bite1, _claw1]),
          const ["Tough (AR 1)"]);

    case Rhy.bear:
      return RhydanBonuses._internal(
          Map.unmodifiable(Map.fromIterables(
              [Ability.constitution, Ability.strength], [3, 3])),
          const [_bite1, _claw2],
          []);

    case Rhy.boar:
      return RhydanBonuses._internal(
          Map.unmodifiable(Map.fromIterables(
              [Ability.constitution, Ability.strength], [2, 2])),
          const [_gore],
          []);

    case Rhy.cat:
      return RhydanBonuses._internal(
          Map.unmodifiable(Map.fromIterables(
              [Ability.dexterity, Ability.perception], [2, 1])),
          const [_bite1, _claw1],
          const ["Nightvision"]);

    case Rhy.crocodile:
      return RhydanBonuses._internal(
          Map.unmodifiable(Map.fromIterables(
              [Ability.constitution, Ability.strength], [2, 2])),
          const [_bite2],
          const ["Tough hide (AR 2)", "Swimming speed 10"]);

    case Rhy.dog:
      return RhydanBonuses._internal(
          Map.unmodifiable(Map.fromIterables(
              [Ability.constitution, Ability.dexterity], [2, 1])),
          const [_bite1, _claw1],
          []);

    case Rhy.dolphin:
      return RhydanBonuses._internal(
          Map.unmodifiable(Map.fromIterables(
              [Ability.constitution, Ability.dexterity, Ability.strength],
              [1, 1, 1])),
          const [_slam],
          const ["Echolocation", "Hold breath for Con x 10 minutes"]);

    case Rhy.hawk:
      return RhydanBonuses._internal(
          Map.unmodifiable(Map.fromIterables(
              [Ability.dexterity, Ability.perception, Ability.strength],
              [2, 1, -1])),
          const [_bite0, _claw1],
          const ["Nightvision"]);

    case Rhy.owl:
      return RhydanBonuses._internal(
          Map.unmodifiable(Map.fromIterables(
              [Ability.dexterity, Ability.perception, Ability.strength],
              [2, 1, -1])),
          const [_bite0, _claw1],
          const ["Nightvision"]);

    case Rhy.horse:
      return RhydanBonuses._internal(
          Map.unmodifiable(Map.fromIterables(
              [Ability.constitution, Ability.strength], [2, 2])),
          const [_kick],
          []);

    case Rhy.lizard:
      return RhydanBonuses._internal(
          Map.unmodifiable(Map.fromIterables(
              [Ability.constitution, Ability.strength], [2, 1])),
          const [_bite2],
          const ["Nightvision"]);

    case Rhy.raccoon:
      return RhydanBonuses._internal(
          Map.unmodifiable(Map.fromIterables(
              [Ability.dexterity, Ability.perception, Ability.strength],
              [2, 1, -2])),
          const [_bite0, _claw3],
          const ["Nightvision"]);

    case Rhy.raven:
      return RhydanBonuses._internal(
          Map.unmodifiable(Map.fromIterables(
              [Ability.dexterity, Ability.perception, Ability.strength],
              [3, 1, -2])),
          const [_bite0, _claw1],
          const ["Nightvision", "can speak"]);

    case Rhy.snake:
      return RhydanBonuses._internal(
          Map.unmodifiable(Map.fromIterables(
              [Ability.dexterity, Ability.perception, Ability.strength],
              [2, 1, 1])),
          const [_bite1],
          const ["Nightvision"]);

    case Rhy.weasel:
      return RhydanBonuses._internal(
          Map.unmodifiable(Map.fromIterables(
              [Ability.dexterity, Ability.perception, Ability.strength],
              [3, 1, -1])),
          const [_bite0],
          const ["Nightvision"]);

    case Rhy.wolf:
      return RhydanBonuses._internal(
          Map.unmodifiable(Map.fromIterables([
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
          const [_bite1],
          const ["Nightvision"]);
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
