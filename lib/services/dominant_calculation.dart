import 'package:dominanti_planetarie/services/aspects_check.dart';
import 'package:dominanti_planetarie/services/constants.dart';
import 'package:flutter/material.dart';

int getDominantValue(
    {@required dynamic birthChart, @required PlanetsNames dominantPlanet}) {
  int _dominantValue = 0;

  //Imposto i segni di domicilio primario, domicilio secondario, esaltazione per il pianeta
  Signs signOfPrimeDom = kPlanetsOfSigns.keys.firstWhere(
      (element) => (kPlanetsOfSigns[element].primaryDom == dominantPlanet),
      orElse: () => null);
  Signs signOfSecondDom = kPlanetsOfSigns.keys.firstWhere(
      (element) => (kPlanetsOfSigns[element].secondaryDom == dominantPlanet),
      orElse: () => null);
  Signs signOfExaltation = kPlanetsOfSigns.keys.firstWhere(
      (element) => (kPlanetsOfSigns[element].exaltation == dominantPlanet),
      orElse: () => null);

  //Imposto le case cosignficanti del domicilio primario, domicilio secondario ed esaltazione per il pianeta
  int houseOfPrime = signOfPrimeDom == null ? 0 : signOfPrimeDom.index.toInt();
  int houseOfSecond =
      signOfSecondDom == null ? 0 : signOfSecondDom.index.toInt();
  int houseOfExalt =
      signOfExaltation == null ? 0 : signOfExaltation.index.toInt();

  int _upperConjunction(PlanetsNames planet) {
    return (planetAngleConjunction(
        birthChart: birthChart, planet: planet, angle: Angles.asc) ||
        planetAngleConjunction(
            birthChart: birthChart, planet: planet, angle: Angles.mc))
        ? kUpperConjunction
        : 0;
  }

  int _downConjunction(PlanetsNames planet) {
    return (planetAngleConjunction(
        birthChart: birthChart, planet: planet, angle: Angles.desc) ||
        planetAngleConjunction(
            birthChart: birthChart, planet: planet, angle: Angles.ic))
        ? kDownConjunction
        : 0;
  }

  int _ascInPrimeDom() {
    if (signOfPrimeDom != null) {
      return angleInSign(
              birthChart: birthChart, angle: Angles.asc, sign: signOfPrimeDom)
          ? kAscInPrimeDom
          : 0;
    } else {
      return 0;
    }
  }

  int _ascInSecondDom(PlanetsNames planet) {
    int _value = signOfSecondDom == null
        ? 0
        : angleInSign(
        birthChart: birthChart,
        angle: Angles.asc,
        sign: signOfSecondDom)
        ? planet == PlanetsNames.sun
        ? kAscInSecondDomSun
        : kAscInSecondDom
        : 0;
    return _value;
  }

  int _ascInExalt() {
    int _value = signOfExaltation == null
        ? 0
        : angleInSign(
                birthChart: birthChart,
                angle: Angles.asc,
                sign: signOfExaltation)
            ? kAscInExalt
            : 0;
    return _value;
  }

  int _sunInPrimeDom() {
    int _value = signOfPrimeDom == null
        ? 0
        : planetInSign(
        birthChart: birthChart,
        planet: PlanetsNames.sun,
        sign: signOfPrimeDom)
            ? kSunInPrimeDom
            : 0;
    return _value;
  }

  int _sunInSecondDom(PlanetsNames planet) {
    int _value = signOfSecondDom == null
        ? 0
        : planetInSign(
        birthChart: birthChart,
        planet: PlanetsNames.sun,
        sign: signOfSecondDom)
        ? planet == PlanetsNames.sun
        ? kSunInSecondDomSun
        : kSunInSecondDom
        : 0;
    return _value;
  }

  int _sunInExalt() {
    int _value = signOfExaltation == null
        ? 0
        : planetInSign(
        birthChart: birthChart,
        planet: PlanetsNames.sun,
        sign: signOfExaltation)
        ? kSunInExalt
        : 0;
    return _value;
  }

  int _planetInPrimeDom(PlanetsNames planet) {
    int _value = (signOfPrimeDom == null) || (planet == PlanetsNames.sun)
        ? 0
        : planetInSign(
        birthChart: birthChart, planet: planet, sign: signOfPrimeDom)
        ? Planet(planet).isFast()
        ? kPlanFastInPrimeDom
        : kPlanSlowInPrimeDom
        : 0;
    return _value;
  }

  int _planetInSecondDom(PlanetsNames planet) {
    int _value = (signOfSecondDom == null) || (planet == PlanetsNames.sun)
        ? 0
        : planetInSign(birthChart: birthChart, planet: planet, sign: null)
        ? Planet(planet).isFast()
        ? kPlanFastInSecondDom
        : kPlanSlowInSecondDom
        : 0;
    return _value;
  }

  int _planetInExalt(PlanetsNames planet) {
    int _value = (signOfExaltation == null) || (planet == PlanetsNames.sun)
        ? 0
        : planetInSign(
        birthChart: birthChart, planet: planet, sign: signOfExaltation)
        ? Planet(planet).isFast()
        ? kPlanFastInExalt
        : kPlanSlowInExal
        : 0;
    return _value;
  }

  int _moonInPlanetSigns(PlanetsNames planet) {
    int _value;
    var _moonCheck = (Signs sign) =>
        planetInSign(
            birthChart: birthChart, planet: PlanetsNames.moon, sign: sign);
    if (planet == PlanetsNames.moon) {
      _value = 0;
    } else {
      _value = (signOfPrimeDom != null)
          ? _moonCheck(signOfPrimeDom)
          ? kMoonInPlanetSigns
          : 0
          : 0;
      _value = (signOfSecondDom != null)
          ? _moonCheck(signOfSecondDom)
          ? kMoonInPlanetSigns
              : 0
          : 0;
      _value = (signOfExaltation != null)
          ? _moonCheck(signOfExaltation)
              ? kMoonInPlanetSigns
              : 0
          : 0;
    }
    return _value;
  }

  int _stelliumInPrimeDom() {
    int _value = (signOfPrimeDom == null)
        ? 0
        : stelliumInSign(birthChart: birthChart, sign: signOfPrimeDom)
            ? kStelliumInPrimeDom
            : 0;
    return _value;
  }

  int _stelliumInSecondDom() {
    int _value = (signOfSecondDom == null)
        ? 0
        : stelliumInSign(birthChart: birthChart, sign: signOfSecondDom)
            ? kStelliumInSecondDom
            : 0;
    return _value;
  }

  int _stelliumInExalt() {
    int _value = (signOfExaltation == null)
        ? 0
        : stelliumInSign(birthChart: birthChart, sign: signOfExaltation)
        ? kStelliumInExalt
        : 0;
    return _value;
  }

  int _sunPlanetConjunction(PlanetsNames planet) {
    int _value = planet == PlanetsNames.sun
        ? 0
        : planetPlanetConjunction(
        birthChart: birthChart,
        planet1: PlanetsNames.sun,
        planet2: planet)
        ? kSunPlanetConjunction
        : 0;
    return _value;
  }

  int _moonPlanetConjunction(PlanetsNames planet) {
    int _value = (planet == PlanetsNames.moon) || (planet == PlanetsNames.sun)
        ? 0
        : planetPlanetConjunction(
        birthChart: birthChart,
        planet1: PlanetsNames.moon,
        planet2: planet)
        ? kMoonPlanetConjunction
        : 0;
    return _value;
  }

  int _planetInHouseOfPrime(PlanetsNames planet) {
    int _value = houseOfPrime == 0
        ? 0
        : planetInHouse(
        birthChart: birthChart, planet: planet, houseNr: houseOfPrime)
        ? kPlanetInHouseOfPrime
        : 0;
    return _value;
  }

  int _planetInHouseOfSecond(PlanetsNames planet) {
    int _value = houseOfSecond == 0
        ? 0
        : planetInHouse(
        birthChart: birthChart, planet: planet, houseNr: houseOfSecond)
        ? planet == PlanetsNames.sun
        ? kPlanetInHouseOfSecondSun
        : kPlanetInHouseOfSecond
        : 0;
    return _value;
  }

  int _planetInHouseOfExalt(PlanetsNames planet) {
    int _value = houseOfExalt == 0
        ? 0
        : planetInHouse(
        birthChart: birthChart, planet: planet, houseNr: houseOfExalt)
        ? kPlanetInHouseOfExalt
        : 0;
    return _value;
  }

  int _sunInHouseOfPrime(PlanetsNames planet) {
    int _value = (houseOfPrime == 0) || (planet == PlanetsNames.sun)
        ? 0
        : planetInHouse(
        birthChart: birthChart,
        planet: PlanetsNames.sun,
        houseNr: houseOfPrime)
        ? kSunInHouseOfPrime
        : 0;
    return _value;
  }

  int _sunInHouseOfSecond(PlanetsNames planet) {
    int _value = (houseOfSecond == 0) || (planet == PlanetsNames.sun)
        ? 0
        : planetInHouse(
        birthChart: birthChart,
        planet: PlanetsNames.sun,
        houseNr: houseOfSecond)
        ? kSunInHouseOfSecond
        : 0;
    return _value;
  }

  _dominantValue = _upperConjunction(dominantPlanet) +
      _downConjunction(dominantPlanet) +
      _ascInPrimeDom() +
      _ascInSecondDom(dominantPlanet) +
      _ascInExalt() +
      _sunInPrimeDom() +
      _sunInSecondDom(dominantPlanet) +
      _sunInExalt() +
      _planetInPrimeDom(dominantPlanet) +
      _planetInSecondDom(dominantPlanet) +
      _planetInExalt(dominantPlanet) +
      _moonInPlanetSigns(dominantPlanet) +
      _stelliumInPrimeDom() +
      _stelliumInSecondDom() +
      _stelliumInExalt() +
      _sunPlanetConjunction(dominantPlanet) +
      _moonPlanetConjunction(dominantPlanet) +
      _planetInHouseOfPrime(dominantPlanet) +
      _planetInHouseOfSecond(dominantPlanet) +
      _planetInHouseOfExalt(dominantPlanet) +
      _sunInHouseOfPrime(dominantPlanet) +
      _sunInHouseOfSecond(dominantPlanet);

//TODO qui va sistemato
  if (dominantPlanet == PlanetsNames.venus) {
    print('Per venere sto restituendo il valore $_dominantValue');
  }
  return _dominantValue;
}