import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_movil_ces/src/models/capitulo_model.dart';
import 'package:app_movil_ces/src/utils/validation.dart';
import 'package:flutter/services.dart';
import 'package:read_pdf_text/read_pdf_text.dart';

class CapituloFirebaseFormWidget extends StatefulWidget {
  const CapituloFirebaseFormWidget(
      {Key? key, required this.id, required this.size})
      : super(key: key);
  final String id;
  final int size;

  @override
  State<CapituloFirebaseFormWidget> createState() =>
      _CapituloFirebaseFormWidgetState();
}

class _CapituloFirebaseFormWidgetState
    extends State<CapituloFirebaseFormWidget> {
  late CollectionReference _capitulosRef;
  final Capitulo _capitulo = Capitulo();
  final _formKey = GlobalKey<FormState>();
  String text = '';
  bool isListening = false;
  final _pdfText = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    _capitulosRef = FirebaseFirestore.instance
        .collection('novelas')
        .doc(widget.id)
        .collection('capitulos');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text("Agregar capitulo"),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    _sendForm();
                  },
                  icon: const Icon(Icons.check_circle_outline))
            ]),
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              width: size.width,
              child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: Column(children: [
                      TextFormField(
                          keyboardType: TextInputType.text,
                          initialValue: _capitulo.tituloCapitulo,
                          onSaved: (value) {
                            //Este evento se ejecuta cuando el Form ha sido guardado localmente
                            _capitulo.tituloCapitulo =
                                value; //Asigna el valor del TextFormField al atributo del modelo
                          },
                          validator: (value) {
                            return validateString(value!);
                          },
                          decoration:
                              const InputDecoration(labelText: "Titulo"),
                          maxLength: 50,
                          maxLines: 1),
                      const Text(
                        "Escriba el contenido",
                        textAlign: TextAlign.start,
                      ),
                      TextFormField(
                          controller: _pdfText,
                          keyboardType: TextInputType.text,
                          //initialValue: _capitulo.contenido,
                          onSaved: (value) {
                            //Este evento se ejecuta cuando el Form ha sido guardado localmente
                            _capitulo.contenido =
                                value; //Asigna el valor del TextFormField al atributo del modelo
                          },
                          //validator: (value) {return validateString(value!);},
                          //maxLength: 1000,
                          maxLines: 20),
                    ]),
                  )),
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          elevation: 4,
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf'],
            );

            if (result != null) {
              PlatformFile file = result.files.first;

              getPDFtext(file.path.toString()).then((pdfText) {
                final text = pdfText.replaceAll("\n", " ");
                setState(() {
                  _pdfText.text = text;
                });
              });
            } else {
              // User canceled the picker
            }
          },
          child: const Icon(Icons.picture_as_pdf),
        ));
  }

  _sendForm() async {
    if (!_formKey.currentState!.validate()) return;

    _capitulo.idCapitulo = (widget.size + 1).toString();

    setState(() {});

    _formKey.currentState!.save(); //Guarda el form localmente

    //Invoca al servicio POST para enviar la Portada
    _capitulosRef.add(_capitulo.toJson()).whenComplete(() => {
          _formKey.currentState!.reset(),
          Navigator.pop(context),
        });
  }

  Future<String> getPDFtext(String path) async {
    String text = "";
    try {
      text = await ReadPdfText.getPDFtext(path);
    } on PlatformException {
      if (kDebugMode) {
        print('Error al obtener texto PDF.');
      }
    }
    return text;
  }
}
