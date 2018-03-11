/// Models the three Blue Rose Classes as an enum
enum CharacterClass {
  warrior, expert, adept, unknown
}

characterClassToString(CharacterClass cc) {
  switch (cc) {
    case CharacterClass.warrior:
      return "Warrior";
    case CharacterClass.expert:
      return "Expert";
    case CharacterClass.adept:
      return "Adept";
    default:
      return "Unknown";
  }
}