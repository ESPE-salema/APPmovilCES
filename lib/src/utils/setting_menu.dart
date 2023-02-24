import 'package:flutter/material.dart';

class ItemMenu {
  String title;
  IconData icon;
  ItemMenu(this.icon, this.title);
}

List<ItemMenu> menuSettingOptions = [
  ItemMenu(Icons.home, "Yo"),
  ItemMenu(Icons.build, "Ajustes"),
  ItemMenu(Icons.cable, "Sobre nosotros"),
];
