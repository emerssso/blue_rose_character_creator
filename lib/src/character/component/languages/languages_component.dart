import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'background.dart';
import 'character.dart';

@Component(
  selector: 'languages',
  templateUrl: 'languages_component.html',
  styleUrls: ['../../../base_styles.css'],
  directives: [coreDirectives],
  providers: [materialProviders],
)
class LanguagesComponent {
  @Input()
  Character character;

  String renderLanguage(Language lang) => languageToString(lang);
}
