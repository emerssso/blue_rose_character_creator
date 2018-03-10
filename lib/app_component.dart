import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:blue_rose_character_creator/src/character/component/character_component.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [materialDirectives, CharacterComponent],
  providers: const [materialProviders],
)
class AppComponent {
  // Nothing here yet. All logic is in TodoListComponent.
}
