class clientmodel {
  int? client_id;
  String? client_nome;
  String? client_email;
  String? client_password;
  int? logged_in; // Adicione o campo 'logged_in'

  clientmodel({
    this.client_id,
    this.client_nome,
    this.client_email,
    this.client_password,
    this.logged_in, // Inclua o campo 'logged_in' no construtor
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': client_id,
      'nome': client_nome,
      'email': client_email,
      'senha': client_password,
      'logged_in': logged_in, // Mapeie o campo 'logged_in'
    };
    return map;
  }

  clientmodel.fromMap(Map<String, dynamic> map) {
    client_id = map['id'];
    client_nome = map['nome'];
    client_email = map['email'];
    client_password = map['senha'];
    logged_in = map['logged_in']; // Atualize para incluir 'logged_in'
  }
}
