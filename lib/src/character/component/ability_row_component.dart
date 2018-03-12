import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:blue_rose_character_creator/src/character/ability.dart';
import 'package:blue_rose_character_creator/src/character/character.dart';

@Component(
  selector: 'ability-row',
  templateUrl: 'ability_row_component.html',
  directives: const [CORE_DIRECTIVES],
  providers: const [materialProviders],
)
class AbilityRowComponent {

  @Input() Character character;
  @Input() Ability ability;

  String get abilityName => nameOf(ability);
}