import 'package:flutter/material.dart';
import 'package:app_movil_ces/src/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_movil_ces/src/providers/main_provider.dart';
import 'package:provider/provider.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);

    return Column(
      children: <Widget>[
        ExpansionTile(
          leading: const Icon(Icons.settings),
          title: const Text("Configuración"),
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.brightness_4_outlined),
              title: const Text('Modo Oscuro'),
              trailing: Switch(
                activeColor: Palette.color,
                value: !mainProvider.mode,
                onChanged: (bool value) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool("mode", !value);
                  mainProvider.mode = !value;
                },
              ),
              /*trailing: Switch(value: mainProvider.mode, onChanged: onChanged)*/
            )
          ],
        ),
      ],
    );
  }
}
