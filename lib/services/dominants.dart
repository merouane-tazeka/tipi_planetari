import 'package:dominanti_planetarie/services/constants.dart';
import 'package:dominanti_planetarie/services/dominant_calculation.dart';

class DominantsValue {
  DominantsValue({this.birthChart});

  final birthChart;
  Map<kPlanetsNames, int> dominants;

  Map calculateDominants() {
    var dominants = Map();
    kPlanetsNames.values.forEach((planet) {
      print('Computo $planet...');
      dominants[planet] =
          getDominantValue(birthChart: birthChart, dominantPlanet: planet);
      print(dominants);
    });
    return dominants;
  }
}
