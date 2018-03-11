enum Race {
  human, nightPerson, rhydan, seaFolk, vata, unknown
}

raceToString(Race race) {
  switch (race) {
    case Race.human:
      return "Human";
    case Race.nightPerson:
      return "Night Person";
    case Race.rhydan:
      return "Rhydan";
    case Race.seaFolk:
      return "Sea-folk";
    case Race.vata:
      return "Vata";
    case Race.unknown:
    default:
      return "Race";
  }
}