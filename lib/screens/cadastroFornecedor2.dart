import 'package:flutter/material.dart';
import 'package:oquetempuc/screens/perfilRestaurante.dart';
import 'package:oquetempuc/screens/principal.dart';
import 'produtos.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:oquetempuc/db/DbHelper.dart';
import 'package:oquetempuc/model/fornecedor.dart';
import 'package:oquetempuc/screens/login.dart';
import 'package:oquetempuc/comm/comHelper.dart';

class CadastroFornecedor2 extends StatefulWidget {
  final String email;
  final String encryptedPassword;
  var restauranteId;

  CadastroFornecedor2({
    required this.email,
    required this.encryptedPassword,
    this.restauranteId,
  });
  @override
  _CadastroFornecedor2State createState() => _CadastroFornecedor2State();
}

class _CadastroFornecedor2State extends State<CadastroFornecedor2> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  int selectedRadio = 0;
  TextEditingController funcionamentoController = TextEditingController();
  bool isActive = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> cadastrarFornecedor(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Crie uma instância da classe Fornecedor com os dados do formulário
      final fornecedor = Fornecedor(
        email: widget.email,
        encryptedPassword: widget.encryptedPassword,
        name: nameController.text,
        cep: cepController.text,
        address: addressController.text,
        service: serviceController.text,
        url: urlController.text,
        location: selectedRadio,
        funcionamento: funcionamentoController.text,
        isActive: true,
      );

      try {
        final response = await supabase.from('fornecedor').upsert(
          {
            'email': fornecedor.email,
            'encrypted_password': fornecedor.encryptedPassword,
            'name': fornecedor.name,
            'cep': fornecedor.cep,
            'address': fornecedor.address,
            'service': fornecedor.service,
            'url': fornecedor.url,
            'location': fornecedor.location,
            'funcionamento': fornecedor.funcionamento,
            'is_active': fornecedor.isActive,
          },
        );

        if (response != null && response.error != null) {
          // Se houver um erro ao salvar informações do usuário, imprima a mensagem de erro
          print(
              'Erro ao salvar informações do usuário: ${response.error!.message}');
        } else {
          // Se tudo estiver correto, imprima a mensagem de sucesso e redirecione para a página de login
          print('Fornecedor cadastrado com sucesso!');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TelaLogin()),
          );
        }
      } catch (error) {
        // Em caso de erro geral, imprima a mensagem de erro
        print('Erro durante o cadastro: $error');
        // Exibir mensagem ou tomar medidas adequadas
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Entradapucminas.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
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
                        fontSize: 30.0,
                        color: AppColors.cobalt,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                    const ImageIcon(
                      AssetImage('assets/images/iconPrincipal.png'),
                      color: AppColors.cobalt,
                      size: 45.0,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
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
                        0.05), // Espaço entre a Row e a Column
                Text(
                  'Nome do Estabelecimento',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.cobalt,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015), //
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Digite o nome do estabelecimento  ',
                    filled: true, // Preenche o fundo com a cor especificada
                    fillColor: Color.fromRGBO(
                        255, 255, 255, 0.8), // Branco com 50% de transparência
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColors.cobalt,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColors.cobalt,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: AppColors.cobalt,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite o nome do estabelecimento';
                    }
                    return null;
                  },
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width *
                        0.05), // Espaço entre os campos de texto
                Text(
                  'CEP',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.cobalt,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015), //
                TextFormField(
                  controller: cepController,
                  decoration: InputDecoration(
                    labelText: 'Digite o CEP(Ex: 30535-000))',
                    filled: true, // Preenche o fundo com a cor especificada
                    fillColor: Color.fromRGBO(
                        255, 255, 255, 0.8), // Branco com 50% de transparência
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColors.cobalt,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColors.cobalt,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: AppColors.cobalt,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'CEP inválido';
                    }
                    // Tente converter o valor em um número inteiro
                    if (int.tryParse(value) == null) {
                      return 'Digite um número válido.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width *
                        0.05), // Espaço entre os campos de texto
                Text(
                  'Endereço',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.cobalt,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015), //
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Rua, número, bairro, cidade',
                    filled: true, // Preenche o fundo com a cor especificada
                    fillColor: Color.fromRGBO(
                        255, 255, 255, 0.8), // Branco com 50% de transparência
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColors.cobalt,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColors.cobalt,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: AppColors.cobalt,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite o endereço';
                    }
                    return null;
                  },
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width *
                        0.05), // Espaço entre a senha e o botão de login
                Text(
                  'Serviços ofertados',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.cobalt,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015), //
                TextFormField(
                  controller: serviceController,
                  decoration: InputDecoration(
                    labelText: 'Suco, salgados...',
                    filled: true, // Preenche o fundo com a cor especificada
                    fillColor: Color.fromRGBO(
                        255, 255, 255, 0.8), // Branco com 50% de transparência
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColors.cobalt,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColors.cobalt,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: AppColors.cobalt,
                    ),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width *
                        0.05), // Espaço entre a senha e o botão de login
                Text(
                  'URL da logo',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.cobalt,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015), //
                TextFormField(
                  controller: urlController,
                  decoration: InputDecoration(
                    labelText: 'URL da logo',
                    filled: true, // Preenche o fundo com a cor especificada
                    fillColor: Color.fromRGBO(
                        255, 255, 255, 0.8), // Branco com 50% de transparência
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColors.cobalt,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColors.cobalt,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: AppColors.cobalt,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                Text(
                  'Localização',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.cobalt,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015), //
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: selectedRadio,
                          onChanged: (int? value) {
                            setState(() {
                              selectedRadio = value!;
                            });
                            // Lógica para lidar com a seleção do radio
                          },
                          activeColor: AppColors
                              .cobalt, // Cor da bolinha quando selecionado
                        ),
                        Text(
                          'Dentro da PUC Coração Eucarìstico',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: AppColors.cobalt,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: selectedRadio,
                          onChanged: (int? value) {
                            setState(() {
                              selectedRadio = value!;
                            });
                            // Lógica para lidar com a seleção do radio
                          },
                          activeColor: AppColors
                              .cobalt, // Cor da bolinha quando selecionado
                        ),
                        Text(
                          'Fora da PUC Coração Eucarìstico',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: AppColors.cobalt,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                Text(
                  'Funcionamento',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.cobalt,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015), //
                TextFormField(
                  controller: funcionamentoController,
                  decoration: InputDecoration(
                    labelText: 'Dias e horários de funcionamento',
                    filled: true, // Preenche o fundo com a cor especificada
                    fillColor: Color.fromRGBO(
                        255, 255, 255, 0.8), // Branco com 50% de transparência
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColors.cobalt,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColors.cobalt,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: AppColors.cobalt,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(155, 50),
                          backgroundColor: AppColors.cobalt,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        await cadastrarFornecedor(context);
                      },
                      child: const Text(
                        'Salvar',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
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
