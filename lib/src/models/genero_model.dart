import 'dart:convert';

Genero generoFromJson(String str) => Genero.fromJson(json.decode(str));

String generoToJson(Genero data) => json.encode(data.toJson());

class Genero {
  Genero({
    this.idGenero,
    this.nombre,
    this.icon,
  });

  int? idGenero;
  String? nombre;
  String? icon;

  factory Genero.fromJson(Map<String, dynamic> json) => Genero(
        idGenero: json["id_genero"],
        nombre: json["nombre"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id_genero": idGenero,
        "nombre": nombre,
        "icon": icon,
      };
}
