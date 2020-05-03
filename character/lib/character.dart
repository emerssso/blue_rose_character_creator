import 'ability.dart';
import 'arcana.dart';
import 'background.dart';
import 'calling_destiny_fate.dart';
import 'character_class.dart';
import 'dice.dart';
import 'focus.dart';
import 'race.dart';
import 'rhydan.dart';
import 'talent.dart';
import 'weapons_group.dart';

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

  int get health => _health ??= getHealthFor(
        characterClass,
        constitution: constitution,
        level: level,
      );

  factory Character(race, characterClass, {background, level, rhydanType}) {
    var mutable = Character._mutable(race, characterClass,
        background: background, level: level, rhydanType: rhydanType);

    return Character._immutable(
        mutable.race,
        mutable.rhydanType,
        mutable.characterClass,
        mutable.background,
        mutable.level,
        mutable.calling,
        mutable.destiny,
        mutable.fate,
        mutable.destinyAscendant,
        Map.unmodifiable(mutable.abilities),
        Map.unmodifiable(mutable.focuses),
        List.unmodifiable(mutable.weaponsGroups),
        List.unmodifiable(mutable.powers),
        List.unmodifiable(mutable.talents),
        List.unmodifiable(mutable.weapons),
        List.unmodifiable(mutable.languages),
        List.unmodifiable(mutable.arcana));
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
        destinyAscendant = flipCoin,
        abilities = _fillAbilities(characterClass),
        focuses = {},
        weaponsGroups = [],
        powers = [],
        talents = [],
        weapons = [],
        languages = [],
        arcana = [] {
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
    focuses[focus.ability] ??= [];
    focuses[focus.ability].add(focus);
  }

  void increase(Ability ability) => abilities[ability]++;

  int getAbilityBonus(Ability ability) => abilities[ability];

  // talents can be taken only if a talent with the same name
  // (but maybe different degree) ahs not already been taken and
  // the character meets minimum ability if any
  bool canTake(Talent talent) {
    final doesntHave = talents.every((has) => has.name != talent.name);
    final meets = talent.requirements.every(_meets);

    return doesntHave && meets;
  }

  bool hasFocus(Focus focus) =>
      focuses[focus.ability] != null &&
      focuses[focus.ability].any((f) => f.domain == focus.domain);

  bool hasnt(Focus focus) => !hasFocus(focus);

  bool _meets(Requirement req) => req.isMetBy(this);
}

final rollToAbilityBonus = Map<int, int>.unmodifiable(Map.fromIterables(
    [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18],
    [-2, -1, -1, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4]));

Map<Ability, int> _fillAbilities(CharacterClass characterClass) {
  var temp = <Ability, int>{};
  var statOrder = statPriorityListForClass(characterClass);
  var bonuses = List.generate(9, (i) => 3.d6)
      .map((k) => rollToAbilityBonus[k])
      .toList()
        ..sort((i, j) => j - i);

  for (int i = 0; i < statOrder.length; i++) {
    temp[statOrder[i]] = bonuses[i];
  }

  return temp;
}
