import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_movil_ces/src/models/capitulo_model.dart';
import 'package:app_movil_ces/src/services/speech_service.dart';
import 'package:app_movil_ces/src/utils/validation.dart';

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
          title: const Text("Agregar novela"),
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
                        decoration: const InputDecoration(labelText: "Titulo"),
                        maxLength: 50,
                        maxLines: 1),
                    const Text(
                      "Ingresar el contenido",
                      textAlign: TextAlign.start,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.text,
                        controller: TextEditingController(text: text),
                        onSaved: (value) {
                          //Este evento se ejecuta cuando el Form ha sido guardado localmente
                          _capitulo.contenido =
                              value; //Asigna el valor del TextFormField al atributo del modelo
                        },
                        validator: (value) {
                          return validateString(value!);
                        },
                        maxLength: 1000,
                        maxLines: 20),
                  ]),
                )),
          ),
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: isListening,
        endRadius: 75,
        glowColor: Theme.of(context).primaryColor,
        child: FloatingActionButton(
          child: Icon(isListening ? Icons.mic : Icons.mic_none, size: 36),
          onPressed: toggleRecording,
        ),
      ),
    );
  }

  Future toggleRecording() => SpeechService.toggleRecording(
        onResult: (text) => setState(() => this.text = text),
        onListening: (isListening) {
          setState(() => this.isListening = isListening);
        },
      );

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
}
