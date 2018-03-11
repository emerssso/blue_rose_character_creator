import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:blue_rose_character_creator/src/character/character.dart';
import 'package:blue_rose_character_creator/src/character/character_class.dart';
import 'package:blue_rose_character_creator/src/character/race.dart';
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
  ],
)
class CharacterComponent implements OnInit {
  var character = new Character();

  var race = new DropDownDelegate<Race>(
      Race.values.sublist(0, 5),
      (race) => raceToString(race),
      Race.unknown);

  var characterClass = new DropDownDelegate<CharacterClass>(
      CharacterClass.values.sublist(0, 3),
      (cc) => characterClassToString(cc),
      CharacterClass.unknown);

  @override
  ngOnInit() {
    race.listen((selected) => character.race = selected ?? Race.unknown);
    characterClass.listen((selected) =>
        character.characterClass = selected ?? CharacterClass.unknown);
  }

  showRace(Race race) {
    return raceToString(race);
  }

  showClass(CharacterClass cc) {
    return characterClassToString(cc);
  }

  generateCharacter() {
    character = new Character();
  }
}
