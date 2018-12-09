import 'package:blue_rose_character_creator/src/character/ability.dart';

///Models a single character focus: i.e. Dexterity(Horseback riding)
class Focus {
  ///Ability focus applies to
  final Ability ability;

  /// String describing focus domain, i.e. "horseback riding".
  /// The part in parentheses in game notation.
  final String domain;

  ///If the focus has been improved (+2 -> +3)
  final bool improved;

  ///Bonus applied by the focus
  int get bonus => improved ? 3 : 2;

  Focus improve() => Focus._init(this.ability, this.domain, improved: true);

  const Focus._init(this.ability, this.domain, {this.improved = false});
}

const arcane = Focus._init(Ability.accuracy, "Arcane");
const bows = Focus._init(Ability.accuracy, "Bows");
const brawling = Focus._init(Ability.accuracy, "Brawling");
const lightBlades = Focus._init(Ability.accuracy, "Light blades");
const staves = Focus._init(Ability.accuracy, "Staves");
const naturalWeapon =
Focus._init(Ability.accuracy, "Natural weapon (pick one)");

const animalHandling = Focus._init(Ability.communication, "Animal handling");
const animism = Focus._init(Ability.communication, "Animism");
const bargaining = Focus._init(Ability.communication, "Bargaining");
const deception = Focus._init(Ability.communication, "Deception");
const disguise = Focus._init(Ability.communication, "Disguise");
const etiquette = Focus._init(Ability.communication, "Etiquette");
const gambling = Focus._init(Ability.communication, "Gambling");
const investigation = Focus._init(Ability.communication, "Investigation");
const leadership = Focus._init(Ability.communication, "Leadership");
const performance = Focus._init(Ability.communication, "Performance");
const persuasion = Focus._init(Ability.communication, "Persuasion");
const psychicCommunication = Focus._init(Ability.communication, "Psychic");
const romance = Focus._init(Ability.communication, "Romance");

const drinking = Focus._init(Ability.constitution, "Drinking");
const rowing = Focus._init(Ability.constitution, "Rowing");
const running = Focus._init(Ability.constitution, "Running");
const stamina = Focus._init(Ability.constitution, "Stamina");
const swimming = Focus._init(Ability.constitution, "Swimming");

const acrobatics = Focus._init(Ability.dexterity, "Acrobatics");
const artisan = Focus._init(Ability.dexterity, "Artisan");
const calligraphy = Focus._init(Ability.dexterity, "Calligraphy");
const crafting = Focus._init(Ability.dexterity, "Crafting");
const initiative = Focus._init(Ability.dexterity, "Initiative");
const legerdemain = Focus._init(Ability.dexterity, "Legerdemain");
const lockPicking = Focus._init(Ability.dexterity, "Lock picking");
const riding = Focus._init(Ability.dexterity, "Riding");
const sailing = Focus._init(Ability.dexterity, "Sailing");
const stealth = Focus._init(Ability.dexterity, "Stealth");
const traps = Focus._init(Ability.dexterity, "Traps");

const axes = Focus._init(Ability.fighting, "Axes");
const bludgeons = Focus._init(Ability.fighting, "Bludgeons");
const heavyBlades = Focus._init(Ability.fighting, "Heavy blades");
const lances = Focus._init(Ability.fighting, "Lances");
const polearms = Focus._init(Ability.fighting, "Polearms");

const arcaneLore = Focus._init(Ability.intelligence, "Arcane lore");
const brewing = Focus._init(Ability.intelligence, "Brewing");
const cartography = Focus._init(Ability.intelligence, "Cartography");
const cryptograpy = Focus._init(Ability.intelligence, "Cryptography");
const culturalLore = Focus._init(Ability.intelligence, "Cultural lore");
const engineering = Focus._init(Ability.intelligence, "Engineering");
const evaluation = Focus._init(Ability.intelligence, "Evaluation");
const healing = Focus._init(Ability.intelligence, "Healing");
const heraldry = Focus._init(Ability.intelligence, "Heraldry");
const historicalLore = Focus._init(Ability.intelligence, "Historical lore");
const militaryLore = Focus._init(Ability.intelligence, "Military lore");
const musicalLore = Focus._init(Ability.intelligence, "Musical lore");
const naturalLore = Focus._init(Ability.intelligence, "Natural lore");
const nauticalLore = Focus._init(Ability.intelligence, "Nautical lore");
const navigation = Focus._init(Ability.intelligence, "Navigation");
const religiousLore = Focus._init(Ability.intelligence, "Religious lore");
const remoteWeapons = Focus._init(Ability.intelligence, "Remote weapons");
const research = Focus._init(Ability.intelligence, "Research");
const shaping = Focus._init(Ability.intelligence, "Shaping");
const sorceryLore = Focus._init(Ability.intelligence, "Sorcery lore");
const writing = Focus._init(Ability.intelligence, "Writing");

const empathy = Focus._init(Ability.perception, "Empathy");
const hearing = Focus._init(Ability.perception, "Hearing");
const psychicPerception = Focus._init(Ability.perception, "Psychic");
const searching = Focus._init(Ability.perception, "Searching");
const seeing = Focus._init(Ability.perception, "Seeing");
const smelling = Focus._init(Ability.perception, "Smelling");
const tasting = Focus._init(Ability.perception, "Tasting");
const touching = Focus._init(Ability.perception, "Touching");
const tracking = Focus._init(Ability.perception, "Tracking");
const visionary = Focus._init(Ability.perception, "Visionary");

const List<Focus> perceptionFocuses = [
  empathy,
  hearing,
  psychicPerception,
  searching,
  seeing,
  smelling,
  tasting,
  touching,
  tracking,
  visionary
];

const climbing = Focus._init(Ability.strength, "Climbing");
const driving = Focus._init(Ability.strength, "Driving");
const intimidation = Focus._init(Ability.strength, "Intimidation");
const jumping = Focus._init(Ability.strength, "Jumping");
const might = Focus._init(Ability.strength, "Might");
const smithing = Focus._init(Ability.strength, "Smithing");

const courage = Focus._init(Ability.willpower, "Courage");
const faith = Focus._init(Ability.willpower, "Faith");
const meditative = Focus._init(Ability.willpower, "Meditative");
const morale = Focus._init(Ability.willpower, "Morale");
const purity = Focus._init(Ability.willpower, "Purity");
const selfDiscipline = Focus._init(Ability.willpower, "Self-discipline");
