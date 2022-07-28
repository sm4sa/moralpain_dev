import 'package:flutter/material.dart';

class FieldDisplay extends StatelessWidget {
  final String text;

  const FieldDisplay({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(width: 15.0),
        IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
      ],
    );
  }
}
