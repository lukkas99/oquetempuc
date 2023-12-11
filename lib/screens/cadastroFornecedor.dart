import 'package:flutter/material.dart';
import '../main.dart';
import 'cadastroFornecedor2.dart';
import 'package:oquetempuc/comm/comHelper.dart';

class CadastroFornecedor extends StatefulWidget {
  @override
  _CadastroFornecedor createState() => _CadastroFornecedor();
}

class _CadastroFornecedor extends State<CadastroFornecedor> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void signUpFornecedor() {
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmedPassword = passwordConfirm.text;

    if (password == confirmedPassword && validateEmail(email)) {
      final String encryptedPassword =
          generateMd5(password); // encrypt password

      // Passwords match, proceed to the next step
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CadastroFornecedor2(
            email: email,
            encryptedPassword: encryptedPassword,
            restauranteId: -1,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Senhas são diferentes ou email inválido'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

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
                        color: AppColors.cobalt,
                        fontSize: 30.0,
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
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
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
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width *
                        0.05), // Espaço entre os campos de texto
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Senha',
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
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width *
                        0.05), // Espaço entre a senha e o botão de login
                TextFormField(
                  controller: passwordConfirm,
                  decoration: InputDecoration(
                    labelText: 'Confirme sua senha',
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
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width *
                        0.05), // Espaço entre a senha e o botão de login

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(155, 50),
                      backgroundColor: AppColors.cobalt,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: signUpFornecedor,
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
