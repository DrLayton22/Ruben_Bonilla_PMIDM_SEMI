// lib/repository/comarca_repository.dart
import 'package:tasca3/model/comarca.dart';
import 'package:tasca3/data/peticions_http.dart';
import 'package:tasca3/model/provincia.dart';

class ComarquesRepository {
  Future<List<Provincia>> getProvincies() async {
    return PeticionsHTTP.obtenirProvincies();
  }

  Future<List<Comarca>> getComarquesPerProvincia(String nomProvincia) async {
    return PeticionsHTTP.obtenirComarquesPerProvincia(nomProvincia);
  }

  Future<Comarca> getInfoComarca(String nomComarca) async {
    return PeticionsHTTP.obtenirInfoComarca(nomComarca);
  }
}
