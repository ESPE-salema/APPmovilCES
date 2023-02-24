import 'package:flutter/material.dart';
import 'package:app_movil_ces/src/models/capitulo_model.dart';
import 'package:app_movil_ces/src/widgets/read_widget.dart';

class CapituloCard extends StatelessWidget {
  const CapituloCard({Key? key, required this.model}) : super(key: key);
  final Capitulo model;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: InkWell(
            onTap: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        ReadWidget(model: model)),
              );
            },
            child: ListTile(
              leading: const Icon(Icons.bookmark_border),
              trailing:
                  Text(model.idCapitulo ?? "", textAlign: TextAlign.center),
              title: Text(model.tituloCapitulo ?? ""),
            )));
  }
}
