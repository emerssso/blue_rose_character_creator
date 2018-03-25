
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:blue_rose_character_creator/src/character/character.dart';
import 'package:googleapis_auth/auth_browser.dart';
import 'package:googleapis/drive/v3.dart';

final identifier = new ClientId(
    "303016941637-6hub1739n75g4b6c43i52ech871d6hqe.apps.googleusercontent.com",
    null);
const scopes = const [DriveApi.DriveScope];

@Component(
  selector: 'drive',
  templateUrl: 'drive_component.html',
  styleUrls: const ['drive_component.css'],
  directives: const [CORE_DIRECTIVES, materialDirectives],
  providers: const [materialProviders],
)
class DriveComponent {
  @Input() Character character;

  void save(UIEvent event) {
    createImplicitBrowserFlow(identifier, scopes)
        .then((BrowserOAuth2Flow flow) {
      // Try getting credentials without user consent.
      // This will succeed if the user already gave consent for this application.
      return flow.clientViaUserConsent(immediate: true).catchError((_) {

        //I've removed the loginButton from the flow, since AngularDart
        //doesn't pass this around.
//        loginButton.text = 'Authorize';
//        return loginButton.onClick.first.then((_) {
        return flow.clientViaUserConsent(immediate: false);
      }, test: (error) => error is UserConsentException);
    });
  }
}
