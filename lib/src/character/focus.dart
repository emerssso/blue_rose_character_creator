import 'package:blue_rose_character_creator/src/character/ability.dart';

///Models a single character focus: i.e. Dexterity(Horseback riding)
class Focus {
  ///Ability focus applies to
  final Ability ability;

  /**
   * String describing focus domain, i.e. "horseback riding".
   * The part in parentheses in game notation.
   */
  final String domain;

  ///If the focus has been improved (+2 -> +3)
  final bool improved;

  ///Bonus applied by the focus
  int get bonus => improved ? 3 : 2;

  Focus improve() => new Focus._init(this.ability, this.domain, improved: true);

  const Focus._init(this.ability, this.domain, {this.improved = false});
}

const arcane = const Focus._init(Ability.accuracy, "Arcane");
const bows = const Focus._init(Ability.accuracy, "Bows");
const brawling = const Focus._init(Ability.accuracy, "Brawling");
const lightBlades = const Focus._init(Ability.accuracy, "Light blades");
const staves = const Focus._init(Ability.accuracy, "Staves");
const naturalWeapon =
    const Focus._init(Ability.accuracy, "Natural weapon (pick one)");

const animalHandling =
    const Focus._init(Ability.communication, "Animal handling");
const animism = const Focus._init(Ability.communication, "Animism");
const bargaining = const Focus._init(Ability.communication, "Bargaining");
const deception = const Focus._init(Ability.communication, "Deception");
const disguise = const Focus._init(Ability.communication, "Disguise");
const etiquette = const Focus._init(Ability.communication, "Etiquette");
const gambling = const Focus._init(Ability.communication, "Gambling");
const investigation = const Focus._init(Ability.communication, "Investigation");
const leadership = const Focus._init(Ability.communication, "Leadership");
const performance = const Focus._init(Ability.communication, "Performance");
const persuasion = const Focus._init(Ability.communication, "Persuation");
const psychicCommunication =
    const Focus._init(Ability.communication, "Psychic");
const romance = const Focus._init(Ability.communication, "Romance");

const drinking = const Focus._init(Ability.constitution, "Drinking");
const rowing = const Focus._init(Ability.constitution, "Rowing");
const running = const Focus._init(Ability.constitution, "Running");
const stamina = const Focus._init(Ability.constitution, "Stamina");
const swimming = const Focus._init(Ability.constitution, "Swimming");

const acrobatics = const Focus._init(Ability.dexterity, "Acrobatics");
const artisan = const Focus._init(Ability.dexterity, "Artisan");
const calligraphy = const Focus._init(Ability.dexterity, "Calligraphy");
const crafting = const Focus._init(Ability.dexterity, "Crafting");
const initiative = const Focus._init(Ability.dexterity, "Initiative");
const legerdemain = const Focus._init(Ability.dexterity, "Legerdemain");
const lockPicking = const Focus._init(Ability.dexterity, "Lock picking");
const riding = const Focus._init(Ability.dexterity, "Riding");
const sailing = const Focus._init(Ability.dexterity, "Sailing");
const stealth = const Focus._init(Ability.dexterity, "Stealth");
const traps = const Focus._init(Ability.dexterity, "Traps");

const axes = const Focus._init(Ability.fighting, "Axes");
const bludgeons = const Focus._init(Ability.fighting, "Bludgeons");
const heavyBlades = const Focus._init(Ability.fighting, "Heavy blades");
const lances = const Focus._init(Ability.fighting, "Lances");
const polearms = const Focus._init(Ability.fighting, "Polearms");

const arcaneLore = const Focus._init(Ability.intelligence, "Arcane lore");
const brewing = const Focus._init(Ability.intelligence, "Brewing");
const cartography = const Focus._init(Ability.intelligence, "Cartography");
const cryptograpy = const Focus._init(Ability.intelligence, "Cryptography");
const culturalLore = const Focus._init(Ability.intelligence, "Cultural lore");
const engineering = const Focus._init(Ability.intelligence, "Engineering");
const evaluation = const Focus._init(Ability.intelligence, "Evaluation");
const healing = const Focus._init(Ability.intelligence, "Healing");
const heraldry = const Focus._init(Ability.intelligence, "Heraldry");
const historicalLore =
    const Focus._init(Ability.intelligence, "Historical lore");
const militaryLore = const Focus._init(Ability.intelligence, "Military lore");
const musicalLore = const Focus._init(Ability.intelligence, "Musical lore");
const naturalLore = const Focus._init(Ability.intelligence, "Natural lore");
const nauticalLore = const Focus._init(Ability.intelligence, "Nautical lore");
const navigation = const Focus._init(Ability.intelligence, "Navigation");
const religiousLore = const Focus._init(Ability.intelligence, "Religious lore");
const remoteWeapons = const Focus._init(Ability.intelligence, "Remote weapons");
const research = const Focus._init(Ability.intelligence, "Research");
const shaping = const Focus._init(Ability.intelligence, "Shaping");
const sorceryLore = const Focus._init(Ability.intelligence, "Sorcery lore");
const writing = const Focus._init(Ability.intelligence, "Writing");

const empathy = const Focus._init(Ability.perception, "Empathy");
const hearing = const Focus._init(Ability.perception, "Hearing");
const psychicPerception = const Focus._init(Ability.perception, "Psychic");
const searching = const Focus._init(Ability.perception, "Searching");
const seeing = const Focus._init(Ability.perception, "Seeing");
const smelling = const Focus._init(Ability.perception, "Smelling");
const tasting = const Focus._init(Ability.perception, "Tasting");
const touching = const Focus._init(Ability.perception, "Touching");
const tracking = const Focus._init(Ability.perception, "Tracking");
const visionary = const Focus._init(Ability.perception, "Visionary");

const List<Focus> perceptionFocuses = const [
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

const climbing = const Focus._init(Ability.strength, "Climbing");
const driving = const Focus._init(Ability.strength, "Driving");
const intimidation = const Focus._init(Ability.strength, "Intimidation");
const jumping = const Focus._init(Ability.strength, "Jumping");
const might = const Focus._init(Ability.strength, "Might");
const smithing = const Focus._init(Ability.strength, "Smithing");

const courage = const Focus._init(Ability.willpower, "Courage");
const faith = const Focus._init(Ability.willpower, "Faith");
const meditative = const Focus._init(Ability.willpower, "Meditative");
const morale = const Focus._init(Ability.willpower, "Morale");
const purity = const Focus._init(Ability.willpower, "Purity");
const selfDiscipline = const Focus._init(Ability.willpower, "Self-discipline");
