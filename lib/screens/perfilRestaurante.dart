import 'package:flutter/material.dart';
import 'package:oquetempuc/db/DbHelper.dart';
import 'package:oquetempuc/main.dart';
import 'package:oquetempuc/model/fornecedor.dart';
import 'package:oquetempuc/screens/cadastroFornecedor2.dart';

class PerfilRestaurante extends StatefulWidget {
  final int restauranteId; // O ID do restaurante passado como parâmetro

  PerfilRestaurante({required this.restauranteId});

  @override
  _PerfilRestauranteState createState() => _PerfilRestauranteState();
}

class _PerfilRestauranteState extends State<PerfilRestaurante> {
  final DbHelper dbHelper = DbHelper();

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
      body: FutureBuilder<Fornecedor?>(
        future: dbHelper.getFornecedorById(widget.restauranteId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao buscar os detalhes do restaurante.'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Restaurante não encontrado.'));
          }

          final restaurante = snapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Image.network(restaurante.url),
                    Text('Nome do restaurante: ${restaurante.name}'),
                    Text('Endereço: ${restaurante.address}'),
                    Text('O que servimos: ${restaurante.service}'),
                    Text('Localização: ${restaurante.location}'),
                    Text(
                        'Horário de funcionamento: ${restaurante.funcionamento}'),

                    // Botões do CRUD
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(155, 50),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 2,
                                color: AppColors.cobalt,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CadastroFornecedor2(
                                  restauranteId: widget.restauranteId,
                                  email: '',
                                  encryptedPassword: '',
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Atualizar',
                            style: TextStyle(
                              color: AppColors.cobalt,
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(155, 50),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 2,
                                color: AppColors.cobalt,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            dbHelper.desativaFornecedor(widget.restauranteId);
                          },
                          child: const Text(
                            'Desativar',
                            style: TextStyle(
                              color: AppColors.cobalt,
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
