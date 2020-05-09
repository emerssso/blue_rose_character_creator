import 'dice.dart';
import 'talent.dart';

enum Arcana {
  animalMessenger,
  animalSummoning,
  arcaneStrike,
  arcaneWeapon,
  bodyControl,
  calm,
  coldShaping,
  cure,
  drawVitality,
  earthShaping,
  enhancement,
  fireShaping,
  fleshShaping,
  heartReading,
  illusion,
  lightShaping,
  manipulateObject,
  mindDelving,
  mindReading,
  mindShaping,
  moveObject,
  natureReading,
  objectReading,
  plantShaping,
  psychicContact,
  psychicShield,
  psychicWeapon,
  scrying,
  secondSight,
  senseMinds,
  sleep,
  summonSpirit,
  visions,
  ward,
  waterShaping,
  weatherShaping,
  windShaping,
  windWalking
}

extension ArcanaExt on Arcana {
  String get name => arcanaToString(this);
}

String arcanaToString(Arcana arcana) {
  switch (arcana) {
    case Arcana.animalMessenger:
      return "Animal messenger";

    case Arcana.animalSummoning:
      return "Animal summoning";

    case Arcana.arcaneStrike:
      return "Arcane strike";

    case Arcana.arcaneWeapon:
      return "Arcane weapon";

    case Arcana.bodyControl:
      return "Body control";

    case Arcana.calm:
      return "Calm";

    case Arcana.coldShaping:
      return "Cold shaping";

    case Arcana.cure:
      return "Cure";

    case Arcana.drawVitality:
      return "Draw vitality";

    case Arcana.earthShaping:
      return "Earth shaping";

    case Arcana.enhancement:
      return "Enhancement";

    case Arcana.fireShaping:
      return "Fire shaping";
    case Arcana.fleshShaping:
      return "Flesh shaping";

    case Arcana.heartReading:
      return "Heart reading";

    case Arcana.illusion:
      return "Illusion";

    case Arcana.lightShaping:
      return "Light shaping";

    case Arcana.manipulateObject:
      return "Manipulate object";

    case Arcana.mindDelving:
      return "Mind delving";

    case Arcana.mindReading:
      return "Mind reading";

    case Arcana.mindShaping:
      return "Mind shaping";

    case Arcana.moveObject:
      return "Move object";

    case Arcana.natureReading:
      return "Nature reading";

    case Arcana.objectReading:
      return "Object reading";

    case Arcana.plantShaping:
      return "Plant shaping";

    case Arcana.psychicContact:
      return "Psychic contact";

    case Arcana.psychicShield:
      return "Psychic shield";

    case Arcana.psychicWeapon:
      return "Psychic weapon";

    case Arcana.scrying:
      return "Scrying";

    case Arcana.secondSight:
      return "Second sight";

    case Arcana.senseMinds:
      return "Sense minds";

    case Arcana.sleep:
      return "Sleep";

    case Arcana.summonSpirit:
      return "Summon spirits";

    case Arcana.visions:
      return "Visions";

    case Arcana.ward:
      return "Ward";

    case Arcana.waterShaping:
      return "Water shaping";

    case Arcana.weatherShaping:
      return "Weather shaping";

    case Arcana.windShaping:
      return "Wind shaping";

    case Arcana.windWalking:
      return "Wind walking";

    default:
      return "Arcana";
  }
}

const animismArcana = [
  Arcana.animalMessenger,
  Arcana.animalSummoning,
  Arcana.bodyControl,
  Arcana.calm,
  Arcana.enhancement,
  Arcana.heartReading,
  Arcana.mindDelving,
  Arcana.mindReading,
  Arcana.natureReading,
  Arcana.plantShaping,
  Arcana.psychicContact,
  Arcana.psychicShield,
  Arcana.secondSight,
  Arcana.ward
];

const healingArcana = [
  Arcana.bodyControl,
  Arcana.cure,
  Arcana.drawVitality,
  Arcana.enhancement,
  Arcana.fleshShaping,
  Arcana.psychicShield,
  Arcana.secondSight,
  Arcana.sleep,
  Arcana.ward
];

