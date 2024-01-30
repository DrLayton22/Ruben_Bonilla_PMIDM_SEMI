import 'package:flutter/material.dart';
import 'package:tasca3/bloc/comarques_bloc.dart';
import 'package:tasca3/bloc/oratge_bloc.dart';
import 'package:tasca3/model/info_oratge.dart';
import 'package:tasca3/screens/info_comarca_1.dart';

class ComarcaInfoScreen2 extends StatelessWidget {
  final String comarca;
  final String capital;
  final String descripcion;
  final String imageCom;
  final String poblacio;
  final double latitud;
  final double longitud;

  const ComarcaInfoScreen2({
    Key? key,
    required this.comarca,
    required this.capital,
    required this.descripcion,
    required this.imageCom,
    required this.poblacio,
    required this.latitud,
    required this.longitud,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informació Comarca - 2/2'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: buildComarcaInfo(context),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        backgroundColor: const Color.fromARGB(255, 207, 206, 206),
        onTap: (index) {
          if (index == 0) {
            // Obtener la información de la comarca
            comarcaBloc.getInfoComarca(comarca);

            // Navegar a la ventana de información de la comarca
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ComarcaInfoScreen1(
                  comarca: comarca,
                  capital: capital,
                  descripcion: descripcion,
                  imageCom: imageCom,
                  poblacio: poblacio,
                  latitud: latitud,
                  longitud: longitud,
                ),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'La comarca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sunny),
            label: 'L\'oratge',
          ),
        ],
      ),
    );
  }

  Widget buildComarcaInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: StreamBuilder<InfoOratge>(
                stream: infoOratgeBloc.infoOratgeStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return const Text('No hi ha dades disponibles');
                  } else {
                    // Información del tiempo disponible
                    InfoOratge infoOratge = snapshot.data!;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.network(
                            'https://openweathermap.org/img/w/${infoOratge.codiOratge}.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Tiempo:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    traducirDescripcion(infoOratge.oratgeDesc),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Temperatura:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.thermostat),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${infoOratge.temperatura} °C',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Viento:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.air),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${infoOratge.velocitatVent} km/s',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String traducirDescripcion(String? descripcion) {
    if (descripcion != null) {
      switch (descripcion.toLowerCase()) {
        case 'clear sky':
          return 'Cielo despejado';
        case 'few clouds':
          return 'Pocas nubes';
        case 'scattered clouds':
          return 'Nubes dispersas';
        case 'broken clouds':
          return 'Nubosidad parcial';
        case 'shower rain':
          return 'Lluvia ligera';
        case 'rain':
          return 'Lluvia';
        case 'thunderstorm':
          return 'Tormenta';
        case 'snow':
          return 'Nieve';
        case 'mist':
          return 'Niebla';
        default:
          return descripcion;
      }
    } else {
      return "";
    }
  }
}
