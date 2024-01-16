import 'package:flutter/material.dart';
import 'package:tasca3/screens/info_comarca_1.dart';

class ComarcaInfoScreen2 extends StatelessWidget {
  final String comarca;
  final String capital;
  final String descripcion;
  final String imageCom;
  final String poblacio;
  final double latitud;
  final double longitud;
  final String imageWet;

  const ComarcaInfoScreen2({
    Key? key,
    required this.comarca,
    required this.capital,
    required this.descripcion,
    required this.imageCom,
    required this.poblacio,
    required this.latitud,
    required this.longitud,
    required this.imageWet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informació Comarca - 2/2'),
      ),
      body: SingleChildScrollView(
        child: buildComarcaInfo(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        backgroundColor: const Color.fromARGB(255, 207, 206, 206),
        onTap: (index) {
          if (index == 0) {
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
                  imageWet: "assets/img/sun.png",
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
            label: 'L\' oratge',
          ),
        ],
      ),
    );
  }

  Widget buildComarcaInfo() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                imageWet,
                width: 400,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Població:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    poblacio,
                    style: const TextStyle(fontSize: 20),
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
                    'Latitud:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    latitud.toString(),
                    style: const TextStyle(fontSize: 20),
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
                    'Longitud:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    longitud.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
