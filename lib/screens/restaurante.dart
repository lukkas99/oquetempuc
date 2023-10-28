import 'package:flutter/material.dart';
import 'package:oquetempuc/main.dart';
import 'package:oquetempuc/screens/principal.dart';

class TelaRestaurante extends StatefulWidget {
  final Restaurant rest;
  const TelaRestaurante(this.rest);

  _TelaRestaurante createState() => _TelaRestaurante(rest);
}

class _TelaRestaurante extends State<TelaRestaurante> {
  bool isSearchVisible = false;
  String name = 'Restaurante';
  String image = 'assets/images/not_found.png';
  double rating = 3.0;
  String description = 'Descrição erro';
  String location = 'Lugar Nenhum';
  _TelaRestaurante(res) {
    name = res.name;
    image = res.image;
    rating = res.rating;
    description = res.description;
    location = res.location;
  }

  void toggleSearchVisibility() {
    setState(() {
      isSearchVisible = !isSearchVisible;
    });
  }

  @override
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
                color: Colors.white,
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
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        toggleSearchVisibility();
                      },
                    ),
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
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(image, fit: BoxFit.contain),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 50),
                    Text(
                      rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.location_pin, color: Colors.black, size: 45),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
