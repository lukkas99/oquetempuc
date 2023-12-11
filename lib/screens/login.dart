import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';
import 'package:oquetempuc/screens/principal.dart';
import 'package:oquetempuc/comm/comHelper.dart';
import 'package:oquetempuc/model/clientmodel.dart';
import 'package:oquetempuc/model/fornecedor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLogin createState() => _TelaLogin();
}

class _TelaLogin extends State<TelaLogin> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();

  final _conClientName = TextEditingController();
  final _conClientEmail = TextEditingController();
  final _conClientPassword = TextEditingController();
  var dbHelper;
  String userType = "";
  @override
  void initState() {
    super.initState();
  }

  Future<void> customLogin() async {
    String cmail = _conClientEmail.text.trim();
    String passwd = generateMd5(_conClientPassword.text.trim());

    try {
      // Verifique se é um cliente
      final responseClient = await supabase
          .from('clientes')
          .select('user_id, user_nome')
          .eq('user_email', cmail)
          .maybeSingle();
      print('Response: $responseClient');

      // Acesse os dados diretamente do mapa
      if (responseClient != null) {
        final Map<String, dynamic> clienteData = responseClient;
        final String? nome = clienteData['user_nome'] as String?;
        final int? userId = clienteData['user_id'] as int?;
        print('Response: $responseClient');

        _navigateToPrincipal(
          userType: 'cliente',
          userId: userId,
          userName: nome,
          userEmail: cmail,
        );
      } else {
        // Se não for um cliente, verifique se é um fornecedor
        final responseFornecedor = await supabase
            .from('fornecedor')
            .select('id, name')
            .eq('email', cmail)
            .eq('encrypted_password', passwd)
            .maybeSingle();

        // Acesse os dados diretamente do mapa
        if (responseFornecedor != null) {
          final Map<String, dynamic> fornecedorData = responseFornecedor;
          final int? fornecedorId = fornecedorData['id'] as int?;
          final String? nome = fornecedorData['name'] as String?;
          print('Response: $responseClient');

          _navigateToPrincipal(
            userType: 'fornecedor',
            restauranteId: fornecedorId,
            userName: nome,
            userEmail: cmail,
          );
        } else {
          // Usuário não é cliente nem fornecedor
          _showError('Error: Usuário não encontrado');
        }
      }
    } catch (error) {
      print('Erro durante o login: $error');
      _showError('Erro durante o login. Tente novamente.');
    }
  }

  void _navigateToPrincipal({
    required String userType,
    int? userId,
    int? restauranteId,
    String? userName,
    required String userEmail,
  }) {
    print('userId: $userId, userName: $userName)');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => TelaPrincipal(
          userName: userName ??
              '', // Use o valor de userName se não for nulo, caso contrário, use uma string vazia
          userEmail: userEmail,
          userPassword: generateMd5(_conClientPassword.text.trim()),
          userType: userType,
          restauranteId: restauranteId,
        ),
      ),
      (Route<dynamic> route) => false,
    );
  }

  void _showError(String errorMessage) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
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
                      obscureText: true,
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
                      onPressed: customLogin,
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
