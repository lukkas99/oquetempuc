import 'package:oquetempuc/db/Dbhelper.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:oquetempuc/model/clientmodel.dart';

class TelaPerfil extends StatefulWidget {
  final String userEmail;
  final String userPassword;
  final String userName;

  TelaPerfil(
      {required this.userEmail,
      required this.userPassword,
      required this.userName});

  @override
  _TelaPerfilState createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  clientmodel? _user;

  @override
  void initState() {
    super.initState();
  }

  // Função para fazer logout
  Future<void> logout() async {
    await supabase.auth.signOut();

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => TelaInicial(), // Substitua por sua tela de login
    ));
  }

  Widget build(BuildContext context) {
    print('userNome: ${widget.userName}');

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
                        Navigator.of(context)
                            .pop(); // Adicione a lógica para a ação de ir para a tela inicial aqui
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
                        Text('Nome: ${_user?.client_nome ?? widget.userName}'),
                        Text('Email: ${widget.userEmail}'),
                        SizedBox(height: 8.0),
                        // Outros campos, se houver
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white, // Cor do divisor
                    thickness: 1.0, // Espessura do divisor
                    height: 20, // Altura do espaço do divisor
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
