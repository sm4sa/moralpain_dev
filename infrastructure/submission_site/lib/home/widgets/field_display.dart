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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(width: 15.0),
        IconButton(onPressed: onPressed, icon: const Icon(Icons.edit)),
      ],
    );
  }
}
