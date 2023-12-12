import 'package:flutter/material.dart';
import 'package:oquetempuc/screens/principal.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'screens/login.dart';
import 'screens/cadastro.dart';
import 'package:oquetempuc/db/Dbhelper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppColors {
  static const Color cobalt = Color(0xFF000C76); // Sua cor personalizada
  static const Color snow =
      Color.fromARGB(255, 237, 237, 237); // Sua cor personalizada
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://bzvujouhkefuafxunovd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ6dnVqb3Voa2VmdWFmeHVub3ZkIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTkzNjU1MzIsImV4cCI6MjAxNDk0MTUzMn0.UXgwmqMwMPYpIR29F0FX0huT1G0F8m5xVcFy0NKs54I',
    authFlowType: AuthFlowType.pkce,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TelaInicial(),
  ));
}

final supabase = Supabase.instance.client;

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicial createState() => _TelaInicial();
}

class _TelaInicial extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/pucentrada.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Outros widgets podem ser adicionados aqui
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Icon
                const ImageIcon(
                  AssetImage('assets/images/iconPrincipal.png'),
                  color: Colors.white,
                  size: 150.0,
                ),
                // Título
                Stack(
                  children: <Widget>[
                    Text(
                      'O que tem? \n PUC Coreu',
                      style: TextStyle(
                        fontSize: 48,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1.5
                          ..color = AppColors.cobalt,
                      ),
                    ),
                    const Text(
                      'O que tem? \n PUC Coreu',
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.15), // Espaço entre o título e os botões
                // Botões de login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(155, 50),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 2, // thickness
                                  color: AppColors.cobalt // color
                                  ),
                              // border radius
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaPrincipal(
                                    userName: 'nome',
                                    userEmail: 'mail',
                                    userPassword: '555',
                                    userType: 'cliente',
                                  )),
                        );
                      },
                      child: const Text(
                        'ENTRAR SEM LOGIN',
                        style: TextStyle(
                          color: AppColors.cobalt,
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(155, 50),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 2, // thickness
                                  color: AppColors.cobalt // color
                                  ),
                              // border radius
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TelaLogin()),
                        );
                      },
                      child: const Text(
                        'FAZER LOGIN',
                        style: TextStyle(
                          color: AppColors.cobalt,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(155, 50),
                      backgroundColor: AppColors.cobalt,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 2, // thickness
                              color: Colors.white // color
                              ),
                          // border radius
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cadastro()),
                    );
                  },
                  child: const Text(
                    'CADASTRAR',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
