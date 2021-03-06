import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:blue_rose_character_creator/src/character/character.dart';
import 'package:blue_rose_character_creator/src/character/weapons_group.dart';

@Component(
  selector: 'weapons-groups',
  templateUrl: 'weapons_groups_component.html',
  styleUrls: ['../../../base_styles.css'],
  directives: [coreDirectives],
  providers: [materialProviders],
)
class WeaponsGroupsComponent {
  @Input()
  Character character;

  String renderWeaponsGroup(WeaponsGroup wg) => weaponsGroupToString(wg);
}
