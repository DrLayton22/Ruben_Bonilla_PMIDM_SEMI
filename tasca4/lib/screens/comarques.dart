import 'package:flutter/material.dart';
import 'package:tasca3/screens/info_comarca_1.dart';
import '/data/comarques.dart';

class ComarquesScreen extends StatelessWidget {
  final String provincia;

  const ComarquesScreen({Key? key, required this.provincia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtenim les comarques de la província seleccionada
    List comarques = provincies
        .firstWhere((prov) => prov['provincia'] == provincia)['comarques'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Comarques de $provincia'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/bg.webp"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: comarques.length,
          itemBuilder: (context, index) {
            var comarcaData = comarques[index];
            var comarca = comarcaData['comarca'];
            var imgPath = comarcaData['img'];
            var capital = comarcaData['capital'];
            var descripcion = comarcaData['desc'];
            var poblacio = comarcaData['poblacio'];
            var latitud = comarcaData['latitud'];
            var longitud = comarcaData['longitud'];

            return ComarcaCard(
              comarca: comarca,
              imgPath: imgPath,
              capital: capital,
              descripcion: descripcion,
              poblacio: poblacio,
              latitud: latitud,
              longitud: longitud,
            );
          },
        ),
      ),
    );
  }
}

class ComarcaCard extends StatelessWidget {
  final String comarca;
  final String imgPath;
  final String capital;
  final String descripcion;
  final String poblacio;
  final double longitud;
  final double latitud;

  const ComarcaCard({
    Key? key,
    required this.comarca,
    required this.imgPath,
    required this.capital,
    required this.descripcion,
    required this.poblacio,
    required this.longitud,
    required this.latitud,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          // Acciones cuando se hace clic en la comarca

          //Info comarca 2
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComarcaInfoScreen1(
                comarca: comarca,
                capital: capital,
                descripcion: descripcion,
                imageCom: imgPath,
                poblacio: poblacio,
                latitud: latitud,
                longitud: longitud,
                imageWet: "assets/img/sun.png",
              ),
            ),
          );
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imgPath),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                comarca,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
