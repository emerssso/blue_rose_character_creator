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

String backgroundToString(Background bg) {
  switch(bg) {
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
