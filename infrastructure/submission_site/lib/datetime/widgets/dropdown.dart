import 'package:flutter/material.dart';

abstract class Dropdown extends StatelessWidget {
  Dropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: DropdownButtonHideUnderline(
              child: buildFormField(context),
            ),
          ),
        ),
      ],
    );
  }

  DropdownButtonFormField buildFormField(BuildContext context);
}
