import 'ability.dart';

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

  Focus improve() => Focus._(this.ability, this.domain, improved: true);

  const Focus._(this.ability, this.domain, {this.improved = false});
}

const arcane = Focus._(Ability.accuracy, "Arcane");
const bows = Focus._(Ability.accuracy, "Bows");
const brawling = Focus._(Ability.accuracy, "Brawling");
const lightBlades = Focus._(Ability.accuracy, "Light blades");
const staves = Focus._(Ability.accuracy, "Staves");
const naturalWeapon =
    Focus._(Ability.accuracy, "Natural weapon (pick one)");

const animalHandling = Focus._(Ability.communication, "Animal handling");
const animism = Focus._(Ability.communication, "Animism");
const bargaining = Focus._(Ability.communication, "Bargaining");
const deception = Focus._(Ability.communication, "Deception");
const disguise = Focus._(Ability.communication, "Disguise");
const etiquette = Focus._(Ability.communication, "Etiquette");
const gambling = Focus._(Ability.communication, "Gambling");
const investigation = Focus._(Ability.communication, "Investigation");
const leadership = Focus._(Ability.communication, "Leadership");
const performance = Focus._(Ability.communication, "Performance");
const persuasion = Focus._(Ability.communication, "Persuasion");
const psychicCommunication = Focus._(Ability.communication, "Psychic");
const romance = Focus._(Ability.communication, "Romance");

const drinking = Focus._(Ability.constitution, "Drinking");
const rowing = Focus._(Ability.constitution, "Rowing");
const running = Focus._(Ability.constitution, "Running");
const stamina = Focus._(Ability.constitution, "Stamina");
const swimming = Focus._(Ability.constitution, "Swimming");

const acrobatics = Focus._(Ability.dexterity, "Acrobatics");
const artisan = Focus._(Ability.dexterity, "Artisan");
const calligraphy = Focus._(Ability.dexterity, "Calligraphy");
const crafting = Focus._(Ability.dexterity, "Crafting");
const initiative = Focus._(Ability.dexterity, "Initiative");
const legerdemain = Focus._(Ability.dexterity, "Legerdemain");
const lockPicking = Focus._(Ability.dexterity, "Lock picking");
const riding = Focus._(Ability.dexterity, "Riding");
const sailing = Focus._(Ability.dexterity, "Sailing");
const stealth = Focus._(Ability.dexterity, "Stealth");
const traps = Focus._(Ability.dexterity, "Traps");

const axes = Focus._(Ability.fighting, "Axes");
const bludgeons = Focus._(Ability.fighting, "Bludgeons");
const heavyBlades = Focus._(Ability.fighting, "Heavy blades");
const lances = Focus._(Ability.fighting, "Lances");
const polearms = Focus._(Ability.fighting, "Polearms");

const arcaneLore = Focus._(Ability.intelligence, "Arcane lore");
const brewing = Focus._(Ability.intelligence, "Brewing");
const cartography = Focus._(Ability.intelligence, "Cartography");
const cryptograpy = Focus._(Ability.intelligence, "Cryptography");
const culturalLore = Focus._(Ability.intelligence, "Cultural lore");
const engineering = Focus._(Ability.intelligence, "Engineering");
const evaluation = Focus._(Ability.intelligence, "Evaluation");
const healing = Focus._(Ability.intelligence, "Healing");
const heraldry = Focus._(Ability.intelligence, "Heraldry");
const historicalLore = Focus._(Ability.intelligence, "Historical lore");
const militaryLore = Focus._(Ability.intelligence, "Military lore");
const musicalLore = Focus._(Ability.intelligence, "Musical lore");
const naturalLore = Focus._(Ability.intelligence, "Natural lore");
const nauticalLore = Focus._(Ability.intelligence, "Nautical lore");
const navigation = Focus._(Ability.intelligence, "Navigation");
const religiousLore = Focus._(Ability.intelligence, "Religious lore");
const remoteWeapons = Focus._(Ability.intelligence, "Remote weapons");
const research = Focus._(Ability.intelligence, "Research");
const shaping = Focus._(Ability.intelligence, "Shaping");
const sorceryLore = Focus._(Ability.intelligence, "Sorcery lore");
const writing = Focus._(Ability.intelligence, "Writing");

const empathy = Focus._(Ability.perception, "Empathy");
const hearing = Focus._(Ability.perception, "Hearing");
const psychicPerception = Focus._(Ability.perception, "Psychic");
const searching = Focus._(Ability.perception, "Searching");
const seeing = Focus._(Ability.perception, "Seeing");
const smelling = Focus._(Ability.perception, "Smelling");
const tasting = Focus._(Ability.perception, "Tasting");
const touching = Focus._(Ability.perception, "Touching");
const tracking = Focus._(Ability.perception, "Tracking");
const visionary = Focus._(Ability.perception, "Visionary");

const perceptionFocuses = <Focus>[
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

const climbing = Focus._(Ability.strength, "Climbing");
const driving = Focus._(Ability.strength, "Driving");
const intimidation = Focus._(Ability.strength, "Intimidation");
const jumping = Focus._(Ability.strength, "Jumping");
const might = Focus._(Ability.strength, "Might");
const smithing = Focus._(Ability.strength, "Smithing");

const courage = Focus._(Ability.willpower, "Courage");
const faith = Focus._(Ability.willpower, "Faith");
const meditative = Focus._(Ability.willpower, "Meditative");
const morale = Focus._(Ability.willpower, "Morale");
const purity = Focus._(Ability.willpower, "Purity");
const selfDiscipline = Focus._(Ability.willpower, "Self-discipline");
