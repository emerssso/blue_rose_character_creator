import 'package:blue_rose_character_creator/src/character/arcana.dart';
import 'package:blue_rose_character_creator/src/character/background.dart';
import 'package:blue_rose_character_creator/src/character/character_class.dart';
import 'package:blue_rose_character_creator/src/character/dice.dart';
import 'package:blue_rose_character_creator/src/character/focus.dart';
import 'package:blue_rose_character_creator/src/character/race.dart';
import 'package:blue_rose_character_creator/src/character/ability.dart';
import 'package:blue_rose_character_creator/src/character/calling_destiny_fate.dart';
import 'package:blue_rose_character_creator/src/character/rhydan.dart';
import 'package:blue_rose_character_creator/src/character/talent.dart';
import 'package:blue_rose_character_creator/src/character/weapons_group.dart';

/// Models a Blue Rose character
class Character {
  final Race race;
  final Background background;
  final Rhy rhydanType;
  final CharacterClass characterClass;
  final int level;

  final String calling;
  final String destiny;
  final String fate;
  final bool destinyAscendant;

  final Map<Ability, int> abilities;
  final Map<Ability, List<Focus>> focuses;
  final List<WeaponsGroup> weaponsGroups;
  final List<String> powers;
  final List<Talent> talents;
  final List<Weapon> weapons;
  final List<Language> languages;
  final List<Arcana> arcana;

  int get accuracy => abilities[Ability.accuracy] ?? 0;

  int get communication => abilities[Ability.communication] ?? 0;

  int get constitution => abilities[Ability.constitution] ?? 0;

  int get dexterity => abilities[Ability.dexterity] ?? 0;

  int get fighting => abilities[Ability.fighting] ?? 0;

  int get intelligence => abilities[Ability.intelligence] ?? 0;

  int get perception => abilities[Ability.perception] ?? 0;

  int get strength => abilities[Ability.strength] ?? 0;

  int get willpower => abilities[Ability.willpower] ?? 0;

  int get speed => getBaseSpeed(rhydanType) + dexterity;

  int get defense => 10 + dexterity;

  int _health;
  int get health => _health ??= getHealthFor(characterClass, constitution);

  factory Character(race, characterClass, {background, level, rhydanType}) {
    var mutable = new Character._mutable(race, characterClass,
        background: background, level: level, rhydanType: rhydanType);

    return new Character._immutable(
        mutable.race,
        mutable.rhydanType,
        mutable.characterClass,
        mutable.background,
        mutable.level,
        mutable.calling,
        mutable.destiny,
        mutable.fate,
        mutable.destinyAscendant,
        new Map.unmodifiable(mutable.abilities),
        new Map.unmodifiable(mutable.focuses),
        new List.unmodifiable(mutable.weaponsGroups),
        new List.unmodifiable(mutable.powers),
        new List.unmodifiable(mutable.talents),
        new List.unmodifiable(mutable.weapons),
        new List.unmodifiable(mutable.languages),
        new List.unmodifiable(mutable.arcana));
  }

  Character._immutable(
      this.race,
      this.rhydanType,
      this.characterClass,
      this.background,
      this.level,
      this.calling,
      this.destiny,
      this.fate,
      this.destinyAscendant,
      this.abilities,
      this.focuses,
      this.weaponsGroups,
      this.powers,
      this.talents,
      this.weapons,
      this.languages,
      this.arcana);

  Character._mutable(this.race, this.characterClass,
      {this.background, this.level = 1, this.rhydanType})
      : calling = drawCalling(),
        destiny = drawDestiny(),
        fate = drawFate(),
        destinyAscendant = coinFlip(),
        abilities = _fillAbilities(characterClass),
        focuses = new Map(),
        weaponsGroups = new List(),
        powers = new List(),
        talents = new List(),
        weapons = new List(),
        languages = new List(),
        arcana = new List() {
    if (race == Race.rhydan && rhydanType == null) {
      throw "Rhydan must have a type!";
    }

    if (race != Race.rhydan && rhydanType != null) {
      throw "Non-rhydan cannot have a Rhy-type!";
    }

    applyRacialBenefits(this);
    applyClassBenefits(this);
    applyBackgroundToCharacter(this);

    if (rhydanType != null) {
      applyRhydanBonuses(this);
    }

    arcana.addAll(getArcanaFor(talents));
  }

  bool get isFilled => abilities.isNotEmpty;

  void addFocus(Focus focus) {
    focuses[focus.ability] ??= new List();
    focuses[focus.ability].add(focus);
  }

  void increase(Ability ability) => abilities[ability]++;

  int getAbilityBonus(Ability ability) => abilities[ability];

  // talents can be taken only if a talent with the same name
  // (but maybe different degree) ahs not already been taken and
  // the character meets minimum ability if any
  bool canTake(Talent talent) {
    var doesntHave = talents.every((has) => has.name != talent.name);

    var meets = talent.requirements.every(_meets);

    return doesntHave && meets;
  }

  bool hasnt(Focus focus) =>
      focuses[focus.ability] == null ||
      focuses[focus.ability].any((f) => f.domain == focus.domain);

  bool _meets(Requirement req) => req.isMetBy(this);
}

final rollToAbilityBonus = new Map<int, int>.unmodifiable(new Map.fromIterables(
    [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18],
    [-2, -1, -1, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4]));

Map<Ability, int> _fillAbilities(CharacterClass characterClass) {
  Map<Ability, int> temp = new Map();

  List<int> bonuses = new List.generate(9, (i) => Xd6(3))
      .map((k) => rollToAbilityBonus[k])
      .toList();

  bonuses.sort((i, j) => j - i);

  List<Ability> statOrder = statPriorityListForClass(characterClass);

  for (int i = 0; i < statOrder.length; i++) {
    temp[statOrder[i]] = bonuses[i];
  }

  return temp;
}
