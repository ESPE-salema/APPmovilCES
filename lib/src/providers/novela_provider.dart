/*import 'package:flutter/material.dart';
import 'package:novelkaizen_project_lema_unda/src/models/novela_model.dart';

class NovelaProvider extends ChangeNotifier {
  List<Novela> elements = [];

  Future<Novela> addElement(Novela model) async {
    final id = await DBSQLProvider.dbProvider.insert(model);
    model.id = id;
    elements.add(model);
    notifyListeners();
    return model;
  }

  Future<List<Novela>> loadElements() async {
    elements = await DBSQLProvider.dbProvider.list();
    return elements;
  }
}*/