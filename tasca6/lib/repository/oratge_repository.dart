// lib/repository/oratge_repository.dart
import 'package:tasca3/data/peticions_http.dart';
import 'package:tasca3/model/info_oratge.dart';

class InfoOratgeRepository {
  Future<InfoOratge> obtenirInfoOratge(double latitud, double longitud) async {
    final climaData = await PeticionsHTTP.obtenerInfoClima(latitud, longitud);

    print(climaData);
    return InfoOratge(
      temperatura: (climaData['main']['temp'] - 273.15).toStringAsFixed(2),
      velocitatVent: (climaData['wind']['speed'] * 3.6).toStringAsFixed(2),
      direccioVent: climaData['wind']['deg'].toString(),
      codiOratge: climaData['weather'][0]['icon'],
      oratgeDesc: climaData['weather'][0]['description'],
    );
  }
}
