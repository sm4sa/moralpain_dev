import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumericalRangeField extends TextField {
  NumericalRangeField({Key? key, String? hintText})
      : super(
          inputFormatters: [
            NumericalRangeFormatter(),
          ],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            icon: Icon(Icons.assessment),
            hintText: hintText,
            border: InputBorder.none,
          ),
        );
}

class NumericalRangeFormatter extends TextInputFormatter {
  final int MIN = 0;
  final int MAX = 10;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    } else if (int.parse(newValue.text) < MIN) {
      return TextEditingValue().copyWith(text: MIN.toString());
    } else if (int.parse(newValue.text) > MAX) {
      return TextEditingValue().copyWith(text: MAX.toString());
    } else if (double.parse(newValue.text) -
            double.parse(newValue.text).floor() !=
        0) {
      return oldValue;
    } else {
      return newValue;
    }
  }
}
