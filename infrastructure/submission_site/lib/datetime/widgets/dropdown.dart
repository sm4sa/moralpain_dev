import 'package:flutter/material.dart';
import 'package:submission_site/responsive.dart';

abstract class Dropdown extends StatelessWidget {
  Dropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? _landscapeView(context)
        : _portraitView(context);
  }

  Widget _portraitView(BuildContext context) {
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

  Widget _landscapeView(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: DropdownButtonHideUnderline(
          child: buildFormField(context),
        ),
      ),
    );
  }

  DropdownButtonFormField buildFormField(BuildContext context);
}
