import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:blue_rose_character_creator/src/character/ability.dart';
import 'package:blue_rose_character_creator/src/character/background.dart';
import 'package:blue_rose_character_creator/src/character/character.dart';
import 'package:blue_rose_character_creator/src/character/character_class.dart';
import 'package:blue_rose_character_creator/src/character/component/abilities_component.dart';
import 'package:blue_rose_character_creator/src/character/race.dart';
import 'package:blue_rose_character_creator/src/character/rhydan.dart';
import 'package:blue_rose_character_creator/src/character/talent.dart';
import 'package:blue_rose_character_creator/src/character/weapons_group.dart';
import 'package:blue_rose_character_creator/src/drop_down_delegate.dart';

/// UI form for a character
@Component(
  selector: 'character',
  templateUrl: 'character_component.html',
  styleUrls: const ['character_component.css'],
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    MaterialDropdownSelectComponent,
    NgModel,
    AbilitiesComponent,
  ],
  providers: const [materialProviders],
)
class CharacterComponent implements OnInit {
  var character = new Character(Race.human, CharacterClass.warrior,
      background: Background.aldin);

  var race = new DropDownDelegate<Race>(
      Race.values.sublist(0, 5), raceToString, Race.unknown);

  var characterClass = new DropDownDelegate<CharacterClass>(
      CharacterClass.values.sublist(0, 3),
      characterClassToString,
      CharacterClass.unknown);

  var background = new DropDownDelegate<Background>(
      Background.values, backgroundToString, Background.aldin);

  var rhydanType = new DropDownDelegate<Rhy>(
      new List.from(Rhy.values), rhyToString, Rhy.ape);

  @override
  ngOnInit() {
    race.listen((selected) =>
        _regenerateCharacter(
            selected, character.characterClass, character.background,
            character.rhydanType));

    characterClass.listen((selected) =>
        _regenerateCharacter(character.race, selected, character.background,
            character.rhydanType));

    background.listen((selected) =>
        _regenerateCharacter(
            character.race, character.characterClass, selected,
            character.rhydanType));

    rhydanType.listen((selected) =>
        _regenerateCharacter(
            character.race, character.characterClass, character.background,
            selected));
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

    character = new Character(race, characterClass,
        background: background, rhydanType: rhy);
  }

  String get raceName => raceToString(character?.race);

  String get backgroundName => backgroundToString(character?.background);

  String get characterClassName =>
      characterClassToString(character?.characterClass);

  String get characterRhydanType => rhyToString(character?.rhydanType);

  String destinyAscendant() => character.destinyAscendant ? "(ascendant)" : "";

  String fateAscendant() => character.destinyAscendant ? "" : "(ascendant)";

  List<String> get accuracyFocuses =>
      character.focuses[Ability.accuracy].map((focus) => focus.domain);

  String renderDegree(Degree degree) => degreeToString(degree);

  String renderWeaponsGroup(WeaponsGroup wg) => weaponsGroupToString(wg);

  String renderLanguage(Language lang) => languageToString(lang);

  String renderWeapon(Weapon weapon) => weapon.toString();

  bool isRhydan(Race race) => race == Race.rhydan;
}
