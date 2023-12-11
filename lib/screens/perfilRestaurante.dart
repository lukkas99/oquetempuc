import 'package:flutter/material.dart';
import 'package:oquetempuc/main.dart';
import 'package:oquetempuc/model/fornecedor.dart';
import 'package:oquetempuc/screens/cadastroFornecedor2.dart';
import 'package:supabase/supabase.dart';

class PerfilRestaurante extends StatefulWidget {
  final int restauranteId; // O ID do restaurante passado como parâmetro

  PerfilRestaurante({required this.restauranteId});

  @override
  _PerfilRestauranteState createState() => _PerfilRestauranteState();
}

class _PerfilRestauranteState extends State<PerfilRestaurante> {
  Fornecedor? restaurante;

  @override
  void initState() {
    super.initState();
    _fetchRestauranteDetails();
  }

  Future<void> _fetchRestauranteDetails() async {
    try {
      final response = await supabase
          .from('fornecedor')
          .select()
          .eq('id', widget.restauranteId)
          .single();

      // Check if the response has an error
      if (response != null && response.containsKey('error')) {
        print(
            'Erro ao buscar detalhes do restaurante: ${response['error']?.message}');
        return;
      }

      // Assuming 'status' is a property you want to check for errors
      if (response != null &&
          response.containsKey('status') &&
          response['status'] == 400) {
        // Handle specific error case
        print('Erro ao buscar detalhes do restaurante: ${response}');
      } else {
        setState(() {
          // Adjust this part based on the actual structure of your response
          restaurante = Fornecedor.fromMap(response);
        });
      }
    } catch (e) {
      // Handle other types of errors (asynchronous)
      print('Erro ao buscar detalhes do restaurante: $e');
    }
  }

  Future<void> _desativaFornecedor(int restauranteId) async {
    final response = await supabase
        .from('fornecedor')
        .update({'ativo': false})
        .eq('id', restauranteId)
        .execute();

    if (response.status == 400) {
      // Trate o erro, se necessário
      print('Erro ao desativar fornecedor: ${response.data}');
    } else {
      // Fornecedor desativado com sucesso
      print('Fornecedor desativado com sucesso!');
    }
  }

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
      body: restaurante == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Image.network(restaurante!.url),
                      Text('Nome do restaurante: ${restaurante!.name}'),
                      Text('Endereço: ${restaurante!.address}'),
                      Text('O que servimos: ${restaurante!.service}'),
                      Text('Localização: ${restaurante!.location}'),
                      Text(
                        'Horário de funcionamento: ${restaurante!.funcionamento}',
                      ),
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
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
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
                              _desativaFornecedor(widget.restauranteId);
                            },
                            child: const Text(
                              'Desativar',
                              style: TextStyle(
                                color: AppColors.cobalt,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
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
