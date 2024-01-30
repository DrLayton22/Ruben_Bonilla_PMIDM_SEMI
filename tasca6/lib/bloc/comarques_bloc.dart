// lib/bloc/comarca_bloc.dart
import 'dart:async';

import 'package:tasca3/model/comarca.dart';
import 'package:tasca3/model/provincia.dart';
import 'package:tasca3/repository/comarques_repository.dart';

class ComarcaBloc {
  String? _provinciaActual;
  String? _nomComarcaActual;
  Comarca? comarcaActual;
  List<Comarca>? _llistaComarques;

  final _comarquesController = StreamController<List<Comarca>>.broadcast();
  final _provinciesController = StreamController<List<Provincia>>.broadcast();
  final _infoComarcaController = StreamController<Comarca>.broadcast();

  final ComarquesRepository _repository = ComarquesRepository();

  Stream<List<Comarca>> get comarquesStream => _comarquesController.stream;
  Stream<List<Provincia>> get provinciesStream => _provinciesController.stream;
  Stream<Comarca> get infoComarcaStream => _infoComarcaController.stream;

  set provinciaActual(String? provincia) {
    if (provincia != null) {
      if (_provinciaActual != provincia) {
        _provinciaActual = provincia;
        getComarquesPerProvincia(_provinciaActual!);
      } else {
        actualitzaComarques();
      }
    }
  }

  set nomComarcaActual(String? comarca) {
    if (comarca != null) {
      if (_nomComarcaActual != comarca) {
        _nomComarcaActual = comarca;
        getInfoComarca(comarca);
      } else {
        actualitzaComarca();
      }
    }
  }

  void getProvincies() async {
    final provincies = await _repository.getProvincies();
    _provinciesController.sink.add(provincies);
  }

  void getComarquesPerProvincia(String nomProvincia) async {
    try {
      final comarques =
          await _repository.getComarquesPerProvincia(nomProvincia);
      _llistaComarques = comarques;
      _comarquesController.add(_llistaComarques!);
    } catch (e) {
      print('Error al obtenir comarques: $e');
    }
  }

  void actualitzaComarques() async {
    // Afegim una espera asíncrona de durada zero (Zero-Duration Delay)
    await Future.delayed(Duration.zero);
    // Emetem llista de comarques actual per l'Stream
    _comarquesController.sink.add(_llistaComarques!);
  }

  void getInfoComarca(String nomComarca) async {
    final infoComarca = await _repository.getInfoComarca(nomComarca);
    comarcaActual = infoComarca;
    _infoComarcaController.sink.add(comarcaActual!);
  }

  void actualitzaComarca() async {
    // Afegim una espera asíncrona de durada zero (Zero-Duration Delay)
    await Future.delayed(Duration.zero);
    // Emetem la informació de la comarca actual per l'Stream de les comarques
    _infoComarcaController.sink.add(comarcaActual!);
  }

  void dispose() {
    _comarquesController.close();
    _provinciesController.close();
    _infoComarcaController.close();
  }
}

final comarcaBloc = ComarcaBloc();
