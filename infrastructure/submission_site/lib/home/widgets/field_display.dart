import 'package:flutter/material.dart';

class FieldDisplay extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const FieldDisplay({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = (key as ValueKey).value;
    name = name.split('_')[1];
    return Wrap(
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(width: 15.0),
        IconButton(
          key: Key('fieldDisplay_${name}_iconButton'),
          onPressed: onPressed,
          icon: const Icon(Icons.edit),
        ),
      ],
    );
  }
}
