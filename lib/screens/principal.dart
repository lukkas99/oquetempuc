import 'package:flutter/material.dart';
import 'package:oquetempuc/db/Dbhelper.dart';
import 'package:oquetempuc/model/fornecedor.dart';
import 'package:oquetempuc/screens/restaurante.dart';
import '../main.dart';
import 'perfil.dart';
import 'perfilRestaurante.dart';

class TelaPrincipal extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userPassword;
  final String userType;
  final int? restauranteId;

  TelaPrincipal(
      {required this.userName,
      required this.userEmail,
      required this.userPassword,
      required this.userType,
      this.restauranteId});

  @override
  _TelaPrincipal createState() => _TelaPrincipal(
        userName: userName,
        userEmail: userEmail,
        userPassword: userPassword,
        userType: userType,
        restauranteId: restauranteId,
      );
}

class Restaurant {
  final String name;
  final String image;
  final double rating;
  final String description;
  final String location;

  Restaurant({
    required this.name,
    required this.image,
    required this.rating,
    required this.description,
    required this.location,
  });
}

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantCard({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              restaurant
                  .image, // Use Image.network para carregar imagens da web
              width: double.infinity,
              height: 150.0,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                restaurant.name,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  Text(restaurant.rating.toStringAsFixed(1)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                restaurant.description,
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.cobalt,
                  ),
                  Text(restaurant.location),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TelaRestaurante(
                        restaurant,
                      )));
        },
      ),
    );
  }
}

class _TelaPrincipal extends State<TelaPrincipal> {
  final String userName;
  final String userEmail;
  final String userPassword;
  final String userType;
  final int? restauranteId;
  int selectedRadio = 0;
  List<Restaurant> restaurants = [];

  _TelaPrincipal({
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    required this.userType,
    this.restauranteId,
  });

  @override
  void initState() {
    super.initState();
    loadFornecedores();
  }

  void loadFornecedores() async {
    final dbHelper = DbHelper();
    final fornecedores = await dbHelper.readAllFornecedoresData();

    fornecedores
        .sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0)); // Adicione ?? 0

    final restaurantes = fornecedores
        .map((fornecedor) => Restaurant(
              name: fornecedor.name,
              image: fornecedor.url,
              rating: 4.5,
              description: fornecedor.service,
              location:
                  fornecedor.location == 1 ? 'Dentro da PUC' : 'Fora da PUC',
            ))
        .toList();

    setState(() {
      restaurants.clear();
      restaurants.addAll(restaurantes);
    });
  }

  bool isSearchVisible = false;

  void toggleSearchVisibility() {
    setState(() {
      isSearchVisible = !isSearchVisible;
    });
  }

  Widget _buildProductItem(
    String productImage,
    String storeImage,
    String text1,
    String text2,
    String text3,
  ) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: 140.0,
              height: 140.0,
              child: Image.asset(
                productImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Container(
              width: 50.0,
              height: 50.0,
              child: Image.asset(storeImage),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(text1, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(text2),
                Text(
                  text3,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (userName == null) {
      // userName é null, faça algo aqui, como exibir uma mensagem de erro
      return Scaffold(
        body: Center(
          child: Text('Erro: userName é null'),
        ),
      );
    }
    print("User Type: $userType");
    print("User name: ${widget.userName}");
    print("User Email: ${widget.userEmail}");
    print("User Password: $userPassword");

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
                        if (userType == "cliente") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TelaPerfil(
                                userEmail: userEmail,
                                userPassword: userPassword,
                                userName: userName,
                              ),
                            ),
                          );
                        } else if (userType == "fornecedor") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PerfilRestaurante(
                                restauranteId: restauranteId!,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isSearchVisible,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Pesquisar...',
                          filled: true,
                          fillColor: Colors.white,
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
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.width * 0.05),
                      Text(
                        'LOCALIZAÇÃO',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: selectedRadio,
                            onChanged: (int? value) {
                              setState(() {
                                selectedRadio = value!;
                              });
                            },
                            activeColor: AppColors.cobalt,
                          ),
                          Text('Dentro do campus'),
                          Radio(
                            value: 2,
                            groupValue: selectedRadio,
                            onChanged: (int? value) {
                              setState(() {
                                selectedRadio = value!;
                              });
                            },
                            activeColor: AppColors.cobalt,
                          ),
                          Text('Perto do campus'),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Divider(
                        color: Colors.white,
                        thickness: 1.0,
                        height: 20,
                      ),
                      // Aqui você pode adicionar os resultados
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'NOVAS OFERTAS',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              // Item 1
                              SizedBox(width: 8.0),
                              _buildProductItem(
                                'assets/images/acai.png',
                                'assets/images/logoRes1.png',
                                'Açai Completo',
                                'R\$0,00',
                                'Nome da loja',
                              ),
                              SizedBox(width: 8.0),
                              // Item 2
                              _buildProductItem(
                                'assets/images/cachorroquente.jpg',
                                'assets/images/logoRes2.png',
                                'Cachorro Quente',
                                'R\$0,00',
                                'Nome da loja',
                              ),
                              SizedBox(width: 8.0),
                              _buildProductItem(
                                'assets/images/queijoquente.jpg',
                                'assets/images/logoRes2.png',
                                'Queijo Quente',
                                'R\$0,00',
                                'Nome da loja',
                              ),
                              SizedBox(width: 8.0),
                              // Adicione mais itens conforme necessário
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                  Divider(
                    color: Colors.white,
                    thickness: 1.0,
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ESTABELECIMENTOS',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Espaço entre appBar personalizada e o conteúdo abaixo
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),

              // LOCAL ONDE VAI MOSTRAR OS RESTAURANTES
              // Exibe a lista de restaurantes
              Column(
                children: restaurants
                    .map((restaurant) => RestaurantCard(restaurant: restaurant))
                    .toList(),
              ),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TelaInicial()),
                    );
                  },
                  child: const Text("Go back!"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
