import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import 'principal.dart';
import 'dart:convert';

class Produtos extends StatefulWidget {
  final int restauranteId;
  Produtos({required this.restauranteId});

  @override
  _ProdutosState createState() => _ProdutosState();
}

class Product {
  final String name;
  final double preco;
  final String description;
  final String category;
  final String image;

  Product(this.name, this.preco, this.description, this.category, this.image);
}

class _ProdutosState extends State<Produtos> {
  final _formKey = GlobalKey<FormState>();

  List<Product> products = [];

  Future<void> loadProductsFromJson() async {
    try {
      final productJsonString =
          await rootBundle.loadString('assets/data/produtos.json');
      final List<dynamic> productJsonList = json.decode(productJsonString);

      final List<Product> loadedProducts = productJsonList.map((json) {
        return Product(
          json['name'],
          json['price'],
          json['description'],
          json['category'],
          json['image'],
        );
      }).toList();

      setState(() {
        products = loadedProducts;
      });
    } catch (e) {
      // Trate erros de carregamento de JSON
      print('Erro ao carregar produtos: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadProductsFromJson();
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
                Row(
                  children: <Widget>[
                    Text(
                      'Produtos',
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
                  'Nome do Restaurante',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: AppColors.cobalt,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.5),
                Container(
                  height: 500, // Defina a altura desejada aqui
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text('\$${product.preco.toStringAsFixed(2)}'),
                        leading: Image.asset(product.image),
                        onTap: () {
                          // Adicione o produto ao restaurante aqui
                          // Você pode usar uma função ou método para fazer isso
                          // por exemplo: addToRestaurant(product);
                        },
                      );
                    },
                  ),
                ),

                SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.15), // Espaço entre o título e os botões
                // Botões de login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(125, 50),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 2, // thickness
                                  color: AppColors.cobalt // color
                                  ),
                              // border radius
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaInicial()),
                        );
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: AppColors.cobalt,
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(125, 50),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 2, // thickness
                                  color: AppColors.cobalt // color
                                  ),
                              // border radius
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaPrincipal(
                                    userEmail: 'nome',
                                    userPassword: '555',
                                    userType: 'cliente',
                                  )),
                        );
                      },
                      child: const Text(
                        'Ir para Página Principal',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: AppColors.cobalt,
                        ),
                      ),
                    ),
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
