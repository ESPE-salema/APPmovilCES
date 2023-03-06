import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_movil_ces/src/models/novela_model.dart';
import 'package:app_movil_ces/src/services/novela_service.dart';
import 'package:app_movil_ces/src/utils/validation.dart';

class NovelaFirebaseFormWidget extends StatefulWidget {
  const NovelaFirebaseFormWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NovelaFirebaseFormWidgetState createState() =>
      _NovelaFirebaseFormWidgetState();
}

class _NovelaFirebaseFormWidgetState extends State<NovelaFirebaseFormWidget> {
  final CollectionReference _novelasRef =
      FirebaseFirestore.instance.collection('novelas');

  late Novela _novela;
  File? _imagen;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  bool _onSaving = false;
  final NovelaService _novelaService = NovelaService();

  @override
  void initState() {
    super.initState();
    setState(() {
      _novela = Novela();
      _novela.fechaCreacion =
          DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Agregar novela")),
      body: SingleChildScrollView(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Column(
              children: [
                SizedBox.square(dimension: 10.h),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 14.0),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          width: 2.0,
                          color: Theme.of(context).primaryColorLight)),
                  child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 8.0),
                        child: Column(children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text("Ingresar la portada",
                                  style:
                                      Theme.of(context).textTheme.titleMedium)),
                          SizedBox(
                              height: 100.h,
                              width: 150.h,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _imagen == null
                                    ? Image.asset(
                                        'assets/images/default-image.jpg')
                                    : Image.file(_imagen!),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                  onPressed: () =>
                                      _selectImage(ImageSource.camera),
                                  icon: const Icon(Icons.camera_alt),
                                  label: const Text("Cámara")),
                              ElevatedButton.icon(
                                  onPressed: () =>
                                      _selectImage(ImageSource.gallery),
                                  icon: const Icon(Icons.image_search),
                                  label: const Text("Galería")),
                            ],
                          ),
                          TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: _novela.titulo,
                              onSaved: (value) {
                                //Este evento se ejecuta cuando el Form ha sido guardado localmente
                                _novela.titulo =
                                    value; //Asigna el valor del TextFormField al atributo del modelo
                              },
                              validator: (value) {
                                return validateString(value!);
                              },
                              decoration:
                                  const InputDecoration(labelText: "Titulo"),
                              maxLength: 50,
                              maxLines: 1),
                          TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: _novela.autor,
                              onSaved: (value) {
                                //Este evento se ejecuta cuando el Form ha sido guardado localmente
                                _novela.autor =
                                    value; //Asigna el valor del TextFormField al atributo del modelo
                              },
                              validator: (value) {
                                return validateString(value!);
                              },
                              decoration:
                                  const InputDecoration(labelText: "Autor"),
                              maxLength: 50,
                              maxLines: 1),
                          TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: _novela.descripcion,
                              onSaved: (value) {
                                //Este evento se ejecuta cuando el Form ha sido guardado localmente
                                _novela.descripcion =
                                    value; //Asigna el valor del TextFormField al atributo del modelo
                              },
                              validator: (value) {
                                return validateString(value!);
                              },
                              decoration: const InputDecoration(
                                  labelText: "Decripción"),
                              maxLength: 255,
                              maxLines: 2),
                          Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: Text("Fecha de publicación",
                                  style:
                                      Theme.of(context).textTheme.titleMedium)),
                          DatePickerWidget(
                              lastDate: DateTime.now(),
                              looping: false, // default is not looping
                              dateFormat: "dd-MMMM-yyyy",
                              locale: DatePicker.localeFromString('es'),
                              onChange: (DateTime newDate, _) {
                                _novela.fechaCreacion = DateFormat("dd/MM/yyyy")
                                    .format(newDate)
                                    .toString();
                              }),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: _onSaving
                                  ? const CircularProgressIndicator()
                                  : Tooltip(
                                      message: "Registrar novela",
                                      child: ElevatedButton.icon(
                                          onPressed: () {
                                            _sendForm();
                                          },
                                          label: const Text("Guardar"),
                                          icon: const Icon(Icons.save)),
                                    ))
                        ]),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _selectImage(ImageSource source) async {
    XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _imagen = File(pickedFile.path);
    } else {
      _imagen = null;
      //print('No image selected.');
    }
    setState(() {});
  }

  _sendForm() async {
    if (!_formKey.currentState!.validate()) return;

    _onSaving = true;
    setState(() {});

    _formKey.currentState!.save(); //Guarda el form localmente

    if (_imagen != null) {
      _novela.portada = await _novelaService.uploadImage(_imagen!);
    }

    //Invoca al servicio POST para enviar la Portada
    _novelasRef.add(_novela.toJson()).whenComplete(() => {
          _formKey.currentState!.reset(),
          _onSaving = false,
          Navigator.pop(context),
        });
  }
}