const meditativeArcana = [
  Arcana.arcaneStrike,
  Arcana.arcaneWeapon,
  Arcana.bodyControl,
  Arcana.cure,
  Arcana.enhancement,
  Arcana.psychicShield,
  Arcana.secondSight,
  Arcana.ward
];

const psychicArcana = [
  Arcana.calm,
  Arcana.heartReading,
  Arcana.illusion,
  Arcana.mindDelving,
  Arcana.mindReading,
  Arcana.mindShaping,
  Arcana.psychicContact,
  Arcana.psychicShield,
  Arcana.psychicWeapon,
  Arcana.secondSight,
  Arcana.senseMinds,
  Arcana.sleep,
  Arcana.ward
];

const shapingArcana = [
  Arcana.arcaneStrike,
  Arcana.arcaneWeapon,
  Arcana.coldShaping,
  Arcana.earthShaping,
  Arcana.fireShaping,
  Arcana.lightShaping,
  Arcana.manipulateObject,
  Arcana.moveObject,
  Arcana.plantShaping,
  Arcana.psychicShield,
  Arcana.secondSight,
  Arcana.summonSpirit,
  Arcana.ward,
  Arcana.waterShaping,
  Arcana.weatherShaping,
  Arcana.windShaping,
  Arcana.windWalking
];

const visionaryArcana = [
  Arcana.natureReading,
  Arcana.objectReading,
  Arcana.psychicShield,
  Arcana.scrying,
  Arcana.secondSight,
  Arcana.summonSpirit,
  Arcana.visions,
  Arcana.ward
];

List<Arcana> getArcanaFor(List<Talent> talents) {
  final result = Set<Arcana>();

  final importantTalents =
      talents.where((talent) => arcaneTalents.contains(talent));

  // add talents all arcana users get
  if (importantTalents.length > 0) {
    result..add(Arcana.psychicShield)..add(Arcana.secondSight);
  }

  // add base arcanum for each talent
  result.addAll(importantTalents.map(startingArcanum));

  if (importantTalents.length > 1) {
    // add any additional arcana as a result of 2+ arcane talents
    // we remove 1 since it's covered by psychic shield and second sight
    final newArcana = (deck) => drawWithoutRepeats(deck, result);

    result.addAll(
        _removeRandom(importantTalents.map(arcanaForTalent).map(newArcana)));
  }

  // next add 2 arcana for Arcane Training
  if (talents.contains(arcaneTraining)) {
    result.addAll(drawNWithoutRepeats(
        2, importantTalents.map(arcanaForTalent).expand((t) => t), result));
  }

  // add 3 completely random talents for Wild Arcane
  //Todo: mark these arcana as wild and subject to additional tests.
  if (talents.contains(wildArcane)) {
    result.addAll(drawNWithoutRepeats(3, Arcana.values, result));
  }

  if (talents.contains(arcanePotential)) {
    result.add(drawWithoutRepeats(Arcana.values, result));
  }

  // remove null in case it was added by
  // drawWithoutRepeats failing to find a non-repeat
  result.remove(null);

  return List.unmodifiable(result);
}

List<T> _removeRandom<T>(Iterable<T> iterable) {
  final list = iterable.toList();
  list.remove(drawFrom(list));
  return list;
}

Arcana startingArcanum(Talent talent) {
  switch (talent) {
    case animism:
      return Arcana.animalMessenger;

    case healing:
      return Arcana.cure;

    case meditative:
      return Arcana.bodyControl;

    case psychic:
      return Arcana.psychicContact;

    case shaping:
      return Arcana.moveObject;

    case visionary:
      return Arcana.visions;

    default:
      return null;
  }
}

List<Arcana> arcanaForTalent(Talent talent) {
  switch (talent) {
    case animism:
      return animismArcana;

    case healing:
      return healingArcana;

    case meditative:
      return meditativeArcana;

    case psychic:
      return psychicArcana;

    case shaping:
      return shapingArcana;

    case visionary:
      return visionaryArcana;

    default:
      return const [];
  }
}
