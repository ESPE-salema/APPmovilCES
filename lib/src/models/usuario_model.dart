import 'dart:convert';

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.id,
    this.displayName,
    this.email,
    this.password,
  });

  int? id;
  String? displayName;
  String? email;
  String? password;

  Map<String, dynamic> toJson() => {
        "id": id,
        "displayName": displayName,
        "email": email,
        "password": password,
      };
}
