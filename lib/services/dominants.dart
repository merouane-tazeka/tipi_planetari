import 'package:dominanti_planetarie/services/constants.dart';
import 'package:dominanti_planetarie/services/dominant_calculation.dart';

class DominantsValue {
  DominantsValue({this.birthChart});

  final birthChart;
  Map<PlanetsNames, int> dominants;

  Map calculateDominants() {
    var dominants = Map();
    PlanetsNames.values.forEach((planet) {
      print('Computo $planet...');
      dominants[planet] =
          getDominantValue(birthChart: birthChart, dominantPlanet: planet);
      print(dominants);
    });
    return dominants;
  }
}