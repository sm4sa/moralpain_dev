import 'package:flutter/material.dart';

class ScoreView extends StatelessWidget {
  const ScoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Score Route')),
      body: const Text('score route'),
    );
  }
}
