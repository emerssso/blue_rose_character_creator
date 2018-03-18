import 'package:blue_rose_character_creator/src/character/ability.dart';
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

final _emptyList = new List.unmodifiable([]);
final _aldinFocuses = new List<Focus>.unmodifiable([
  new Focus(Ability.communication, "Persuasion"),
  new Focus(Ability.dexterity, "Artisan"),
  new Focus(Ability.intelligence, "Cultural lore"),
  new Focus(Ability.intelligence, "Historical lore")
]);
final _forestFolkFocuses = new List<Focus>.unmodifiable([
  new Focus(Ability.constitution, "Running"),
  new Focus(Ability.dexterity, "Crafting"),
  new Focus(Ability.intelligence, "Natural lore"),
  new Focus(Ability.perception, "Tracking")
]);
final _jarzoniFocuses = new List<Focus>.unmodifiable([
  new Focus(Ability.communication, "Etiquette"),
  new Focus(Ability.intelligence, "Historical lore"),
  new Focus(Ability.intelligence, "Religious lore"),
  new Focus(Ability.willpower, "Faith")
]);
final _lartyanFocuses = new List<Focus>.unmodifiable([
  new Focus(Ability.communication, "Etiquette"),
  new Focus(Ability.dexterity, "Crafting"),
  new Focus(Ability.intelligence, "Heraldry"),
  new Focus(Ability.willpower, "Self-discipline")
]);
final _marinerFocuses = new List<Focus>.unmodifiable([
  new Focus(Ability.communication, "Bargaining"),
  new Focus(Ability.constitution, "Swimming"),
  new Focus(Ability.dexterity, "Sailing"),
  new Focus(Ability.intelligence, "Nautical lore")
]);
final _outcastFocuses = new List<Focus>.unmodifiable([
  new Focus(Ability.communication, "Gambling"),
  new Focus(Ability.dexterity, "Stealth"),
  new Focus(Ability.intelligence, "Navigation"),
  new Focus(Ability.willpower, "Courage")
]);
final _rezeanFocuses = new List<Focus>.unmodifiable([
  new Focus(Ability.constitution, "Stamina"),
  new Focus(Ability.dexterity, "Riding"),
  new Focus(Ability.intelligence, "Navigation"),
  new Focus(Ability.willpower, "Courage")
]);
final _roamerFocuses = new List<Focus>.unmodifiable([
  new Focus(Ability.communication, "Bargaining"),
  new Focus(Ability.communication, "Performance"),
  new Focus(Ability.dexterity, "Crafting"),
  new Focus(Ability.perception, "Empathy")
]);

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
