import 'package:flutter/material.dart';
import 'package:app_movil_ces/src/models/novela_model.dart';
import 'package:app_movil_ces/src/pages/novela_page.dart';

class NovelaCard extends StatelessWidget {
  const NovelaCard({Key? key, required this.model, required this.id})
      : super(key: key);
  final Novela model;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.all(8.0),
        child: InkWell(
            onTap: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        NovelaPage(novela: model, id: id)),
              );
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Image.network(model.portada ?? "",
                            fit: BoxFit.cover)),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          model.titulo ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ))
                  ],
                ))));
  }
}
