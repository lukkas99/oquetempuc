import 'package:flutter/material.dart';
import 'package:oquetempuc/restaurante.dart';
import 'main.dart';

class TelaPrincipal extends StatefulWidget {
  final String email;
  const TelaPrincipal({super.key, required this.email});
  @override
  _TelaPrincipal createState() => _TelaPrincipal();
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
          Image.asset(
            restaurant.image,
            width: double.infinity, // Estica a imagem na largura da coluna
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
      onTap: (){
        Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  TelaRestaurante( restaurant,))
        );
      },
      ),
    );
  }
}

class _TelaPrincipal extends State<TelaPrincipal> {
  bool isSearchVisible = false;
  int selectedRadio = 0;
  final List<Restaurant> restaurants = [
    Restaurant(
      name: "Restaurante 1",
      image: "assets/images/logoRes1.png",
      rating: 4.5,
      description: "Comida deliciosa",
      location: "Endereço 1",
    ),
    Restaurant(
      name: "Restaurante 2",
      image: "assets/images/logoRes2.png",
      rating: 4.0,
      description: "Ótimos pratos",
      location: "Endereço 2",
    ),
    // Adicione mais restaurantes conforme necessário
  ];
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
          alignment: Alignment.topCenter, // Alinhe o ClipRRect ao topo
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
                              // Lógica para lidar com a seleção do checkbox
                            },
                            activeColor: AppColors
                                .cobalt, // Cor da bolinha quando selecionado
                          ),
                          Text('Dentro do campus'),
                          Radio(
                            value: 2,
                            groupValue:
                                selectedRadio, // Valor atualmente selecionado
                            onChanged: (int? value) {
                              setState(() {
                                selectedRadio = value!;
                              });
                              // Lógica para lidar com a seleção do checkbox
                            },
                            activeColor: AppColors
                                .cobalt, // Cor da bolinha quando selecionado
                          ),
                          Text('Perto do campus'),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Divider(
                        color: Colors.white, // Cor do divisor
                        thickness: 1.0, // Espessura do divisor
                        height: 20, // Altura do espaço do divisor
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
                    padding:
                        EdgeInsets.only(left: 16.0), // Espaçamento à esquerda
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
                  // Outros widgets abaixo do Text
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
                    color: Colors.white, // Cor do divisor
                    thickness: 1.0, // Espessura do divisor
                    height: 20, // Altura do espaço do divisor
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16.0), // Espaçamento à esquerda
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
              // Adicione a lista de estabelecimentos aqui
              ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true, // Para evitar rolagem infinita
                itemCount: restaurants
                    .length, // Substitua pela sua lista de estabelecimentos
                itemBuilder: (BuildContext context, int index) {
                  final establishment = restaurants[index];
                  return RestaurantCard(restaurant: establishment);
                },
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
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
