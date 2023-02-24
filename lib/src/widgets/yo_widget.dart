import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:app_movil_ces/src/providers/main_provider.dart';
import 'package:app_movil_ces/src/widgets/setting_widget.dart';
import 'package:provider/provider.dart';

class YoWidget extends StatelessWidget {
  const YoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    Map<String, dynamic> content = JwtDecoder.decode(mainProvider.token);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
                elevation: 2.0,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 20.0),
                  leading: const Icon(
                    Icons.account_circle,
                    size: 60,
                  ),
                  title: Text(content["name"] ?? ""),
                  subtitle: Text(content["email"]),
                  trailing: IconButton(
                      tooltip: "Cerrar Sesión",
                      onPressed: () {
                        mainProvider.token = "";
                        Phoenix.rebirth(context);
                      },
                      icon: const Icon(Icons.logout)),
                )),
            Expanded(
                child: ListView(
              children: const <Widget>[
                Card(elevation: 2.0, child: SettingWidget()),
                Card(
                    elevation: 2.0,
                    child: ListTile(
                      leading: Icon(Icons.help_outline),
                      title: Text("Comentarios y sugerencias"),
                    )),
                Card(
                    elevation: 2.0,
                    child: ListTile(
                      leading: Icon(Icons.error_outline),
                      title: Text("Sobre nosotros"),
                    ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
