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

class _RhydanBonuses {
  final Map<Ability, int> abilityBonuses;
  final List<Weapon> attacks;
  final List<String> powers;

  const _RhydanBonuses({
    this.abilityBonuses = const {},
    this.attacks = const [],
    this.powers = const [],
  });
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
  if (character.rhydanType == null) return;

  var bonuses = _rhydanBonuses[character.rhydanType];
  if (bonuses == null) throw "Unrecognized rhy-type: ${character.rhydanType}";

  for (var ability in bonuses.abilityBonuses.keys) {
    character.abilities[ability] += bonuses.abilityBonuses[ability];
  }

  character.weapons.addAll(bonuses.attacks);
  character.powers.addAll(bonuses.powers);
}

const _rhydanBonuses = {
  Rhy.ape: _RhydanBonuses(
    powers: ["Hands"],
    abilityBonuses: {
      Ability.constitution: 1,
      Ability.dexterity: 1,
      Ability.strength: 2
    },
  ),
  Rhy.badger: _RhydanBonuses(
    attacks: [_bite1, _claw1],
    powers: ["Tough (AR 1)"],
    abilityBonuses: {
      Ability.constitution: 2,
      Ability.perception: 1,
      Ability.strength: 1
    },
  ),
  Rhy.bear: _RhydanBonuses(
    attacks: [_bite1, _claw2],
    abilityBonuses: {Ability.constitution: 3, Ability.strength: 3},
  ),
  Rhy.boar: _RhydanBonuses(
    attacks: [_gore],
    abilityBonuses: {Ability.constitution: 2, Ability.strength: 2},
  ),
  Rhy.cat: _RhydanBonuses(
    attacks: [_bite1, _claw1],
    powers: ["Nightvision"],
    abilityBonuses: {Ability.dexterity: 2, Ability.perception: 1},
  ),
  Rhy.crocodile: _RhydanBonuses(
    attacks: [_bite2],
    powers: ["Tough hide (AR 2)", "Swimming speed 10"],
    abilityBonuses: {Ability.constitution: 2, Ability.strength: 2},
  ),
  Rhy.dog: _RhydanBonuses(
    attacks: [_bite1, _claw1],
    abilityBonuses: {Ability.constitution: 2, Ability.dexterity: 1},
  ),
  Rhy.dolphin: _RhydanBonuses(
    attacks: [_slam],
    powers: ["Echolocation", "Hold breath for Con x 10 minutes"],
    abilityBonuses: {
      Ability.constitution: 1,
      Ability.dexterity: 1,
      Ability.strength: 1
    },
  ),
  Rhy.hawk: _RhydanBonuses(
    attacks: [_bite0, _claw1],
    powers: ["Nightvision"],
    abilityBonuses: {
      Ability.dexterity: 2,
      Ability.perception: 1,
      Ability.strength: -1
    },
  ),
  Rhy.owl: _RhydanBonuses(
    attacks: [_bite0, _claw1],
    powers: ["Nightvision"],
    abilityBonuses: {
      Ability.dexterity: 2,
      Ability.perception: 1,
      Ability.strength: -1
    },
  ),
  Rhy.horse: _RhydanBonuses(
    attacks: [_kick],
    abilityBonuses: {Ability.constitution: 2, Ability.strength: 2},
  ),
  Rhy.lizard: _RhydanBonuses(
    attacks: [_bite2],
    powers: ["Nightvision"],
    abilityBonuses: {Ability.constitution: 2, Ability.strength: 1},
  ),
  Rhy.raccoon: _RhydanBonuses(
    attacks: [_bite0, _claw3],
    powers: ["Nightvision"],
    abilityBonuses: {
      Ability.dexterity: 2,
      Ability.perception: 1,
      Ability.strength: -2
    },
  ),
  Rhy.raven: _RhydanBonuses(
    attacks: [_bite0, _claw1],
    powers: ["Nightvision", "can speak"],
    abilityBonuses: {
      Ability.dexterity: 3,
      Ability.perception: 1,
      Ability.strength: -2
    },
  ),
  Rhy.snake: _RhydanBonuses(
    attacks: [_bite1],
    powers: ["Nightvision"],
    abilityBonuses: {
      Ability.dexterity: 2,
      Ability.perception: 1,
      Ability.strength: 1
    },
  ),
  Rhy.weasel: _RhydanBonuses(
    attacks: [_bite0],
    powers: ["Nightvision"],
    abilityBonuses: {
      Ability.dexterity: 3,
      Ability.perception: 1,
      Ability.strength: -1
    },
  ),
  Rhy.wolf: _RhydanBonuses(
    attacks: [_bite1],
    powers: ["Nightvision"],
    abilityBonuses: {
      Ability.constitution: 1,
      Ability.dexterity: 1,
      Ability.perception: 1,
      Ability.strength: 1,
    },
  ),
};

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
