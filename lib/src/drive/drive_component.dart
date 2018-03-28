
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
class DriveComponent implements OnInit {
  @Input() Character character;

  BrowserOAuth2Flow _flow = null;

  bool get cantSave => _flow == null;

  void save(UIEvent event) {
    _flow.clientViaUserConsent(immediate: false);
  }

  @override
  ngOnInit() {
    createImplicitBrowserFlow(identifier, scopes)
        .then((BrowserOAuth2Flow flow) {
      _flow = flow;
    });
  }
}
