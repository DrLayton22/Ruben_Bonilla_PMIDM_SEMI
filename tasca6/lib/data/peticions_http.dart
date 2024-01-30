// lib/peticions_http.dart
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tasca3/model/comarca.dart';
import 'package:tasca3/model/provincia.dart';

class PeticionsHTTP {
  static Future<Comarca> obtenirInfoComarca(String nomComarca) async {
    final response = await http.get(
      Uri.parse(
          'https://node-comarques-rest-server-production.up.railway.app/api/comarques/infoComarca/$nomComarca'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Comarca.fromJSON(data);
    } else {
      throw Exception('Error en la petició HTTP');
    }
  }

  static Future<List<Comarca>> obtenirComarquesPerProvincia(
      String nomProvincia) async {
    final response = await http.get(
      Uri.parse(
          'https://node-comarques-rest-server-production.up.railway.app/api/comarques/comarquesAmbImatge/$nomProvincia'),
    );

    if (response.statusCode == 200) {
      final List<dynamic>? data = json.decode(response.body);

      if (data != null) {
        return data.map((comarcaData) {
          try {
            if (kDebugMode) {
              print('Dades de la API: $comarcaData');
            }
            // Pasa tanto el nombre como la imagen al constructor
            return Comarca.fromJSON(comarcaData);
          } catch (e) {
            print('Error al crear una instància de Comarca: $e');
            rethrow;
          }
        }).toList();
      } else {
        throw Exception('Dades nules rebudes del servidor');
      }
    } else {
      throw Exception('Error en la petició HTTP: ${response.statusCode}');
    }
  }

  static Future<List<Provincia>> obtenirProvincies() async {
    final response = await http.get(
      Uri.parse(
          'https://node-comarques-rest-server-production.up.railway.app/api/comarques'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((provinciaData) {
        try {
          return Provincia.fromJson(provinciaData);
        } catch (e) {
          print('Error al crear una instància de Provincia: $e');
          rethrow;
        }
      }).toList();
    } else {
      throw Exception('Error en la petició HTTP: ${response.statusCode}');
    }
  }

  static Future<dynamic> obtenerInfoClima(
      double latitud, double longitud) async {
    const apiKey = '69801016d3c946f85b19c2b359dc575b';
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitud&lon=$longitud&appid=$apiKey';

    print(apiUrl);
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error en la petición HTTP: ${response.statusCode}');
    }
  }
}
