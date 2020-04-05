import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'character.dart';

@Component(
  selector: 'various-stats',
  templateUrl: 'various_stats_component.html',
  styleUrls: ['../../../base_styles.css'],
  directives: [coreDirectives],
  providers: [materialProviders],
)
class VariousStatsComponent {
  @Input()
  Character character;

  String destinyAscendant() => character.destinyAscendant ? "(ascendant)" : "";

  String fateAscendant() => character.destinyAscendant ? "" : "(ascendant)";
}
