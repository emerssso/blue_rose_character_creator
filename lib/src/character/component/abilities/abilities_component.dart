import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:blue_rose_character_creator/src/character/ability.dart';
import 'package:blue_rose_character_creator/src/character/character.dart';

///Renders a characters abilities and focuses in a table
@Component(
  selector: 'abilities',
  templateUrl: 'abilities_component.html',
  styleUrls: ['../../../base_styles.css'],
  directives: [coreDirectives],
  providers: [materialProviders],
)
class AbilitiesComponent {
  @Input()
  Character character;

  String abilityName(Ability ability) => abilityToString(ability);

  int bonus(ability) => character.getAbilityBonus(ability);

  List<Ability> get abilities => Ability.values;
}
