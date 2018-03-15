import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:blue_rose_character_creator/src/character/ability.dart';
import 'package:blue_rose_character_creator/src/character/character.dart';
import 'package:blue_rose_character_creator/src/character/character_class.dart';
import 'package:blue_rose_character_creator/src/character/component/abilities_component.dart';
import 'package:blue_rose_character_creator/src/character/race.dart';
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
  var character = new Character(Race.human, CharacterClass.warrior);

  var race = new DropDownDelegate<Race>(
      Race.values.sublist(0, 5), raceToString, Race.unknown);

  var characterClass = new DropDownDelegate<CharacterClass>(
      CharacterClass.values.sublist(0, 3),
      characterClassToString,
      CharacterClass.unknown);

  @override
  ngOnInit() {
    race.listen((selected) =>
        _regenerateCharacter(selected, character.characterClass));

    characterClass.listen((selected) =>
        _regenerateCharacter(character.race, selected));
  }

  _regenerateCharacter(Race race, CharacterClass characterClass) =>
      character = new Character(race, characterClass);

  String get raceName => raceToString(character?.race);

  String get characterClassName =>
      characterClassToString(character?.characterClass);


  String destinyAscendant() => character.destinyAscendant ? "(ascendant)" : "";

  String fateAscendant() => character.destinyAscendant ? "" : "(ascendant)";

  List<String> get accuracyFocuses =>
      character.focuses[Ability.accuracy].map((focus) => focus.domain);

  String renderDegree(Degree degree) => degreeToString(degree);

  String renderWeaponsGroup(WeaponsGroup wg) => weaponsGroupToString(wg);
}
