import 'package:flutter/material.dart';

class GeneroWidget extends StatelessWidget {
  const GeneroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.filter_none, size: 50.0),
          Text('Género', style: Theme.of(context).textTheme.headlineMedium)
        ],
      ),
    );
  }
}
