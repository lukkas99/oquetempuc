class Fornecedor {
  int? id;
  late String email;
  late String encryptedPassword;
  late String name;
  late String cep;
  late String address;
  late String service;
  late String url;
  late int location;
  late String funcionamento;
  late bool isActive;

  Fornecedor({
    this.id,
    required this.email,
    required this.encryptedPassword,
    required this.name,
    required this.cep,
    required this.address,
    required this.service,
    required this.url,
    required this.location,
    required this.funcionamento,
    this.isActive = true,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'email': email,
      'encrypted_password': encryptedPassword,
      'name': name,
      'cep': cep,
      'address': address,
      'service': service,
      'url': url,
      'location': location,
      'funcionamento': funcionamento,
      'is_active': isActive ? 1 : 0,
    };
    return map;
  }

  Fornecedor.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    email = map['email'];
    encryptedPassword = map['encrypted_password'];
    name = map['name'];
    cep = map['cep'];
    address = map['address'];
    service = map['service'];
    url = map['url'];
    location = map['location'];
    funcionamento = map['funcionamento'];
    isActive = map['is_active'] == 1;
  }
}
