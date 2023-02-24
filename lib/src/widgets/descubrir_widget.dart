import 'package:flutter/material.dart';

class DescubrirWidget extends StatelessWidget {
  const DescubrirWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.explore, size: 50.0),
          Text('Descubrir', style: Theme.of(context).textTheme.headlineMedium)
        ],
      ),
    );
  }
}
