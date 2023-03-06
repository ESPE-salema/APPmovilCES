import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class GeneroWidget extends StatelessWidget {
  const GeneroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.filter_none),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Genero'))
            ],
          ),
          backgroundColor: Palette.color,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.filter_none, size: 50.0),
              Text('Género', style: Theme.of(context).textTheme.headlineMedium)
            ],
          ),
        ));
  }
}
