import 'package:flutter/material.dart';
import 'package:app_movil_ces/src/models/novela_model.dart';
import 'package:expand_widget/expand_widget.dart';

class NovelaDetailsContentWidget extends StatelessWidget {
  const NovelaDetailsContentWidget({Key? key, required this.novela})
      : super(key: key);
  final Novela novela;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 8),
                ExpandText(
                  novela.descripcion ?? "",
                  maxLines: 3,
                  //: const EdgeInsets.all(0),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
