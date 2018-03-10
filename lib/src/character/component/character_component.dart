import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:blue_rose_character_creator/src/character/character.dart';
import 'package:blue_rose_character_creator/src/character/character_class.dart';
import 'package:blue_rose_character_creator/src/character/race.dart';

/// UI form for a character
@Component(
  selector: 'character',
  templateUrl: 'character_component.html',
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
}

class DropDownDelegate<T> {
  final StringSelectionOptions<T> options;
  final ItemRenderer<T> renderer;
  final SelectionModel<T> selection;

  DropDownDelegate(List<T> optionList, String toString(T), T initialSelection)
      : options = new StringSelectionOptions<T>(optionList),
        renderer = new CachingItemRenderer<T>(toString),
        selection =
            new SelectionModel<T>.withList(selectedValues: [initialSelection]) {
  }

  StreamSubscription<List<SelectionChangeRecord<T>>> listen(void onData(T)) =>
      selection.selectionChanges
          .listen((selected) => onData(selected[0].added.first));
}

characterClassToString(CharacterClass cc) {
  switch (cc) {
    case CharacterClass.warrior:
      return "Warrior";
    case CharacterClass.expert:
      return "Expert";
    case CharacterClass.adept:
      return "Adept";
    default:
      return "Unknown";
  }
}

raceToString(Race race) {
  switch (race) {
    case Race.human:
      return "Human";
    case Race.nightPerson:
      return "Night Person";
    case Race.rhydan:
      return "Rhydan";
    case Race.seaFolk:
      return "Sea-folk";
    case Race.vata:
      return "Vata";
    case Race.unknown:
    default:
      return "Race";
  }
}
