import 'package:flutter/material.dart';
import 'package:app_movil_ces/src/widgets/biblioteca_widget.dart';
import 'package:app_movil_ces/src/widgets/descubrir_widget.dart';
import 'package:app_movil_ces/src/widgets/genero_widget.dart';
import 'package:app_movil_ces/src/widgets/novela_firebase_widget.dart';
import 'package:app_movil_ces/src/widgets/yo_widget.dart';

class ItemMenu {
  String title;
  IconData icon;
  ItemMenu(this.icon, this.title);
}

List<ItemMenu> menuOptions = [
  ItemMenu(Icons.home, "Inicio"),
  ItemMenu(Icons.filter_none, "Género"),
  ItemMenu(Icons.explore, "Descubrir"),
  ItemMenu(Icons.book, "Biblioteca"),
  ItemMenu(Icons.account_circle, "Yo"),
];

List<Widget> homeWidgets = [
  const NovelaFirebaseWidget(),
  const GeneroWidget(),
  const DescubrirWidget(),
  const BibliotecaWidget(),
  const YoWidget(),
];
