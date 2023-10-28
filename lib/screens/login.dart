import 'package:flutter/material.dart';
import 'principal.dart';
import '../main.dart';
import 'package:oquetempuc/comm/comHelper.dart';
import 'package:oquetempuc/model/clientmodel.dart';
import 'package:oquetempuc/db/Dbhelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLogin createState() => _TelaLogin();
}

class _TelaLogin extends State<TelaLogin> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();

  final _conClientEmail = TextEditingController();
  final _conClientPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = Dbhelper();
  }

  login() async {
    String cmail = _conClientEmail.text;
    String passwd = generateMd5(_conClientPassword.text);

    if (cmail.isEmpty) {
      alertDialog("Please Enter User ID");
    } else if (passwd.isEmpty) {
      alertDialog("Please Enter Password");
    } else {
      await dbHelper.getLoginUser(cmail, passwd).then((userData) {
        print(userData);
        if (userData != null) {
          // Login bem-sucedido, você pode armazenar os dados do usuário atual
          String userEmail = userData.client_email;
          String userPassword = userData.client_password.toString();

          // Atualize o campo logged_in para 1 (indicando que o cliente está logado)
          dbHelper.setLoggedInStatus(userData.client_email, 1).then((_) {
            // Continue com o login
            setSP(userData).whenComplete(() {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => TelaPrincipal(
                    userEmail: userEmail,
                    userPassword: userPassword,
                  ),
                ),
                (Route<dynamic> route) => false,
              );
            });
          });
        } else {
          alertDialog("Error: User Not Found");
        }
      }).catchError((error) {
        print(error);
        alertDialog("Error: Login Fail");
      });
    }
  }

  Future setSP(clientmodel user) async {
    final SharedPreferences sp = await _pref;

    if (user.client_id != null) {
      sp.setInt("user_id", user.client_id!);
    }

    if (user.client_nome != null) {
      sp.setString("user_name", user.client_nome!);
    }

    if (user.client_email != null) {
      sp.setString("email", user.client_email!);
    }

    if (user.client_password != null) {
      sp.setString("password", user.client_password!);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/pucentrada.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
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
                        Stack(
                          children: <Widget>[
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 42,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1.5
                                  ..color = AppColors.cobalt,
                              ),
                            ),
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 42,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        ImageIcon(
                          AssetImage('assets/images/iconPrincipal.png'),
                          color: Colors.white,
                          size: 45.0,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        Stack(
                          children: <Widget>[
                            Text(
                              'O que tem? \n PUC Coreu',
                              style: TextStyle(
                                fontSize: 18,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1.5
                                  ..color = AppColors.cobalt,
                              ),
                            ),
                            const Text(
                              'O que tem? \n PUC Coreu',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                    TextFormField(
                      controller: _conClientEmail,
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
                    SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                    TextFormField(
                      controller: _conClientPassword,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(155, 50),
                        backgroundColor: AppColors.cobalt,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 2, // thickness
                              color: Colors.white // color
                              ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: login,
                      child: const Text(
                        'ENTRAR',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(
                size: 48.0,
                color: AppColors.cobalt,
              ),
              title: null,
            ),
          ),
        ],
      ),
    );
  }
}