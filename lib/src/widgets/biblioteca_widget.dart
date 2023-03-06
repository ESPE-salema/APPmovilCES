import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class BibliotecaWidget extends StatelessWidget {
  const BibliotecaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.book),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Biblioteca'))
            ],
          ),
          backgroundColor: Palette.color,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.book, size: 50.0),
              Text('Biblioteca',
                  style: Theme.of(context).textTheme.headlineMedium)
            ],
          ),
        ));
  }
}
