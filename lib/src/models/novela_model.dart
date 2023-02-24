import 'dart:convert';

Novela novelaFromJson(String str) => Novela.fromJson(json.decode(str));

String novelaToJson(Novela data) => json.encode(data.toJson());

class Novela {
  Novela({
    //this.idNovela,
    this.autor,
    this.titulo,
    this.portada,
    this.descripcion,
    this.favorito,
    this.fechaCreacion,
    /*
    this.generos,
    this.capitulos,*/
  });

  //String? idNovela;
  String? autor;
  String? titulo;
  String? portada;
  String? descripcion;
  bool? favorito;
  String? fechaCreacion;
  /*List<Genero>? generos;
  List<Capitulo>? capitulos;*/

  factory Novela.fromJson(Map<String, dynamic> json) => Novela(
      //idNovela: json["idNovela"],
      autor: json["autor"],
      titulo: json["titulo"],
      portada: json["portada"],
      descripcion: json["descripcion"],
      favorito: json["favorito"],
      fechaCreacion: json["fechaCreacion"]
      /*generos:
            List<Genero>.from(json["generos"].map((x) => Genero.fromJson(x))),
        capitulos: List<Capitulo>.from(
            json["capitulos"].map((x) => Capitulo.fromJson(x))),*/
      );

  Map<String, dynamic> toJson() => {
        //"idNovela": idNovela,
        "autor": autor,
        "titulo": titulo,
        "portada": portada,
        "descripcion": descripcion,
        "favorito": favorito,
        "fechaCreacion": fechaCreacion,
        /*"generos": List<dynamic>.from(generos!.map((x) => x.toJson())),
        "capitulos": List<dynamic>.from(capitulos!.map((x) => x.toJson())),*/
      };
}
