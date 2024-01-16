import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tasca3/screens/provincies.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/bg.webp"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/img/logo.png", width: 250, height: 250),
                  const SizedBox(height: 20),
                  const Text(
                    'Les nostres comarques',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'LeckerliOne-Regular',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Usuari',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Contrasenya',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProvinciesScreen(),
                                  ),
                                );
                              },
                              child: const Text('Log In'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _showRegisterDialog(context);
                              },
                              child: const Text('Registrarse'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showRegisterDialog(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Formulari de Registre'),
          content: Column(
            children: [
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Usuari',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Contrasenya',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Handle registration logic here
                _registerUser();
                Navigator.pop(context);
              },
              child: const Text('Registrar-se'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Cancel·lar el registre
              },
              child: const Text('Cancel·lar'),
            ),
          ],
        );
      },
    );
  }

  void _registerUser() {
    // Use the registered values as needed
    String username = usernameController.text;
    String password = passwordController.text;

    // TO DO: Lógica del login
    if (kDebugMode) {
      print('Registered user: $username with password: $password');
    }
  }
}
