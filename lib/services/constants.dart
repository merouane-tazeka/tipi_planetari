import 'package:flutter/cupertino.dart';

const kImmanuelURL = 'https://api.immanuel.app/chart/natal';
const kImmanuelApiKey = 'SzQN82nJLOmFX7ASAuWxpYywTFVT55Ov';
const kImmanuelSecret = 'rX9sgmysBLVj';
const kHouseSystem = 'Placidus';

// Ampiezza della congiunzione
const kConjunction = 10;

// Numero di pianeti per avere uno stellium
const kStelliumPlanetsNr = 3;

// Punti per congiunzione del pianeta al
const kUpperConjunction = 10; //MC o ASC
const kDownConjunction = 7; //FC o DIS

// Punti per Ascendente in
const kAscInPrimeDom = 5; //domicilio primario
const kAscInSecondDom = 4; //domicilio secondario
const kAscInSecondDomSun = 5; //domicilio secondario per dominante solare
const kAscInExalt = 3; //esaltazione

//TODO da verificare se Plutone va gestito come caso speciale
// Punti per Sole in
const kSunInPrimeDom = 6; //domicilio primario
const kSunInSecondDom = 5; //domicilio secondario
const kSunInSecondDomSun = 6; //domicilio secondario per dominante solare
const kSunInExalt = 4; //esaltazione

//TODO da verificare se Plutone va gestito come caso speciale
//Punti per pianeta lento in
const kPlanSlowInPrimeDom = 3; //domicilio primario
const kPlanSlowInSecondDom = 2; //domicilio secondario
const kPlanSlowInExal = 1; //esaltazione

//Punti per pianeta veloce in
const kPlanFastInPrimeDom = 6; //domicilio primario
const kPlanFastInSecondDom = 5; //domicilio secondario
const kPlanFastInExalt = 4; //esaltazione

//Punti per luna in domicilio primario o domicilio secondario o esaltazione
const kMoonInPlanetSigns = 3;

// Punti per stellium in
const kStelliumInPrimeDom = 3; //domicilio primario
const kStelliumInSecondDom = 3; //domicilio secondario
const kStelliumInExalt = 3; //esaltazione

// Punti per sole congiunto al pianeta
const kSunPlanetConjunction = 5;

// Punti per luna congiunto al pianeta
const kMoonPlanetConjunction = 5;

// Punti per pianeta in casa cosignificante al segno del
const kPlanetInHouseOfPrime = 5; //domicilio primario
const kPlanetInHouseOfSecond = 4; //domicilio secondario
const kPlanetInHouseOfSecondSun =
    5; //domicilio secondario in caso di dominante solare
const kPlanetInHouseOfExalt = 3; //esaltazione

// Punti per sole in casa cosignificante al segno del
const kSunInHouseOfPrime = 3; //domicilio primario
const kSunInHouseOfSecond = 2; //domicilio secondario
const kSunInHouseOfExalt = 1; //esaltazione

enum Signs {
  Aries,
  Taurus,
  Gemini,
  Cancer,
  Leo,
  Virgo,
  Libra,
  Scorpio,
  Sagittarius,
  Capricorn,
  Aquarius,
  Pisces
}
enum PlanetsNames {
  sun,
  moon,
  mercury,
  venus,
  mars,
  jupiter,
  saturn,
  uranus,
  neptune,
  pluto,
}
enum PlanetSpeed {
  slow,
  fast,
}
enum Angles {
  asc,
  mc,
  desc,
  ic,
}

class Planet {
  Planet(this.name);

  final PlanetsNames name;

  bool isFast() {
    return kPlanetsFast.contains(name);
  }

  bool isSlow() {
    return kPlanetsSlow.contains(name);
  }
}

//Lista dei pianeti lenti
final List<PlanetsNames> kPlanetsSlow = const [
  PlanetsNames.jupiter,
  PlanetsNames.saturn,
  PlanetsNames.uranus,
  PlanetsNames.neptune,
  PlanetsNames.pluto,
];

//Lista dei pianeti veloci
final List<PlanetsNames> kPlanetsFast = const [
  PlanetsNames.sun,
  PlanetsNames.moon,
  PlanetsNames.mercury,
  PlanetsNames.venus,
  PlanetsNames.mars,
];

final List<int> kHousesName =
    List.generate(12, (int index) => index + 1, growable: false);

class House {
  House({@required this.init, @required this.end});
  double init;
  double end;
}

class Dominant {
  Dominant({@required this.planet, @required this.value});

  PlanetsNames planet;
  int value;
}

class PlanetsOfSign {
  PlanetsOfSign(
      {@required this.primaryDom,
      @required this.exaltation,
      @required this.secondaryDom});

  PlanetsNames primaryDom;
  PlanetsNames exaltation;
  PlanetsNames secondaryDom;
}

final Map<Signs, PlanetsOfSign> kPlanetsOfSigns = {
  Signs.Aries: PlanetsOfSign(
      primaryDom: PlanetsNames.mars,
      exaltation: PlanetsNames.sun,
      secondaryDom: PlanetsNames.pluto),
  Signs.Taurus: PlanetsOfSign(
      primaryDom: null,
      exaltation: PlanetsNames.jupiter,
      secondaryDom: PlanetsNames.venus),
  Signs.Gemini: PlanetsOfSign(
      primaryDom: PlanetsNames.mercury,
      exaltation: PlanetsNames.pluto,
      secondaryDom: null),
  Signs.Cancer: PlanetsOfSign(
      primaryDom: PlanetsNames.moon,
      exaltation: PlanetsNames.venus,
      secondaryDom: null),
  Signs.Leo: PlanetsOfSign(
      primaryDom: null, exaltation: null, secondaryDom: PlanetsNames.sun),
  Signs.Virgo: PlanetsOfSign(
      primaryDom: null,
      exaltation: PlanetsNames.uranus,
      secondaryDom: PlanetsNames.mercury),
  Signs.Libra: PlanetsOfSign(
      primaryDom: PlanetsNames.venus,
      exaltation: PlanetsNames.saturn,
      secondaryDom: null),
  Signs.Scorpio: PlanetsOfSign(
      primaryDom: PlanetsNames.pluto,
      exaltation: PlanetsNames.mercury,
      secondaryDom: PlanetsNames.mars),
  Signs.Sagittarius: PlanetsOfSign(
      primaryDom: PlanetsNames.jupiter,
      exaltation: null,
      secondaryDom: PlanetsNames.neptune),
  Signs.Capricorn: PlanetsOfSign(
      primaryDom: PlanetsNames.saturn,
      exaltation: PlanetsNames.mars,
      secondaryDom: PlanetsNames.uranus),
  Signs.Aquarius: PlanetsOfSign(
      primaryDom: PlanetsNames.uranus,
      exaltation: PlanetsNames.neptune,
      secondaryDom: PlanetsNames.saturn),
  Signs.Pisces: PlanetsOfSign(
      primaryDom: PlanetsNames.neptune,
      exaltation: PlanetsNames.moon,
      secondaryDom: PlanetsNames.jupiter)
};
