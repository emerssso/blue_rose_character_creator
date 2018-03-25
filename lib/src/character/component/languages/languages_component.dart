import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:blue_rose_character_creator/src/character/background.dart';
import 'package:blue_rose_character_creator/src/character/character.dart';

@Component(
  selector: 'languages',
  templateUrl: 'languages_component.html',
  styleUrls: const ['../../../base_styles.css'],
  directives: const [CORE_DIRECTIVES],
  providers: const [materialProviders],
)
class LanguagesComponent {
  @Input() Character character;

  String renderLanguage(Language lang) => languageToString(lang);
}
