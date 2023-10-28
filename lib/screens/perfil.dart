import 'package:oquetempuc/db/Dbhelper.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:oquetempuc/model/clientmodel.dart';

class TelaPerfil extends StatefulWidget {
  final String userEmail;
  final String userPassword;
  TelaPerfil({required this.userEmail, required this.userPassword});

  @override
  _TelaPerfil createState() =>
      _TelaPerfil(userEmail: userEmail, userPassword: userPassword);
}

class _TelaPerfil extends State<TelaPerfil> {
  final String userEmail;
  final String userPassword;

  _TelaPerfil({required this.userEmail, required this.userPassword});
  clientmodel? _user;

  @override
  void initState() {
    super.initState();
    // Recupere os dados do usuário do banco de dados local
    getUserData();
  }

  void getUserData() async {
    final dbHelper = Dbhelper();
    final userId =
        userEmail; // Substitua por uma maneira de obter o ID do usuário logado
    final password = userPassword; // Substitua pela senha do usuário logado
    print('userId: $userId, password: $password)');

    final user = await dbHelper.getLoginUser(userId, password);

    if (user != null) {
      setState(() {
        _user = user;
      });
      print('Usuário logado: ${user.client_nome}, ${user.client_email}');
    } else {
      print('Login falhou. Usuário não encontrado.');
    }
  }

  // Função para fazer logout
  void logout() {
    final dbHelper = Dbhelper(); // Crie uma instância do seu DBHelper
    dbHelper
        .clearUserData(); // Chame a função para limpar os dados de autenticação

    // Navegue para a tela de login ou outra tela inicial
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => TelaInicial(), // Substitua por sua tela de login
    ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.snow,
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                // Envolve a Row com um Container
                color: Colors
                    .white, // Define a cor de fundo da Row como transparente
                padding: EdgeInsets.only(
                    top: 40, left: 15.0, right: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    ImageIcon(
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
                    Spacer(), // Espaço flexível para empurrar os ícones para a direita
                    IconButton(
                      icon: Icon(Icons.home_outlined),
                      onPressed: () {
                        // Adicione a lógica para a ação de ir para a tela inicial aqui
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.person_outline),
                      onPressed: () {
                        // Adicione a lógica para a ação de ir para o perfil aqui
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              if (_user != null)
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: EdgeInsets.all(16.0),
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('Nome: ${_user!.client_nome}'),
                          SizedBox(height: 8.0),
                          Text('Email: ${_user!.client_email}'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: logout,
                      child: Text('Logout'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
