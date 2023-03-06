import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class DescubrirWidget extends StatelessWidget {
  const DescubrirWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.explore),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Descubrir'))
            ],
          ),
          backgroundColor: Palette.color,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.explore, size: 50.0),
              Text('Descubrir',
                  style: Theme.of(context).textTheme.headlineMedium)
            ],
          ),
        ));
  }
}
