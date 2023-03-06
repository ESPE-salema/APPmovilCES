import 'package:app_movil_ces/src/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:app_movil_ces/src/models/capitulo_model.dart';
import 'package:app_movil_ces/src/providers/main_provider.dart';
import 'package:app_movil_ces/src/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'dart:developer' as developer;

class ReadWidget extends StatefulWidget {
  const ReadWidget({Key? key, required this.model}) : super(key: key);
  final Capitulo model;

  @override
  State<ReadWidget> createState() => _ReadWidgetState();
}

class _ReadWidgetState extends State<ReadWidget> {
  late String _contentCapitulo = "";
  late MainProvider mainProvider;

  @override
  void initState() {
    mainProvider = Provider.of<MainProvider>(context, listen: false);
    _translation(mainProvider.language);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mainProvider = Provider.of<MainProvider>(context, listen: true);

    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: mainProvider.mode
                ? const IconThemeData(color: Colors.black)
                : const IconThemeData(color: Palette.color),
            floating: true,
            pinned: true,
            elevation: 2,
            title: Text(widget.model.tituloCapitulo ?? ""),
          ),
          SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: _contentCapitulo.isEmpty
                    ? const Center(
                        child: SizedBox.square(
                            dimension: 50.0,
                            child: CircularProgressIndicator()))
                    : Text(
                        _contentCapitulo,
                        textAlign: TextAlign.justify,
                      ),
              )),
        ],
      ),
      endDrawer: Drawer(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: ListView(
              children: <Widget>[
                Card(
                    elevation: 2.0,
                    child: ListTile(
                        leading: const Icon(Icons.language),
                        title: const Text("Idioma:"),
                        trailing: DropdownButton(
                          value: mainProvider.language,
                          items: menuLanguageOptions
                              .map((e) => DropdownMenuItem(
                                    value: e.locale,
                                    child: Text(e.language),
                                  ))
                              .toList(),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              mainProvider.language = value!;
                              _translation(mainProvider.language);
                            });
                          },
                        ))),
              ],
            ))
          ],
        ),
      )),
    ));
  }

  _translation(locale) async {
    try {
      var translation = await GoogleTranslator()
          .translate(widget.model.contenido ?? "", to: locale);

      setState(() {
        _contentCapitulo = translation.text;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _contentCapitulo = widget.model.contenido ?? "";

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("No se pudo reconocer el idioma.",
                    textAlign: TextAlign.center)),
          );
        });
      }
      developer.log(e.toString());
    }
  }
}
