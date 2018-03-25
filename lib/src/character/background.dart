import 'package:blue_rose_character_creator/src/character/character.dart';
import 'package:blue_rose_character_creator/src/character/dice.dart';
import 'package:blue_rose_character_creator/src/character/focus.dart';

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

  if (focus != null) {
    character.addFocus(focus);
  }

  character.languages.addAll(_getLanguagesForBackground(character.background));

  if(character.talents.any((talent) => talent.name == "Linguistics")) {
    character.languages.add(
        drawWithoutRepeats(Language.values, character.languages));
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
      return _emptyList;
  }
}

const _emptyList = const [];

const _aldinFocuses = const [
  persuasion, artisan, culturalLore, historicalLore
];

const _forestFolkFocuses = const [
  running, crafting, naturalLore, tracking
];
const _jarzoniFocuses = const [
  etiquette, historicalLore, religiousLore, faith
];
const _lartyanFocuses = const [
  etiquette, crafting, heraldry, selfDiscipline
];
const _marinerFocuses = const [
  bargaining, swimming, sailing, nauticalLore
];
const _outcastFocuses = const [
  gambling, stealth, navigation, courage
];
const _rezeanFocuses = const [
  stamina, riding, navigation, courage
];
const _roamerFocuses = const [
  bargaining, performance, crafting, empathy
];

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
      return [Language.aldin, Language.lartyan];

    case Background.rezean:
      return [Language.rezean, Language.aldin];

    case Background.roamer:
      return [Language.faento, Language.aldin];

    default:
      return _emptyList;
  }
}

List<Language> _aldinPlusOne() {
  return [
    Language.aldin,
    drawWhere(Language.values, (l) => l != Language.aldin)
  ];
}
