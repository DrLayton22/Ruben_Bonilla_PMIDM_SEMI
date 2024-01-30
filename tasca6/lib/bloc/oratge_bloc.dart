// lib/bloc/info_oratge_bloc.dart
import 'dart:async';

import 'package:tasca3/model/info_oratge.dart';
import 'package:tasca3/repository/oratge_repository.dart';

import '../model/comarca.dart';

class InfoOratgeBloc {
  final _infoOratgeController = StreamController<InfoOratge>.broadcast();
  Comarca? _comarcaActual;

  final InfoOratgeRepository _repository = InfoOratgeRepository();
  InfoOratge? _infoOratge;

  Stream<InfoOratge> get infoOratgeStream => _infoOratgeController.stream;

  set comarcaActual(Comarca? comarca) {
    if (comarca != null && _comarcaActual != comarca) {
      _comarcaActual = comarca;
      carregaOratge(comarca);
    }
  }

  void carregaOratge(Comarca comarca) async {
    _infoOratge = await _repository.obtenirInfoOratge(
        comarca.latitud ?? 0.0, comarca.longitud ?? 0.0);
    actualitzaOratge();
  }

  void actualitzaOratge() async {
    await Future.delayed(Duration.zero);
    _infoOratgeController.sink.add(_infoOratge!);
  }

  void dispose() {
    _infoOratgeController.close();
  }
}

final infoOratgeBloc = InfoOratgeBloc();
