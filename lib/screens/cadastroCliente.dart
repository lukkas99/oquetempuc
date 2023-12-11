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
                TextFormField(
                  controller: clientName,
                  decoration: InputDecoration(
                    labelText: 'Nome de usuário',
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
    );
  }
}
