import 'character.dart';
import 'dice.dart';
import 'focus.dart';

enum Background {
  aldin,
  forestFolk,
  jarzoni,
  kernish,
  lartyan,
  mariner,
  outcast,
  rezean,
  roamer
}

enum Language { aldin, faento, lartyan, rezean, oldAldin, oldVatazin }

String backgroundToString(Background bg) {
  switch (bg) {
    case Background.aldin:
      return "Aldin";
    case Background.forestFolk:
      return "Forest Folk";
    case Background.jarzoni:
      return "Jarzoni";
    case Background.kernish:
      return "Kernish";
    case Background.lartyan:
      return "Lar'tyan";
    case Background.mariner:
      return "Mariner";
    case Background.outcast:
      return "Outcast";
    case Background.rezean:
      return "Rezean";
    case Background.roamer:
      return "Roamer";
    default:
      return "Background";
  }
}

String languageToString(Language lang) {
  switch (lang) {
    case Language.aldin:
      return "Aldin";
    case Language.faento:
      return "Faento";
    case Language.lartyan:
      return "Lar'tyan";
    case Language.rezean:
      return "Rezean";
    case Language.oldAldin:
      return "Old Aldin";
    case Language.oldVatazin:
      return "Old Vatazin";
    default:
      return "Language";
  }
}

applyBackgroundToCharacter(Character character) {
  final focus =
      drawWhere(_getFocusesFor(character.background), character.hasnt);

  if (focus != null) character.addFocus(focus);

  character.languages.addAll(_getLanguagesForBackground(character.background));

  if (character.talents.any((talent) => talent.name == "Linguistics")) {
    character.languages
        .add(drawWithoutRepeats(Language.values, character.languages));
  }
}

List<Focus> _getFocusesFor(Background bg) {
  switch (bg) {
    case Background.aldin:
      return _aldinFocuses;

    case Background.forestFolk:
      return _forestFolkFocuses;

    case Background.jarzoni:
      return _jarzoniFocuses;

    case Background.lartyan:
      return _lartyanFocuses;

    case Background.mariner:
      return _marinerFocuses;

    case Background.outcast:
      return _outcastFocuses;

    case Background.rezean:
      return _rezeanFocuses;

    case Background.roamer:
      return _roamerFocuses;

    default:
      return [];
  }
}

const _aldinFocuses = [persuasion, artisan, culturalLore, historicalLore];
const _forestFolkFocuses = [running, crafting, naturalLore, tracking];
const _jarzoniFocuses = [etiquette, historicalLore, religiousLore, faith];
const _lartyanFocuses = [etiquette, crafting, heraldry, selfDiscipline];
const _marinerFocuses = [bargaining, swimming, sailing, nauticalLore];
const _outcastFocuses = [gambling, stealth, navigation, courage];
const _rezeanFocuses = [stamina, riding, navigation, courage];
const _roamerFocuses = [bargaining, performance, crafting, empathy];

List<Language> _getLanguagesForBackground(Background bg) {
  switch (bg) {
    case Background.aldin:
    case Background.forestFolk:
    case Background.jarzoni:
    case Background.kernish:
    case Background.mariner:
    case Background.outcast:
      return _aldinPlusOne();

    case Background.lartyan:
      return const [Language.aldin, Language.lartyan];

    case Background.rezean:
      return const [Language.rezean, Language.aldin];

    case Background.roamer:
      return const [Language.faento, Language.aldin];

    default:
      return const [];
  }
}

List<Language> _aldinPlusOne() => [
    Language.aldin,
    drawWhere(Language.values, (l) => l != Language.aldin)
  ];
