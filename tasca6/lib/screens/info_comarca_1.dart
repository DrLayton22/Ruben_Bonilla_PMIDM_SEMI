import 'package:flutter/material.dart';
import 'package:tasca3/bloc/comarques_bloc.dart';
import 'package:tasca3/bloc/oratge_bloc.dart';
import 'package:tasca3/model/comarca.dart';
import 'package:tasca3/screens/info_comarca_2.dart';

class ComarcaInfoScreen1 extends StatelessWidget {
  final String comarca;
  final String capital;
  final String descripcion;
  final String imageCom;
  final String poblacio;
  final double latitud;
  final double longitud;

  const ComarcaInfoScreen1({
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
    Comarca comarcaData2 = Comarca(comarca: comarca);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informació Comarca - 1/2'),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<Comarca>(
          stream: comarcaBloc.infoComarcaStream,
          builder: (context, snapshotComarca) {
            if (snapshotComarca.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshotComarca.hasError) {
              return Center(child: Text('Error: ${snapshotComarca.error}'));
            } else {
              // La información de la comarca está disponible
              Comarca comarcaData = snapshotComarca.data!;
              print("Info Comarca 1: $comarcaData");
              comarcaData2 = comarcaData;

              return buildComarcaInfo(comarcaData);
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: const Color.fromARGB(255, 207, 206, 206),
        onTap: (index) async {
          if (index == 1) {
            try {
              // Navegar a ComarcaInfoScreen2
              infoOratgeBloc.carregaOratge(comarcaData2);
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ComarcaInfoScreen2(
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
            } catch (e) {
              print('Error al obtener la información del clima: $e');
            }
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'La comarca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny_outlined),
            label: 'L\' oratge',
          ),
        ],
      ),
    );
  }

  Widget buildComarcaInfo(Comarca comarcaData) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.network(
                comarcaData.img ?? "",
                width: 400,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: Text(
                comarca,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: Text(
                'Capital: ${comarcaData.capital ?? ""}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: Text(
                comarcaData.desc ?? "",
                style: const TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
