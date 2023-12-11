import 'package:flutter/material.dart';
import '../main.dart';
import 'package:toast/toast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:oquetempuc/screens/login.dart';
import 'package:oquetempuc/comm/comHelper.dart';

class CadastroCliente extends StatefulWidget {
  @override
  _CadastroCliente createState() => _CadastroCliente();
}

class _CadastroCliente extends State<CadastroCliente> {
  final _formKey = GlobalKey<FormState>();

  final clientName = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirm = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> signUp() async {
    // Obtenha os valores do email e senha dos controladores
    final String email = emailController.text.trim();
    final String password = generateMd5(passwordController.text.trim());
    final String nomeDoUsuario = clientName.text.trim();

    try {
      // Salve informações na tabela de clientes
      final userInformationResponse = await supabase.from('clientes').upsert(
        {
          'user_email': email,
          'user_nome': nomeDoUsuario,
          'user_senha': password,
        },
      );

      if (userInformationResponse?.error != null) {
        // Se houver um erro ao salvar informações do usuário, imprima a mensagem de erro
        print(
            'Erro ao salvar informações do usuário: ${userInformationResponse!.error!.message}');
      } else {
        // Se tudo estiver correto, imprima a mensagem de sucesso e redirecione para a página de login
        print('Usuário cadastrado com sucesso!');
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

  Widget build(BuildContext context) {
    ToastContext().init(context);
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
                          0.1), // Espaço entre a Row e a Column
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true, // Preenche o fundo com a cor especificada
                      fillColor: Color.fromRGBO(255, 255, 255,
                          0.8), // Branco com 50% de transparência
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
                      filled: true, // Preenche o fundo com a cor especificada
                      fillColor: Color.fromRGBO(255, 255, 255,
                          0.8), // Branco com 50% de transparência
                      // Define a cor de preenchimento como branco
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
                      labelText: 'Confirme sua Senha!',
                      filled: true, // Preenche o fundo com a cor especificada
                      fillColor: Color.fromRGBO(255, 255, 255,
                          0.8), // Branco com 50% de transparência
                      // Define a cor de preenchimento como branco
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
                    controller: clientName,
                    decoration: InputDecoration(
                      labelText: 'Nome Completo',
                      filled: true, // Preenche o fundo com a cor especificada
                      fillColor: Color.fromRGBO(255, 255, 255,
                          0.8), // Branco com 50% de transparência
                      // Define a cor de preenchimento como branco
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(155, 50),
                        backgroundColor: AppColors.cobalt,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: signUp,
                    child: const Text(
                      'Cadastrar',
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
      ),
    );
  }
}
