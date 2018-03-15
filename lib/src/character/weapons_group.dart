enum WeaponsGroup {
  axes,
  bludgeons,
  bows,
  brawling,
  heavyBlades,
  lances,
  lightBlades,
  naturalWeapons,
  polearms,
  staves,
  rangedWeapons
}

String weaponsGroupToString(WeaponsGroup wg) {
  switch(wg) {
    case WeaponsGroup.axes:
      return "Axes";
    case WeaponsGroup.bludgeons:
      return "Bludgeons";
    case WeaponsGroup.bows:
      return "Bows";
    case WeaponsGroup.brawling:
      return "Brawling";
    case WeaponsGroup.heavyBlades:
      return "Heavy blades";
    case WeaponsGroup.lances:
      return "Lances";
    case WeaponsGroup.lightBlades:
      return "Light blades";
    case WeaponsGroup.naturalWeapons:
      return "Natural weapons";
    case WeaponsGroup.polearms:
      return "Polearms";
    case WeaponsGroup.staves:
      return "Staves";
    case WeaponsGroup.rangedWeapons:
      return "Ranged weapons";
    default:
      return "Weapons";
  }
}