import 'package:devicelocale/devicelocale.dart';
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

  @override
  void initState() {
    super.initState();
    _translation();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);

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
                          dimension: 50.0, child: CircularProgressIndicator()))
                  : Text(
                      _contentCapitulo,
                      textAlign: TextAlign.justify,
                    ),
            ))
      ],
    )));
  }

  _translation() async {
    try {
      String? locale = await Devicelocale.currentLocale;
      locale = locale!.substring(0, 2);
      developer.log(locale);

      var translation = await GoogleTranslator()
          .translate(widget.model.contenido ?? "", to: locale);
      setState(() {
        _contentCapitulo = translation.text;
      });
    } catch (e) {
      developer.log(e.toString());
    }
  }
}
