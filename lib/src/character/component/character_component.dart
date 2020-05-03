import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:blue_rose_character/arcana.dart';
import 'package:blue_rose_character/background.dart';
import 'package:blue_rose_character/character.dart';
import 'package:blue_rose_character/character_class.dart';
import 'package:blue_rose_character_creator/src/character/component/abilities/abilities_component.dart';
import 'package:blue_rose_character_creator/src/character/component/languages/languages_component.dart';
import 'package:blue_rose_character_creator/src/character/component/various_stats/various_stats_component.dart';
import 'package:blue_rose_character_creator/src/character/component/weapons_groups/weapons_groups_component.dart';
import 'package:blue_rose_character/race.dart';
import 'package:blue_rose_characte/rhydan.dart';
import 'package:blue_rose_character/talent.dart';
import 'package:blue_rose_character_creator/src/drop_down_delegate.dart';

/// UI form for a character
@Component(
  selector: 'character',
  templateUrl: 'character_component.html',
  styleUrls: ['character_component.css'],
  directives: [
    coreDirectives,
    AbilitiesComponent,
    VariousStatsComponent,
    LanguagesComponent,
    WeaponsGroupsComponent
  ],
  providers: [materialProviders],
)
class CharacterComponent implements OnInit {
  var character = Character(Race.human, CharacterClass.warrior,
      background: Background.aldin);

  var race = DropDownDelegate<Race>(
      Race.values.sublist(0, 5), raceToString, Race.unknown);

  var characterClass = DropDownDelegate<CharacterClass>(
      CharacterClass.values.sublist(0, 3),
      characterClassToString,
      CharacterClass.unknown);

  var background = DropDownDelegate<Background>(
      Background.values, backgroundToString, Background.aldin);

  var rhydanType =
  DropDownDelegate<Rhy>(List.from(Rhy.values), rhyToString, Rhy.ape);

  @override
  ngOnInit() {
    race.listen((selected) => _regenerateCharacter(selected,
        character.characterClass, character.background, character.rhydanType));

    characterClass.listen((selected) => _regenerateCharacter(
        character.race, selected, character.background, character.rhydanType));

    background.listen((selected) => _regenerateCharacter(character.race,
        character.characterClass, selected, character.rhydanType));

    rhydanType.listen((selected) => _regenerateCharacter(character.race,
        character.characterClass, character.background, selected));
  }

  _regenerateCharacter(Race race, CharacterClass characterClass,
      Background background, Rhy rhy) {
    if (race != Race.rhydan) {
      rhy = null;
      background ??= Background.aldin;
    } else {
      rhy ??= Rhy.ape;
      background = null;
    }

    character = Character(race, characterClass,
        background: background, rhydanType: rhy);
  }

  void reRoll() => _regenerateCharacter(character.race,
      character.characterClass, character.background, character.rhydanType);

  print() async {
    creatorView = false;
    title = sheetTitle;

    await window.animationFrame;
    window.print();
    await window.animationFrame;

    title = creatorTitle;
    creatorView = true;
  }

  bool creatorView = true;

  String title = creatorTitle;

  String get raceName => raceToString(character?.race);

  String get backgroundName => backgroundToString(character?.background);

  String get className => characterClassToString(character?.characterClass);

  String get rhyName => rhyToString(character?.rhydanType);

  String renderDegree(Degree degree) => degreeToString(degree);

  String renderWeapon(Weapon weapon) => weapon.toString();

  String renderArcana(Arcana arcana) => arcanaToString(arcana);

  bool isRhydan(Race race) => race == Race.rhydan;
}

const creatorTitle = "Blue Rose Character Creator";
const sheetTitle = "Blue Rose Character Sheet";
