import 'package:flutter/material.dart';
import 'package:tasca3/bloc/comarques_bloc.dart';
import 'package:tasca3/model/provincia.dart';
import 'package:tasca3/screens/comarques.dart';

class ProvinciesScreen extends StatefulWidget {
  const ProvinciesScreen({Key? key}) : super(key: key);

  @override
  _ProvinciesScreenState createState() => _ProvinciesScreenState();
}

class _ProvinciesScreenState extends State<ProvinciesScreen> {
  @override
  Widget build(BuildContext context) {
    comarcaBloc.getProvincies();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Províncies'),
      ),
      body: StreamBuilder<List<Provincia>>(
        stream: comarcaBloc.provinciesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No hi ha dades disponibles');
          } else {
            List<Provincia> provincies = snapshot.data!;

            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/bg.webp"),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView.builder(
                itemCount: provincies.length,
                itemBuilder: (context, index) {
                  var provincia = provincies[index].nom;
                  var imgPath = provincies[index].img;

                  return ProvinciaCircleAvatar(
                    provincia: provincia,
                    imgPath: imgPath,
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

class ProvinciaCircleAvatar extends StatelessWidget {
  final String provincia;
  final String imgPath;

  const ProvinciaCircleAvatar({
    Key? key,
    required this.provincia,
    required this.imgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(imgPath),
              child: Text(
                provincia,
                style: const TextStyle(
                  color: Colors.white, // Texto en blanco
                  fontFamily: 'LeckerliOne-Regular',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black, // Color de la sombra
                      offset: Offset(2.0,
                          2.0), // Desplazamiento de la sombra (eje X, eje Y)
                      blurRadius: 3.0, // Radio de desenfoque de la sombra
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        // Acciones cuando se hace clic en la provincia
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComarquesScreen(provincia: provincia),
          ),
        );
      },
    );
  }
}
