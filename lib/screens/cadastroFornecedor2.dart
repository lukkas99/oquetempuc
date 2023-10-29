import 'package:flutter/material.dart';
import 'produtos.dart';
import '../main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:oquetempuc/db/fornecedorDbHelper.dart';
import 'package:oquetempuc/model/fornecedor.dart';

class CadastroFornecedor2 extends StatefulWidget {
  final String email;
  final String encryptedPassword;

  CadastroFornecedor2({
    required this.email,
    required this.encryptedPassword,
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
  final dbHelper = FornecedorDbHelper();

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
                        fontSize: 30.0,
                        color: AppColors.cobalt,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                    const ImageIcon(
                      AssetImage('assets/images/iconPrincipal.png'),
                      color: Colors.black,
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
                    labelText: 'Digite o nome do estabelecimento',
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
                      color: AppColors
                          .cobalt, // Defina a cor desejada para o texto do rótulo
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
                    labelText: 'Digite o CEP. Somente números!',
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
                      color: AppColors
                          .cobalt, // Defina a cor desejada para o texto do rótulo
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
                    labelText: 'Rua, Número, Bairro',
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
                      color: AppColors
                          .cobalt, // Defina a cor desejada para o texto do rótulo
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
                    labelText: 'Suco natural, salgados...',
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
                      color: AppColors
                          .cobalt, // Defina a cor desejada para o texto do rótulo
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
                      color: AppColors
                          .cobalt, // Defina a cor desejada para o texto do rótulo
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
                        Text('Dentro da PUC Coração Eucarìstico'),
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
                        Text('Fora da PUC Coração Eucarìstico'),
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
                    labelText: 'Dias e horário de funcionamento',
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
                      color: AppColors
                          .cobalt, // Defina a cor desejada para o texto do rótulo
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(155, 50),
                      backgroundColor: AppColors.cobalt,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
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

                      dbHelper.saveFornecedorData(fornecedor);
                    }

                    // Próxima tela
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Produtos(),
                      ),
                    );
                  },
                  child: const Text(
                    'Próximo',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
