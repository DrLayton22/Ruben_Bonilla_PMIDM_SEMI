import 'package:flutter/material.dart';
import 'package:tasca3/screens/info_comarca_2.dart';

class ComarcaInfoScreen1 extends StatelessWidget {
  final String comarca;
  final String capital;
  final String descripcion;
  final String imageCom;
  final String poblacio;
  final double latitud;
  final double longitud;
  final String imageWet;

  const ComarcaInfoScreen1({
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
        title: const Text('Informació Comarca - 1/2'),
      ),
      body: SingleChildScrollView(
        child: buildComarcaInfo(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: const Color.fromARGB(255, 207, 206, 206),
        onTap: (index) {
          if (index == 1) {
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
                  imageWet: "assets/img/sun.png",
                ),
              ),
            );
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

  Widget buildComarcaInfo() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.network(
                imageCom,
                width: 400,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: Text(
                comarca,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: Text(
                'Capital: $capital',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: Text(
                descripcion,
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
