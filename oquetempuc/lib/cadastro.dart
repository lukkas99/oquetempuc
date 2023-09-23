import 'package:flutter/material.dart';
import 'principal.dart';
import 'main.dart';
import 'cadastroCliente.dart';
import 'cadastroFornecedor.dart';

class Cadastro extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Define o fundo como transparente
        elevation: 0, // Remove a sombra da AppBar
        iconTheme: IconThemeData(
            size: 32.0,
            color: Colors.black), // Define a cor do ícone como preto
        title: null, // Define o título como nulo para remover o texto
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Row(
                  children: <Widget>[
                    Text(
                      'Cadastro',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.3),
                    const ImageIcon(
                      AssetImage('assets/images/iconPrincipal.png'),
                      color: Colors.black,
                      size: 45.0,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    Text(
                      'O que tem? \n PUC Coreu',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.1), // Espaço entre a Row e a Column

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                          MaterialPageRoute(
                              builder: (context) => CadastroFornecedor()),
                        );
                      },
                      child: const Text(
                        'SOU FORNECEDOR',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
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
                          MaterialPageRoute(
                              builder: (context) => CadastroCliente()),
                        );
                      },
                      child: const Text(
                        'SOU CLIENTE',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
