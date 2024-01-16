import 'package:flutter/material.dart';
import 'package:tasca3/data/comarca.dart';
import 'package:tasca3/data/peticions_http.dart';
import 'package:tasca3/screens/info_comarca_1.dart';

class ComarquesScreen extends StatelessWidget {
  final String provincia;

  const ComarquesScreen({Key? key, required this.provincia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comarques de $provincia'),
      ),
      body: FutureBuilder<List<Comarca>>(
        future: PeticionsHTTP.obtenirComarquesPerProvincia(provincia),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data available.'),
            );
          } else {
            // Data available, display the list of comarques
            List<Comarca> comarques = snapshot.data!;

            return Container(
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
                  var comarca = comarcaData.comarca;
                  var imgPath =
                      comarcaData.img ?? ''; // Provide a default image if null

                  // ... (other widget code remains the same)

                  return ComarcaCard(
                    comarca: comarca,
                    imgPath: imgPath,
                    capital: comarcaData.capital ?? '',
                    descripcion: comarcaData.desc ?? '',
                    poblacio: comarcaData.poblacio ?? '',
                    latitud: comarcaData.latitud ?? 0.0,
                    longitud: comarcaData.longitud ?? 0.0,
                  );
                },
              ),
            );
          }
        },
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
