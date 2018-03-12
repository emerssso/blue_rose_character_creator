enum Ability {
  accuracy,
  communication,
  constitution,
  dexterity,
  fighting,
  intelligence,
  perception,
  strength,
  willpower
}

String nameOf(Ability a) {
  switch(a) {
    case Ability.accuracy: return "Accuracy";
    case Ability.communication: return "Communication";
    case Ability.constitution: return "Constitution";
    case Ability.dexterity: return "Dexterity";
    case Ability.fighting: return "Fighting";
    case Ability.intelligence: return "Intelligence";
    case Ability.perception: return "Perception";
    case Ability.strength: return "Strength";
    case Ability.willpower: return "Willpower";
    default: throw "Could not match ability $a";
  }
}