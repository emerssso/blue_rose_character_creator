import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:blue_rose_character_creator/src/character/character.dart';
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
class CharacterComponent implements OnInit{
  var character = new Character();
  String selectedRace;

  ItemRenderer<Race> raceRenderer =
      new CachingItemRenderer<Race>((race) => raceToString(race));

  StringSelectionOptions<Race> get raceOptions => new RaceSelectionOptions();

  SelectionModel<Race> selectionModel = new SelectionModel<Race>
      .withList(selectedValues: [Race.human]);

  @override
  ngOnInit() {
    selectionModel.selectionChanges.listen(
            (selected) =>
            character.race = selected[0].added.first ?? Race.unknown
    );
  }

  showRace(Race race) {
    return raceToString(race);
  }
}

List<String> races = ["Human", "Night Person", "Rhydan", "Sea-folk", "Vata"];

class RaceSelectionOptions extends StringSelectionOptions<Race>
    implements Selectable {
  RaceSelectionOptions() : super(Race.values.sublist(0, 5));

  @override
  SelectableOption getSelectable(item) => SelectableOption.Selectable;
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
