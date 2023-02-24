import 'package:flutter/material.dart';

class BibliotecaWidget extends StatelessWidget {
  const BibliotecaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.book, size: 50.0),
          Text('Biblioteca', style: Theme.of(context).textTheme.headlineMedium)
        ],
      ),
    );
  }
}
